//
//  STBeautyView.m

//  Copyright © 2018年 STBeauty All rights reserved.
//

#import "STBeautyView.h"

#import "STParamUtil.h"
#import "STBeautyValueCache.h"
#import "STBeautyFeatureModel.h"

#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>
#import <CoreMotion/CoreMotion.h>
#import <OpenGLES/ES2/glext.h>

//ST_MOBILE
#import "st_mobile_sticker.h"
#import "st_mobile_beautify.h"
#import "st_mobile_face_attribute.h"
#import "st_mobile_filter.h"
#import "st_mobile_object.h"
#import "st_mobile_avatar.h"
#import "st_mobile_makeup.h"

#import "STMobileLog.h"
#import "STLicHelper.h"


#ifndef ST_PERFORMANCE_HINT_T_IOS
#define ST_PERFORMANCE_HINT_T_IOS 0
#endif


#define DROP_FRAME_LIMIT 5 // 前后台切换等一起相机重新捕捉画面时，丢弃开始几帧，因为会有屏闪
#define CAMERA_FPS 18 // 相机每秒采集帧率

// pk时，视图的高宽比例
#define PKStreamViewHeightWidthRatio (480/320.f)

// pk时，推流视图的高度
#define PKStreamViewHeight (CGRectGetWidth([UIScreen mainScreen].bounds)/2.f * PKStreamViewHeightWidthRatio)


@interface STBeautyView ()<STCameraDelegate,UIGestureRecognizerDelegate>
{
    st_handle_t _hSticker;  // sticker句柄
    st_handle_t _hDetector; // detector句柄
    st_handle_t _hBeautify; // beautify句柄
    st_handle_t _hFilter;   // filter句柄
    st_handle_t _avatarHandle; //avatar expression
    st_mobile_animal_face_t *_detectResult1;
    
    st_handle_t _hBmpHandle;
    
    CVOpenGLESTextureCacheRef _cvTextureCache;
    
    CVOpenGLESTextureRef _cvTextureOrigin;
    CVOpenGLESTextureRef _cvTextureBeautify;
    CVOpenGLESTextureRef _cvTextureSticker;
    CVOpenGLESTextureRef _cvTextureFilter;
    CVOpenGLESTextureRef _cvTextureMakeup;
    
    CVPixelBufferRef _cvBeautifyBuffer;
    CVPixelBufferRef _cvStickerBuffer;
    CVPixelBufferRef _cvFilterBuffer;
    CVPixelBufferRef _cvMakeUpBuffer;
    
    GLuint _textureOriginInput;
    GLuint _textureBeautifyOutput;
    GLuint _textureStickerOutput;
    GLuint _textureFilterOutput;
    GLuint _textureMakeUpOutput;
    
    BOOL _fullScreenLayout;
    CMSampleBufferRef _lastSampleBufferRef;
    
    NSInteger _currentDropCount;
    BOOL _cameraActive;
}
@property (nonatomic, strong) EAGLContext *glContext;
@property (nonatomic, strong) CIContext *ciContext;

@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, assign) UIDeviceOrientation deviceOrientation;

@property (nonatomic, assign) BOOL bSticker;
@property (nonatomic, assign) BOOL bFilter;
@property (atomic, assign) BOOL isNullSticker;

@property (atomic, readwrite, assign) BOOL pauseOutput;
@property (nonatomic, readwrite, assign) BOOL isAppActive;

@property (nonatomic, assign) BOOL needDetectAnimal;

@property (nonatomic, copy) NSString *preFilterModelPath;
@property (nonatomic, copy) NSString *curFilterModelPath;

@property (nonatomic, assign) int iBufferedCount;
@property (nonatomic, assign) double lastTimeAttrDetected;

@property (nonatomic, readwrite, assign) unsigned long long iCurrentAction;
@property (nonatomic, readwrite, assign) unsigned long long makeUpConf;
@property (nonatomic, readwrite, assign) unsigned long long stickerConf;

@property (nonatomic, assign) BOOL bExposured;
@property (nonatomic, assign) CGFloat scale;  //视频充满全屏的缩放比例
@property (nonatomic, assign) int margin;
@property (nonatomic, assign) CGPoint previewCenter;
@property (nonatomic, assign) CGRect previewFrame;

@property (nonatomic) dispatch_queue_t renderQueue;
@property (nonatomic, strong) UIImageView *focusImageView;

@end


@implementation STBeautyView

- (void)dealloc {
    
    [self destory];
    [self releaseResources];
    [NSNotificationCenter.defaultCenter removeObserver:self];

    
}

- (void)destory {
    
    _stCamera.delegate = nil;
    [_stCamera stopRunning];
    _stCamera = nil;
    
    [_motionManager stopAccelerometerUpdates];
    _motionManager = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    _isAppActive = NO; // 停止采集
    _delegate = nil;
    
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self initDefault];
    }
    
    return self;
}
- (instancetype)initWithVideoPhone:(NSString*)sessionPreset {
    self = [super init];
    if (self) {
        [self initDefault];
        self.currentSessionPreset = sessionPreset;
    }
    
    return self;
}
- (void)initDefault{
    
    _currentDropCount = DROP_FRAME_LIMIT;// 初始的时候，不丢弃前几帧，因为在准备开播
    if ([STLicHelper checkLicense]) {

        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
        
        [self addNotifications];
        
        [self setDefaultValue];
        
        [self initResourceAndStartPreview];

        [self setCachFilter];
        
        
    } else{
        NSLog(@"使用 license 文件生成激活码时失败，可能是授权文件过期。");
    }
}

- (void)setDefaultValue {
    
    _bFilter = NO; // 滤镜关闭
    _bSticker = NO;// 贴纸开关
    
    self.pauseOutput = NO;
    self.isAppActive = YES;
    
    self.isNullSticker = NO;
    if ([self.currentSessionPreset isEqualToString:AVCaptureSessionPreset640x480]) {
        self.imageWidth  = 480;
        self.imageHeight = 640;
    }else {
        self.imageWidth  = 720;
        self.imageHeight = 1280;
        self.currentSessionPreset = kDefaultSTCameraAVCaptureSessionPreset;//;
    }
    self.renderQueue = dispatch_queue_create("com.sensetime.renderQueue", NULL);
    
    self.preFilterModelPath = nil;
    self.curFilterModelPath = nil;
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = 0.5;
    self.motionManager.deviceMotionUpdateInterval = 1 / 25.0;
    
}

/// 如果滤镜有缓存 ,则立即设置滤镜
- (void)setCachFilter {
    
    if ([STBeautyValueCache sharedCache].filterSuite.filterModelPath.length > 0) {
        STBeautyFeatureModel* model = [[STBeautyValueCache sharedCache] getFilterDataModel];
        if (model) {
            [self handleFilterChanged:model];
        }
    }
}

//
- (void)setCurrentSessionPreset:(NSString *)currentSessionPreset {
    
    if ([_currentSessionPreset isEqualToString:currentSessionPreset] == NO) {
        _stCamera.sessionPreset = currentSessionPreset;
        _currentSessionPreset = [currentSessionPreset copy];
        self.bExposured = NO;
    }
    [self.stCamera setExposurePoint:self.previewCenter inPreviewFrame:self.previewFrame];
}

- (void)configPreviewFullScreenLayout:(BOOL)isFullScreen {
    
    _fullScreenLayout = isFullScreen;
    
    CGFloat width  = STScreenWidth;
    CGFloat height = STScreenHeight;
    
    if (isFullScreen == NO) {
        width  = width/2.f;
        height = PKStreamViewHeight;
    }
    
    [self resetPreviewWith:width height:height];
}
/// 设置视频通话预览的采集大小
/// @param isVideoPhoneSmall _
- (void)configVideoPhonePreviewLayout:(BOOL)isVideoPhoneSmall {
    
    _fullScreenLayout = !isVideoPhoneSmall;
    CGFloat width  = STScreenWidth;
    CGFloat height = STScreenHeight;
    if (isVideoPhoneSmall) {
        width = 125;
        height = 170;
    }
    [self resetPreviewWith:width height:height];
}

//
- (void)initResourceAndStartPreview {
    
    ///ST_MOBILE：设置预览时需要注意 EAGLContext 的初始化
    [self setupCameraAndPreview];
    
    // 设置SDK OpenGL 环境 , 只有在正确的 OpenGL 环境下 SDK 才会被正确初始化 .
    self.ciContext = [CIContext contextWithEAGLContext:self.glContext
                                               options:@{kCIContextWorkingColorSpace : [NSNull null]}];
    
    [EAGLContext setCurrentContext:self.glContext];
    
    // 初始化结果文理及纹理缓存
    CVReturn err = CVOpenGLESTextureCacheCreate(kCFAllocatorDefault, NULL, self.glContext, NULL, &_cvTextureCache);
    
    if (err) {
        NSLog(@"CVOpenGLESTextureCacheCreate %d" , err);
    }
    
    [self initResultTexture];
    
    ///ST_MOBILE：初始化句柄之前需要验证License
    ///ST_MOBILE：初始化相关的句柄
    [self setupHandle];
    
    if ([self.motionManager isAccelerometerAvailable]) {
        [self.motionManager startAccelerometerUpdates];
    }
    
    if ([self.motionManager isDeviceMotionAvailable]) {
        [self.motionManager startDeviceMotionUpdates];
    }
    
    self.pauseOutput = NO;
    
    self.stCamera.sessionPreset = self.currentSessionPreset;
    [self.stCamera startRunning];
 
}

- (void)setupCameraAndPreview {
    
    int fps = CAMERA_FPS;
    
    _stCamera = [[STCamera alloc] initWithDevicePosition:AVCaptureDevicePositionFront
                                          sessionPresset:self.currentSessionPreset
                                                     fps:fps
                                           needYuvOutput:NO];
    
    self.stCamera.sessionPreset = self.currentSessionPreset;
    self.stCamera.delegate = self;
    self.stCamera.iFPS = fps;
    
    
    self.glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    [self configPreviewFullScreenLayout:YES];
    
}

//
- (void)resetPreviewWith:(CGFloat)width height:(CGFloat)height {
    CGRect previewRect = [self.stCamera getZoomedRectWithRect:CGRectMake(0 , 0 , width, height)
                                                   scaleToFit:NO];
    if (self.glPreview.superview == nil) {
        EAGLContext *previewContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2
                                                            sharegroup:self.glContext.sharegroup];
        @synchronized (self) {
           _glPreview = [[STGLPreview alloc] initWithFrame:previewRect context:previewContext];
        }
        [self insertSubview:_glPreview atIndex:0];
    }
    [self.glPreview setFrame:previewRect];
    self.previewCenter = self.glPreview.center;
    self.previewFrame  = previewRect;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    _glPreview.center = CGPointMake(CGRectGetWidth(self.frame)/2.f, CGRectGetHeight(self.frame)/2.f);
}


//
- (void)releaseResources {
    
    if ([EAGLContext currentContext] != self.glContext) {
        [EAGLContext setCurrentContext:self.glContext];
    }
    
    if (_hSticker) {
        st_mobile_sticker_destroy(_hSticker);
        _hSticker = NULL;
    }
    
    if (_avatarHandle) {
        st_mobile_avatar_destroy(_avatarHandle);
        _hSticker = NULL;
    }
    
    if (_hBeautify) {
        st_mobile_beautify_destroy(_hBeautify);
        _hBeautify = NULL;
    }
    
    if (_hDetector) {
        st_mobile_human_action_destroy(_hDetector);
        _hDetector = NULL;
    }
    
    if (_hBmpHandle) {
        st_mobile_makeup_destroy(_hBmpHandle);
        _hBmpHandle = NULL;
    }
    
    if (_hFilter) {
        st_mobile_gl_filter_destroy(_hFilter);
        _hFilter = NULL;
    }
    
    [self releaseResultTexture];
    
    if (_cvTextureCache) {
        
        CFRelease(_cvTextureCache);
        _cvTextureCache = NULL;
    }
    
    //    glFinish();
    
    [EAGLContext setCurrentContext:nil];
    self.glContext = nil;
    
    //    __weak __typeof__(self) weakSelf = self;
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //
    //        STBeautyView *tmp = weakSelf;
    //    });
    
    [self.glPreview removeFromSuperview];
    self->_glPreview = nil;
    
    self.ciContext = nil;
    
}

- (void)dropSomeFrameWhenModifyRevolution {
    _currentDropCount = 0;
}


#pragma mark - handle system notifications

- (void)addNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveFilterNotice:) name:kNotificationSelectBeautyFilter object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(filterSliderValueChanged:) name:kNotificationBeautyFilterValueChange object:nil];
    
}
  
//
- (void)appWillResignActive {
    self.isAppActive = NO;
    self.pauseOutput = YES;
    _currentDropCount = 0;
 }

- (void)appDidEnterBackground {
    
    self.isAppActive = NO;
    _currentDropCount = 0;
    
}

- (void)appWillEnterForeground {
    
    self.isAppActive = YES;
}

- (void)appDidBecomeActive {
    
    self.pauseOutput = NO;
    self.isAppActive = YES;
    
    _cameraActive = NO;
//    [self performSelector:@selector(checkCameraActive) withObject:nil afterDelay:0.15];
    
}

//
- (void)checkCameraActive {
    if (self.isAppActive && self.pauseOutput == NO) {
        if (!_cameraActive) {
            [_stCamera stopRunning];
            [_stCamera startRunning];
        }
    }
}


#pragma mark -
- (void)getDeviceOrientation:(CMAccelerometerData *)accelerometerData {
    
    if (accelerometerData.acceleration.x >= 0.75) {
        _deviceOrientation = UIDeviceOrientationLandscapeRight;
    } else if (accelerometerData.acceleration.x <= -0.75) {
        _deviceOrientation = UIDeviceOrientationLandscapeLeft;
    } else if (accelerometerData.acceleration.y <= -0.75) {
        _deviceOrientation = UIDeviceOrientationPortrait;
    } else if (accelerometerData.acceleration.y >= 0.75) {
        _deviceOrientation = UIDeviceOrientationPortraitUpsideDown;
    } else {
        _deviceOrientation = UIDeviceOrientationPortrait;
    }
}

- (st_rotate_type)getRotateType {
    
    BOOL isFrontCamera = self.stCamera.devicePosition == AVCaptureDevicePositionFront;
    BOOL isVideoMirrored = self.stCamera.videoConnection.isVideoMirrored;
    
    [self getDeviceOrientation:self.motionManager.accelerometerData];
    
    switch (_deviceOrientation) {
            
        case UIDeviceOrientationPortrait:
            return ST_CLOCKWISE_ROTATE_0;
            
        case UIDeviceOrientationPortraitUpsideDown:
            return ST_CLOCKWISE_ROTATE_180;
            
        case UIDeviceOrientationLandscapeLeft:
            return ((isFrontCamera && isVideoMirrored) || (!isFrontCamera && !isVideoMirrored)) ? ST_CLOCKWISE_ROTATE_270 : ST_CLOCKWISE_ROTATE_90;
            
        case UIDeviceOrientationLandscapeRight:
            return ((isFrontCamera && isVideoMirrored) || (!isFrontCamera && !isVideoMirrored)) ? ST_CLOCKWISE_ROTATE_90 : ST_CLOCKWISE_ROTATE_270;
            
        default:
            return ST_CLOCKWISE_ROTATE_0;
    }
}


#pragma mark - setup handle
- (void)setupHandle {
    
    st_result_t iRet = ST_OK;
    
    //初始化检测模块句柄
    
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"STBeauty" ofType:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    NSString *strModelPath = [resourceBundle pathForResource:@"M_SenseME_Face_Video_5.3.4" ofType:@"model"];

    
    uint32_t config = ST_MOBILE_HUMAN_ACTION_DEFAULT_CONFIG_VIDEO;
    
    iRet = st_mobile_human_action_create(strModelPath.UTF8String, config, &_hDetector);
    
    if (ST_OK != iRet || !_hDetector) {
        NSLog(@"st mobile human action create failed: %d", iRet);
        NSLog(@"算法SDK初始化失败，可能是模型路径错误，SDK权限过期，与绑定包名不符" );
    }
    
    
    //初始化贴纸模块句柄 , 默认开始时无贴纸 , 所以第一个路径参数传空
    iRet = st_mobile_sticker_create(&_hSticker);
    
    if (ST_OK != iRet || !_hSticker) {
        NSLog(@"st mobile sticker create failed: %d", iRet);
        NSLog(@"贴纸SDK初始化失败 , SDK权限过期，或者与绑定包名不符");
        
    } else {
        //设置性能/效果优先级
        iRet = st_mobile_sticker_set_performance_hint(_hSticker, ST_PERFORMANCE_HINT_T_IOS);
        
    }
    
 
    //初始化美颜模块句柄
    iRet = st_mobile_beautify_create(&_hBeautify);
    
    if (ST_OK != iRet || !_hBeautify) {
        
        NSLog(@"st mobile beautify create failed: %d", iRet);
        NSLog(@"美颜SDK初始化失败，可能是模型路径错误，SDK权限过期，与绑定包名不符");
    }else{
        
#if 1
        [self setupBeautyParam];
#endif
        
    }
    
    // 初始化滤镜句柄
    iRet = st_mobile_gl_filter_create(&_hFilter);
    
    if (ST_OK != iRet || !_hFilter) {
        NSLog(@"st mobile gl filter create failed: %d", iRet);
        NSLog(@"滤镜SDK初始化失败，可能是SDK权限过期或与绑定包名不符");
    }
    
    
    //create beautyMakeUp handle
    iRet = st_mobile_makeup_create(&_hBmpHandle);
    
    if (ST_OK != iRet || !_hBmpHandle) {
        NSLog(@"st mobile object makeup create failed: %d", iRet);
        NSLog(@"美妆SDK初始化失败，可能是SDK权限过期或与绑定包名不符");
    }else{
        //配置性能/效果优先级
        iRet = st_mobile_makeup_set_performance_hint(_hBmpHandle, ST_PERFORMANCE_HINT_T_IOS);
    }
    
}


#pragma mark - handle texture
- (void)initResultTexture {
    // 创建结果纹理
    [self setupTextureWithPixelBuffer:&_cvBeautifyBuffer
                                    w:self.imageWidth
                                    h:self.imageHeight
                            glTexture:&_textureBeautifyOutput
                            cvTexture:&_cvTextureBeautify];
    
    [self setupTextureWithPixelBuffer:&_cvStickerBuffer
                                    w:self.imageWidth
                                    h:self.imageHeight
                            glTexture:&_textureStickerOutput
                            cvTexture:&_cvTextureSticker];
    
    [self setupTextureWithPixelBuffer:&_cvFilterBuffer
                                    w:self.imageWidth
                                    h:self.imageHeight
                            glTexture:&_textureFilterOutput
                            cvTexture:&_cvTextureFilter];
    
    [self setupTextureWithPixelBuffer:&_cvMakeUpBuffer
                                    w:self.imageWidth
                                    h:self.imageHeight
                            glTexture:&_textureMakeUpOutput
                            cvTexture:&_cvTextureMakeup];
    
}

- (BOOL)setupTextureWithPixelBuffer:(CVPixelBufferRef *)pixelBufferOut
                                  w:(int)iWidth
                                  h:(int)iHeight
                          glTexture:(GLuint *)glTexture
                          cvTexture:(CVOpenGLESTextureRef *)cvTexture {
    
    CFDictionaryRef empty = CFDictionaryCreate(kCFAllocatorDefault,
                                               NULL,
                                               NULL,
                                               0,
                                               &kCFTypeDictionaryKeyCallBacks,
                                               &kCFTypeDictionaryValueCallBacks);
    
    CFMutableDictionaryRef attrs = CFDictionaryCreateMutable(kCFAllocatorDefault,
                                                             1,
                                                             &kCFTypeDictionaryKeyCallBacks,
                                                             &kCFTypeDictionaryValueCallBacks);
    
    CFDictionarySetValue(attrs, kCVPixelBufferIOSurfacePropertiesKey, empty);
    
    CVReturn cvRet = CVPixelBufferCreate(kCFAllocatorDefault,
                                         iWidth,
                                         iHeight,
                                         kCVPixelFormatType_32BGRA,
                                         attrs,
                                         pixelBufferOut);
    
    if (kCVReturnSuccess != cvRet) {
        
        NSLog(@"CVPixelBufferCreate %d" , cvRet);
    }
    
    cvRet = CVOpenGLESTextureCacheCreateTextureFromImage(kCFAllocatorDefault,
                                                         _cvTextureCache,
                                                         *pixelBufferOut,
                                                         NULL,
                                                         GL_TEXTURE_2D,
                                                         GL_RGBA,
                                                         self.imageWidth,
                                                         self.imageHeight,
                                                         GL_BGRA,
                                                         GL_UNSIGNED_BYTE,
                                                         0,
                                                         cvTexture);
    
    CFRelease(attrs);
    CFRelease(empty);
    
    if (kCVReturnSuccess != cvRet) {
        
        NSLog(@"CVOpenGLESTextureCacheCreateTextureFromImage %d" , cvRet);
        return NO;
    }
    
    *glTexture = CVOpenGLESTextureGetName(*cvTexture);
    glBindTexture(CVOpenGLESTextureGetTarget(*cvTexture), *glTexture);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glBindTexture(GL_TEXTURE_2D, 0);
    
    return YES;
}

- (BOOL)setupOriginTextureWithPixelBuffer:(CVPixelBufferRef)pixelBuffer {
    
    CVReturn cvRet = CVOpenGLESTextureCacheCreateTextureFromImage(kCFAllocatorDefault,
                                                                  _cvTextureCache,
                                                                  pixelBuffer,
                                                                  NULL,
                                                                  GL_TEXTURE_2D,
                                                                  GL_RGBA,
                                                                  self.imageWidth,
                                                                  self.imageHeight,
                                                                  GL_BGRA,
                                                                  GL_UNSIGNED_BYTE,
                                                                  0,
                                                                  &_cvTextureOrigin);
    
    if (!_cvTextureOrigin || kCVReturnSuccess != cvRet) {
        
        NSLog(@"CVOpenGLESTextureCacheCreateTextureFromImage %d" , cvRet);
        
        return NO;
    }
    
    _textureOriginInput = CVOpenGLESTextureGetName(_cvTextureOrigin);
    glBindTexture(GL_TEXTURE_2D , _textureOriginInput);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glBindTexture(GL_TEXTURE_2D, 0);
    
    return YES;
}

- (void)releaseResultTexture {
    
    _textureBeautifyOutput = 0;
    _textureStickerOutput = 0;
    _textureFilterOutput = 0;
    _textureMakeUpOutput = 0;
    
    if (_cvTextureOrigin)    {CFRelease(_cvTextureOrigin); _cvTextureOrigin = NULL;}
    if (_cvTextureBeautify)  {CFRelease(_cvTextureBeautify); _cvTextureBeautify = NULL;}
    if (_cvTextureSticker)   {CFRelease(_cvTextureSticker);  _cvTextureSticker = NULL;}
    if (_cvTextureFilter)    {CFRelease(_cvTextureFilter);  _cvTextureFilter = NULL;}
    if (_cvTextureMakeup)    {CFRelease(_cvTextureMakeup);  _cvTextureMakeup = NULL;}
    
    if (_cvBeautifyBuffer) CVPixelBufferRelease(_cvBeautifyBuffer);
    if (_cvStickerBuffer)  CVPixelBufferRelease(_cvStickerBuffer);
    if (_cvFilterBuffer)   CVPixelBufferRelease(_cvFilterBuffer);
    if (_cvMakeUpBuffer)   CVPixelBufferRelease(_cvMakeUpBuffer);
}

#pragma mark - handler

/// 选择滤镜通知,变更滤镜
/// @param notice _
- (void)receiveFilterNotice:(NSNotification*) notice {
    if ([notice.object isKindOfClass:[STBeautyFeatureModel class]]) {
        STBeautyFeatureModel* model = (STBeautyFeatureModel*)notice.object;
        [self handleFilterChanged:model];
    }
}

- (void)handleFilterChanged:(STBeautyFeatureModel *)model {
    
    if ([EAGLContext currentContext] != self.glContext) {
        [EAGLContext setCurrentContext:self.glContext];
    }
    self.bFilter = model.strPath.length > 0;
    // 切换滤镜
    if (_hFilter) {
        
        self.pauseOutput = YES;
        
        self.curFilterModelPath = model.strPath;
        NSLog(@"当前设置的滤镜%@强度:%.2f",self.curFilterModelPath,model.beautyValue);
        st_result_t iRet = ST_OK;
        iRet = st_mobile_gl_filter_set_param(_hFilter, ST_GL_FILTER_STRENGTH, model.beautyValue);
        if (iRet != ST_OK) {
            NSLog(@"st_mobile_gl_filter_set_param %d" , iRet);
        }
    }
    
    self.pauseOutput = NO;
}

- (void)filterSliderValueChanged:(NSNotification*) notice {
    STBeautyFeatureModel* model = (STBeautyFeatureModel*)notice.object;
    if (_hFilter) {
        NSLog(@"当前设置的滤镜强度:%.2f",model.beautyValue);
        st_result_t iRet = ST_OK;
        iRet = st_mobile_gl_filter_set_param(_hFilter, ST_GL_FILTER_STRENGTH, model.beautyValue);
        if (ST_OK != iRet) {
            NSLog(@"st_mobile_gl_filter_set_param %d" , iRet);
        }
    }
}



#pragma mark - STCameraDelegate
// 设置SDK美颜参数
- (void)setupBeautyParam {
    
    if (!_hBeautify) return;
    
    STBeautySuiteValueModel *beautyValueCache = STBeautyValueCache.sharedCache.currentBeautySuite;
    
    // 设置美白参数
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_WHITEN_STRENGTH, beautyValueCache.fWhitenStrength);
    // 设置默认红润参数
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_REDDEN_STRENGTH, beautyValueCache.fReddenStrength);
    // 设置默认磨皮参数
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_SMOOTH_STRENGTH, beautyValueCache.fSmoothStrength);
    
    // 设置默认大眼参数
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_ENLARGE_EYE_RATIO, beautyValueCache.fEnlargeEyeStrength);
    // 设置默认瘦脸参数
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_SHRINK_FACE_RATIO, beautyValueCache.fShrinkFaceStrength);
    // 设置小脸参数
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_SHRINK_JAW_RATIO, beautyValueCache.fShrinkJawStrength);
    
    //瘦脸型
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_3D_THIN_FACE_SHAPE_RATIO, beautyValueCache.fThinFaceShapeStrength);
    //窄脸
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_NARROW_FACE_STRENGTH, beautyValueCache.fNarrowFaceStrength);
    //圆眼
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_ROUND_EYE_RATIO, beautyValueCache.fRoundEyeStrength);
    //下巴
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_3D_CHIN_LENGTH_RATIO,
                     rangeMappedValueFrom(beautyValueCache.fChinStrength));
    //额头
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_3D_HAIRLINE_HEIGHT_RATIO,
                     rangeMappedValueFrom(beautyValueCache.fHairLineStrength));
    //瘦鼻翼
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_3D_NARROW_NOSE_RATIO, beautyValueCache.fNarrowNoseStrength);
    //长鼻
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_3D_NOSE_LENGTH_RATIO,
                     rangeMappedValueFrom(beautyValueCache.fLongNoseStrength));
    //嘴形
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_3D_MOUTH_SIZE_RATIO,
                     rangeMappedValueFrom(beautyValueCache.fMouthStrength));
    //缩人中
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_3D_PHILTRUM_LENGTH_RATIO,
                     rangeMappedValueFrom(beautyValueCache.fPhiltrumStrength));
    
    
    //设置对比度参数
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_CONTRAST_STRENGTH, beautyValueCache.fContrastStrength);
    //设置饱和度参数
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_SATURATION_STRENGTH, beautyValueCache.fSaturationStrength);
    //锐化参数
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_SHARPEN_STRENGTH, beautyValueCache.fSharpenStrength);
    
    
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_3D_APPLE_MUSLE_RATIO, beautyValueCache.fAppleMusleStrength);
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_3D_PROFILE_RHINOPLASTY_RATIO, beautyValueCache.fProfileRhinoplastyStrength);
    
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_3D_EYE_DISTANCE_RATIO,
                     rangeMappedValueFrom(beautyValueCache.fEyeDistanceStrength));
    
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_3D_EYE_ANGLE_RATIO,
                     rangeMappedValueFrom(beautyValueCache.fEyeAngleStrength));
    
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_3D_OPEN_CANTHUS_RATIO, beautyValueCache.fOpenCanthusStrength);
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_3D_BRIGHT_EYE_RATIO, beautyValueCache.fBrightEyeStrength);
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_3D_REMOVE_DARK_CIRCLES_RATIO, beautyValueCache.fRemoveDarkCirclesStrength);
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_3D_REMOVE_NASOLABIAL_FOLDS_RATIO, beautyValueCache.fRemoveNasolabialFoldsStrength);
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_3D_WHITE_TEETH_RATIO, beautyValueCache.fWhiteTeethStrength);
    setBeautifyParam(_hBeautify, ST_BEAUTIFY_SHRINK_CHEEKBONE_RATIO, beautyValueCache.fShrinkCheekboneStrength);
}


void copyCatFace(st_mobile_animal_face_t *src, int faceCount, st_mobile_animal_face_t *dst) {
    memcpy(dst, src, sizeof(st_mobile_animal_face_t) * faceCount);
    for (int i = 0; i < faceCount; ++i) {
        
        size_t key_points_size = sizeof(st_pointf_t) * src[i].key_points_count;
        st_pointf_t *p_key_points = malloc(key_points_size);
        memset(p_key_points, 0, key_points_size);
        memcpy(p_key_points, src[i].p_key_points, key_points_size);
        
        dst[i].p_key_points = p_key_points;
    }
}

void freeCatFace(st_mobile_animal_face_t *src, int faceCount) {
    if (faceCount > 0) {
        for (int i = 0; i < faceCount; ++i) {
            if (src[i].p_key_points != NULL) {
                free(src[i].p_key_points);
                src[i].p_key_points = NULL;
            }
        }
        free(src);
        src = NULL;
    }
}


- (void)callbackDelegateWithSampleBuffer:(CMSampleBufferRef)originalSampleBuffer
                       resultPixelBuffer:(CVPixelBufferRef)resultPixelBufffer {
    
    if ( originalSampleBuffer && resultPixelBufffer ) {
        
        CVPixelBufferRef copyBuffer = [self RBGBuffereCopyWithPixelBuffer:resultPixelBufffer];
        
        id<STBeautyProcessProtocol> tmpDelegate = self.delegate;
        
        //
        if ([tmpDelegate respondsToSelector:@selector(stVideoBeautyView:didProcessVideoSampleBuffer:)]) {
            [tmpDelegate stVideoBeautyView:self didProcessVideoSampleBuffer:copyBuffer];
        }
        
        //
        if (tmpDelegate && [tmpDelegate respondsToSelector:@selector(stBeautyView:didProcessSampleBuffer:)]) {
            
            CMTime timestamp = CMSampleBufferGetPresentationTimeStamp(originalSampleBuffer);
            CMSampleBufferRef sampleBuffer = NULL;
            
            CMSampleTimingInfo timingInfo = {0,};
            timingInfo.duration = kCMTimeInvalid;
            timingInfo.decodeTimeStamp = kCMTimeInvalid;
            timingInfo.presentationTimeStamp = timestamp;
            
            CMVideoFormatDescriptionRef videoInfo = NULL;
            CMVideoFormatDescriptionCreateForImageBuffer(NULL, copyBuffer, &videoInfo);
            
            // OSStatus err =
            CMSampleBufferCreateForImageBuffer(kCFAllocatorDefault, copyBuffer, true, NULL, NULL, videoInfo, &timingInfo, &sampleBuffer);
            CFRelease(videoInfo);
            
            if (sampleBuffer) {
                [tmpDelegate stBeautyView:self didProcessSampleBuffer:sampleBuffer];
            }
            CFRelease(sampleBuffer);
        }
        CVPixelBufferUnlockBaseAddress(copyBuffer, 0);
        CFRelease(copyBuffer);  
    }
}

- (CVPixelBufferRef)RBGBuffereCopyWithPixelBuffer:(CVPixelBufferRef)pixelBuffer {
    
    // Get pixel buffer info
    CVPixelBufferLockBaseAddress(pixelBuffer, 0);
    int bufferWidth = (int)CVPixelBufferGetWidth(pixelBuffer);
    int bufferHeight = (int)CVPixelBufferGetHeight(pixelBuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer);
    uint8_t *baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer);
    
    // Copy the pixel buffer
    CVPixelBufferRef pixelBufferCopy = NULL;
    CFDictionaryRef empty = CFDictionaryCreate(kCFAllocatorDefault, NULL, NULL, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks); // our empty IOSurface properties dictionary
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey,
                             empty, kCVPixelBufferIOSurfacePropertiesKey,
                             nil];
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, bufferWidth, bufferHeight, kCVPixelFormatType_32BGRA, (__bridge CFDictionaryRef) options, &pixelBufferCopy);
    if (status == kCVReturnSuccess) {
        CVPixelBufferLockBaseAddress(pixelBufferCopy, 0);
       uint8_t *copyBaseAddress = CVPixelBufferGetBaseAddress(pixelBufferCopy);
       memcpy(copyBaseAddress, baseAddress, bufferHeight * bytesPerRow);
    }else {
        NSLog(@"RBGBuffereCopyWithPixelBuffer :: failed");
    }

    CVPixelBufferUnlockBaseAddress(pixelBufferCopy, 0);
    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);

    return pixelBufferCopy;
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    _cameraActive = YES;
    
    if (!self.isAppActive) {
        return;
    }
    
    if (self.pauseOutput) {
        return;
    }
    
    //    if (self.iBufferedCount >= 2) {
    //        return;
    //    }
    
    //get pts
    // _timestamp = CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
    
    
    BOOL callBackFlag = YES;
    
    if (_currentDropCount < DROP_FRAME_LIMIT) {
        _currentDropCount ++;
        callBackFlag = NO;
    }
    
    
    TIMELOG(frameCostKey);
    
    //获取每一帧图像信息
    CVPixelBufferRef pixelBuffer = (CVPixelBufferRef)CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(pixelBuffer, 0);
    
    unsigned char* pBGRAImageIn = (unsigned char*)CVPixelBufferGetBaseAddress(pixelBuffer);
    // double dCost  = 0.0;
    // double dStart = CFAbsoluteTimeGetCurrent();
    
    int iBytesPerRow = (int)CVPixelBufferGetBytesPerRow(pixelBuffer);
    int iWidth       = (int)CVPixelBufferGetWidth(pixelBuffer);
    int iHeight      = (int)CVPixelBufferGetHeight(pixelBuffer);
    
    size_t iTop , iBottom , iLeft , iRight;
    CVPixelBufferGetExtendedPixels(pixelBuffer, &iLeft, &iRight, &iTop, &iBottom);
    
    iWidth = iWidth + (int)iLeft + (int)iRight;
    iHeight = iHeight + (int)iTop + (int)iBottom;
    iBytesPerRow = iBytesPerRow + (int)iLeft + (int)iRight;
    
    _scale = MAX(STScreenHeight / iHeight, STScreenWidth / iWidth);
    _margin = (iWidth * _scale - STScreenWidth) / 2;
    
    st_rotate_type stMobileRotate = [self getRotateType];
    
    st_mobile_human_action_t detectResult;
    memset(&detectResult, 0, sizeof(st_mobile_human_action_t));
    
    // 如果需要做属性,每隔一秒做一次属性
    double dTimeNow = CFAbsoluteTimeGetCurrent();
    BOOL isAttributeTime = (dTimeNow - self.lastTimeAttrDetected) >= 1.0;
    
    if (isAttributeTime) {
        self.lastTimeAttrDetected = dTimeNow;
    }
    
    
    int catFaceCount = -1;
    
    ///ST_MOBILE 人脸信息检测部分
    if (_hDetector) {
        
        BOOL needFaceDetection =  YES;;
        if (needFaceDetection) {
            self.iCurrentAction = ST_MOBILE_FACE_DETECT | self.makeUpConf | self.stickerConf;
        } else {
            self.iCurrentAction = self.makeUpConf | self.stickerConf;
        }
        
        if (self.iCurrentAction > 0) {
            
            st_result_t iRet = st_mobile_human_action_detect(_hDetector, pBGRAImageIn, ST_PIX_FMT_BGRA8888, iWidth, iHeight, iBytesPerRow, stMobileRotate, self.iCurrentAction, &detectResult);
            
#if 0 // 自动曝光调整
            if (detectResult.face_count > 0 && NO == self.bExposured) {
                
                [self.stCamera setExposurePoint:self.previewCenter inPreviewFrame:self.previewFrame];
                
                [self.stCamera setISOValue:140];
                
                self.bExposured = YES; //
            }
            
            //   if (!detectResult.face_count) {
            //       self.bExposured = NO;
            //   }
#endif
            
            
            if(iRet == ST_OK) {
                // 获取avatar表情参数，该接口只会处理一张人脸信息，结果信息会以数组形式返回，
                // 数组下标对应的表情在ST_AVATAR_EXPRESSION_INDEX枚举中
                if (detectResult.face_count > 0) {
                    float expression[ST_AVATAR_EXPRESSION_NUM] = {0.0};
                    
                    iRet = st_mobile_avatar_get_expression(_avatarHandle, iWidth, iHeight, stMobileRotate, detectResult.p_faces, expression);
#if DEBUG
                    if (expression[0] == 1) {
                        NSLog(@"右眼闭");
                    }
#endif
                }
                
            }else{
                NSLog(@"st_mobile_human_action_detect failed %d" , iRet);
            }
        }
    }
    
    
    self.iBufferedCount ++;
    CFRetain(pixelBuffer);
    
    __block st_mobile_human_action_t newDetectResult;
    memset(&newDetectResult, 0, sizeof(st_mobile_human_action_t));
    st_mobile_human_action_copy(&detectResult, &newDetectResult);
    
    int faceCount = catFaceCount;
    st_mobile_animal_face_t *newDetectResult1 = NULL;
    if (faceCount > 0) {
        newDetectResult1 = malloc(sizeof(st_mobile_animal_face_t) * faceCount);
        memset(newDetectResult1, 0, sizeof(st_mobile_animal_face_t) * faceCount);
        copyCatFace(_detectResult1, faceCount, newDetectResult1);
    }
    
    
    dispatch_async(self.renderQueue, ^{
        
        st_result_t iRet = ST_E_FAIL;
        
        // 设置 OpenGL 环境 , 需要与初始化 SDK 时一致
        if ([EAGLContext currentContext] != self.glContext) {
            [EAGLContext setCurrentContext:self.glContext];
        }
        
        // 当图像尺寸发生改变时需要对应改变纹理大小
       if (iWidth != self.imageWidth || iHeight != self.imageHeight) {
           
           NSLog(@"iWidth x iHeight====%@x%@",@(iWidth),@(iHeight));
           
           [self releaseResultTexture];
           
           self.imageWidth  = iWidth;
           self.imageHeight = iHeight;
           
           [self initResultTexture];
       }
        
       // 获取原图纹理
       BOOL isTextureOriginReady = [self setupOriginTextureWithPixelBuffer:pixelBuffer];
       
       GLuint textureResult = _textureOriginInput;
        
        CVPixelBufferRef resultPixelBufffer = pixelBuffer;
        
        if (isTextureOriginReady) {
            
            ///ST_MOBILE 以下为美颜部分
            if ( _hBeautify) {
                if (1)  {
                    
                    [self setupBeautyParam];
                    
                    TIMELOG(keyBeautify);
                    iRet = st_mobile_beautify_process_texture(_hBeautify,
                                                              _textureOriginInput,
                                                              iWidth,
                                                              iHeight,
                                                              stMobileRotate,
                                                              &newDetectResult,
                                                              _textureBeautifyOutput,
                                                              &newDetectResult);
                    TIMEPRINT(keyBeautify, "st_mobile_beautify_process_texture time:");
                    
                    if (ST_OK != iRet) {
                        
                        NSLog(@"st_mobile_beautify_process_texture failed %d" , iRet);
                        
                    } else {
                        textureResult = _textureBeautifyOutput;
                        resultPixelBufffer = _cvBeautifyBuffer;
                    }
                }
                
            }
            
        }
        
        
#if 0 // 美妆
        
        // makeup
        if (_hBmpHandle) {
            
            TIMELOG(bmpProcessKey);
            
            iRet = st_mobile_makeup_process_texture(_hBmpHandle, textureResult, iWidth, iHeight, stMobileRotate, &newDetectResult, _textureMakeUpOutput);
            if (iRet != ST_OK) {
                NSLog(@"st_mobile_makeup_process_texture failed: %d", iRet);
            } else {
                textureResult = _textureMakeUpOutput;
                resultPixelBufffer = _cvMakeUpBuffer;
            }
            
            TIMEPRINT(bmpProcessKey, "st_mobile_makeup_process_texture time:");
        }
#endif
        
        // ST_MOBILE 以下为贴纸部分
       if (_bSticker && _hSticker) {
           
           TIMELOG(stickerProcessKey);
           
           st_mobile_input_params_t inputEvent;
           memset(&inputEvent, 0, sizeof(st_mobile_input_params_t));
           
           int type = ST_INPUT_PARAM_NONE;
           iRet = st_mobile_sticker_get_needed_input_params(_hSticker, &type);
           
           if (CHECK_FLAG(type, ST_INPUT_PARAM_CAMERA_QUATERNION)) {
               
               CMDeviceMotion *motion = self.motionManager.deviceMotion;
               inputEvent.camera_quaternion[0] = motion.attitude.quaternion.x;
               inputEvent.camera_quaternion[1] = motion.attitude.quaternion.y;
               inputEvent.camera_quaternion[2] = motion.attitude.quaternion.z;
               inputEvent.camera_quaternion[3] = motion.attitude.quaternion.w;
               
               if (self.stCamera.devicePosition == AVCaptureDevicePositionBack) {
                   inputEvent.is_front_camera = false;
               } else {
                   inputEvent.is_front_camera = true;
               }
           } else {
               
               inputEvent.camera_quaternion[0] = 0;
               inputEvent.camera_quaternion[1] = 0;
               inputEvent.camera_quaternion[2] = 0;
               inputEvent.camera_quaternion[3] = 1;
           }
           
           iRet = st_mobile_sticker_process_texture_both(_hSticker, textureResult, iWidth, iHeight, stMobileRotate, ST_CLOCKWISE_ROTATE_0, false, &newDetectResult, &inputEvent, newDetectResult1, catFaceCount, _textureStickerOutput);
           
           
           TIMEPRINT(stickerProcessKey, "st_mobile_sticker_process_texture time:");
           
           if (ST_OK != iRet) {
               
               NSLog(@"st_mobile_sticker_process_texture %d" , iRet);
               
           }
           
           textureResult = _textureStickerOutput;
           resultPixelBufffer = _cvStickerBuffer;
           
           
           if (self.isNullSticker) {
               iRet = st_mobile_sticker_change_package(_hSticker, NULL, NULL);
               
               if (ST_OK != iRet) {
                   NSLog(@"st_mobile_sticker_change_package error %d", iRet);
               }
           }
           
       }
       
       
       // ST_MOBILE 以下为滤镜部分
       if (_bFilter && _hFilter) {
           
           if (self.curFilterModelPath != self.preFilterModelPath) {
               
               iRet = st_mobile_gl_filter_set_style(_hFilter, self.curFilterModelPath.UTF8String);
               if (iRet != ST_OK) {
                   NSLog(@"st mobile filter set style failed: %d", iRet);
               }
               self.preFilterModelPath = self.curFilterModelPath;
           }
           
           TIMELOG(keyFilter);
           iRet = st_mobile_gl_filter_process_texture(_hFilter, textureResult, iWidth, iHeight, _textureFilterOutput);
           TIMEPRINT(keyFilter, "st_mobile_gl_filter_process_texture time:");
           
#if DEBUG
           if (ST_OK != iRet) {
               NSLog(@"st_mobile_gl_filter_process_texture %d" , iRet);
           }
#endif
           
           textureResult = _textureFilterOutput;
           resultPixelBufffer = _cvFilterBuffer;
       }
        
        
        if (callBackFlag) [self callbackDelegateWithSampleBuffer:sampleBuffer resultPixelBuffer:resultPixelBufffer];
        
        st_mobile_human_action_delete(&newDetectResult);
        if (faceCount > 0) {
            freeCatFace(newDetectResult1, faceCount);
        }
        if (callBackFlag) {
            @synchronized (self) {
                [self.glPreview renderTexture:textureResult];
            }
        }
        if (_cvTextureOrigin) {
            CFRelease(_cvTextureOrigin);
            _cvTextureOrigin = NULL;
        }
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
        CVOpenGLESTextureCacheFlush(_cvTextureCache, 0);
        
        CFRelease(pixelBuffer);
        self.iBufferedCount --;
        TIMEPRINT(frameCostKey, "every frame cost time");
    });

    
}

@end
