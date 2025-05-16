//
//  STBeautyValueCache.m

//

//  Copyright © 2020 STBeauty All rights reserved.
//

#import "STBeautyValueCache.h"
#import "STBeautyFeatureModel.h"
#import <objc/runtime.h>

static STBeautyValueCache * _sharedCache = nil;

float rangeMappedValueFrom(float rawValue) {
    
    // 下面几个情况的商汤SDK值域为【-1,1】，将UI上原始的【0,1】值域转化
    // [0,1] -> [-1,1]
    //    case STBeautyTypeLengthNose:
    //    case STBeautyTypeMouthSize:
    //    case STBeautyTypeChin:
    //    case STBeautyTypeHairLine:
    //    case STBeautyTypeLengthPhiltrum:
    //    case STBeautyTypeEyeDistance:
    //    case STBeautyTypeEyeAngle:
    
    return MAX(-1.f, MIN(1.f, rawValue * 2 - 1.f));
    
}
 

@interface STBeautyValueCache ()<NSCoding>
@property (nonatomic, strong) STBeautySuiteValueModel *naturalSuite;// 预定义的 自然系美颜
@property (nonatomic, strong) STBeautySuiteValueModel *bigEyeSuite; // 预定义的 大眼系美颜
@property (nonatomic, strong) STBeautySuiteValueModel *customSuite; // 用户自定义的美颜

@end

@implementation STBeautyValueCache

- (void)dealloc {
    
    [NSNotificationCenter.defaultCenter removeObserver:self];
}
+ (instancetype)sharedCache {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        NSString *path = STBeautyValueCache.cachePath;
        if ([NSFileManager.defaultManager fileExistsAtPath:path]) {
            STBeautyValueCache *obj = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            if (!obj) {
                [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
            }
            if (obj && [obj isKindOfClass:STBeautyValueCache.class]) {
                _sharedCache = obj;
            }
        }
        if (_sharedCache == nil) {
            _sharedCache = [[STBeautyValueCache alloc] initWithSuite:(STBeautySuite_Custom)];
        } else {
            [_sharedCache checkAllSuite];
        }
        _sharedCache.curBeautySuite = _sharedCache.curBeautySuite;
        _sharedCache.curFeature = STBeautyTypeWhiten; // 每次打开APP，都重置
        [NSNotificationCenter.defaultCenter addObserver:_sharedCache
                                               selector:@selector(didReceiveFeatureValueChange:) name:kNotificationBeautyFeatureModity
                                                 object:nil];
            
    });
    
    return _sharedCache;
}
- (STBeautySuiteValueModel *)currentBeautySuite {
    
    switch (self.curBeautySuite) {
        case STBeautySuite_Natural:  return self.naturalSuite;
            break;
            
        case STBeautySuite_BigEye:   return self.bigEyeSuite;
            break;
            
        default:                    return self.customSuite;
            break;
    }
    
}

- (instancetype)initWithSuite:(STBeautySuite)suiteType {
    
    self = [super init];
    if (self) {
        self.curBeautySuite = suiteType;
        [self checkAllSuite];
    }
    
    return self;
}
- (void)checkAllSuite {
    
    if (_customSuite == nil)  _customSuite  = [[STBeautySuiteValueModel alloc] initWithSuite:(STBeautySuite_Custom)];
    if (_naturalSuite == nil) _naturalSuite = [[STBeautySuiteValueModel alloc] initWithSuite:(STBeautySuite_Natural)];
    if (_bigEyeSuite == nil)  _bigEyeSuite  = [[STBeautySuiteValueModel alloc] initWithSuite:(STBeautySuite_BigEye)];
    
    if (_filterSuite == nil)  self.filterSuite = [STBeautySuiteValueModel new];
 
}


- (void)store {
    
    NSString *path = STBeautyValueCache.cachePath;
    BOOL storeRst = [NSKeyedArchiver archiveRootObject:self toFile:path];
    NSLog(@"STBeautyValueCache storeRst %@",@(storeRst));
}
+ (NSString *)cachePath {
    
    NSInteger userId = 0;
    
    NSString *documentDirectoryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *appDirectoryPath = [documentDirectoryPath stringByAppendingPathComponent:@"App/STBeautyValueCache"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:appDirectoryPath] == NO) {
        [fm createDirectoryAtPath:appDirectoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *filePath = [appDirectoryPath stringByAppendingPathComponent:@(userId).description];
    return filePath;
    
}
- (void)setCurBeautySuite:(STBeautySuite)curBeautySuite {
    
    switch (curBeautySuite) {
        case STBeautySuite_Natural:
        case STBeautySuite_BigEye:
            _curBeautySuite = curBeautySuite;
            break;
            
        default:
            _curBeautySuite = STBeautySuite_Custom;
            break;
    }
    
}

// 将用户自定义的套餐重置为默认套餐数值
- (void)resetCustomDefSuite {
    
    [self.customSuite resetBeautySuiteValueFor:(STBeautySuite_Custom)];
    self.curBeautySuite = STBeautySuite_Custom;
}


// notification
- (void)didReceiveFeatureValueChange:(NSNotification *)sender {
    
    STBeautySuiteValueModel *cache = nil;
    
    switch (self.curBeautySuite) {
        case STBeautySuite_Natural:  cache = self.naturalSuite;
            break;
            
        case STBeautySuite_BigEye:  cache = self.bigEyeSuite;
            break;
            
        default: cache = self.customSuite;
            break;
    }
    
    STBeautyFeatureModel *featureModel = sender.object;
    [self handleFeatureValueChangeWith:cache feature:featureModel];
}

- (void)handleFeatureValueChangeWith:(STBeautySuiteValueModel *)beautySuite feature:(STBeautyFeatureModel *)featureModel {
    
    if (self.curBeautySuite == STBeautySuite_Custom) {
        
        if ([featureModel isKindOfClass:STBeautyFeatureModel.class]) {
            
            // [0,1]
            CGFloat beautyValue = featureModel.beautyValue;
            
            switch (featureModel.featureType) {
                case STBeautyTypeWhiten:        beautySuite.fWhitenStrength = beautyValue; // 美白
                    break;
                case STBeautyTypeRuddy:         beautySuite.fReddenStrength = beautyValue; // 红润
                    break;
                case STBeautyTypeDermabrasion:  beautySuite.fSmoothStrength = beautyValue; // 磨皮
                    break;
                    
                    
                case STBeautyTypeShrinkFace:    beautySuite.fShrinkFaceStrength = beautyValue; // 瘦脸
                    break;
                case STBeautyTypeEnlargeEyes:   beautySuite.fEnlargeEyeStrength = beautyValue; // 大眼
                    break;
                case STBeautyTypeShrinkJaw:     beautySuite.fShrinkJawStrength = beautyValue; // 小脸
                    break;
                case STBeautyTypeNarrowFace:    beautySuite.fNarrowFaceStrength = beautyValue; // 窄脸
                    break;
                case STBeautyTypeRoundEye:      beautySuite.fRoundEyeStrength = beautyValue; // 圆眼
                    break;
                    
                    
                case STBeautyTypeThinFaceShape: beautySuite.fThinFaceShapeStrength = beautyValue; // 瘦脸型
                    break;
                case STBeautyTypeChin:          beautySuite.fChinStrength = beautyValue; // 下巴
                    break;
                case STBeautyTypeHairLine:      beautySuite.fHairLineStrength = beautyValue; // 额头
                    break;
                case STBeautyTypeAppleMusle:    beautySuite.fAppleMusleStrength = beautyValue; // 苹果肌
                    break;
                case STBeautyTypeNarrowNose:    beautySuite.fNarrowNoseStrength = beautyValue; // 瘦鼻翼
                    break;
                case STBeautyTypeLengthNose:    beautySuite.fLongNoseStrength = beautyValue; // 长鼻
                    break;
                    
                case STBeautyTypeProfileRhinoplasty:beautySuite.fProfileRhinoplastyStrength = beautyValue; // 侧脸隆鼻
                    break;
                case STBeautyTypeMouthSize:         beautySuite.fMouthStrength = beautyValue; // 嘴形
                    break;
                case STBeautyTypeLengthPhiltrum:    beautySuite.fPhiltrumStrength = beautyValue; // 缩人中
                    break;
                case STBeautyTypeEyeDistance:       beautySuite.fEyeDistanceStrength = beautyValue; // 眼距
                    break;
                case STBeautyTypeEyeAngle:          beautySuite.fEyeAngleStrength = beautyValue; // 眼睛角度
                    break;
                case STBeautyTypeOpenCanthus:       beautySuite.fOpenCanthusStrength = beautyValue; // 开眼角
                    break;
                case STBeautyTypeBrightEye:         beautySuite.fBrightEyeStrength = beautyValue; // 亮眼
                    break;
                case STBeautyTypeRemoveDarkCircles: beautySuite.fRemoveDarkCirclesStrength = beautyValue; // 祛黑眼圈
                    break;
                case STBeautyTypeRemoveNasolabialFolds: beautySuite.fRemoveNasolabialFoldsStrength = beautyValue; // 祛法令纹
                    break;
                case STBeautyTypeWhiteTeeth:        beautySuite.fWhiteTeethStrength = beautyValue; // 亮牙
                    break;
                case STBeautyTypeShrinkCheekbone:   beautySuite.fShrinkCheekboneStrength = beautyValue; // 瘦颧骨
                    break;
                case STBeautyTypeContrast:       // 对比度
                    break;
                case STBeautyTypeSaturation:    // 饱和度
                    break;
                case STBeautyTypeSharpen:        // 锐化
                    break;                    
                    
                default:
                    break;
            }
        }
    }
}


#pragma mark:-------初始化滤镜资源
- (void)reloadFilterData:(STBeautyFeatureModel*)model {
    
    self.filterSuite.fFilterStrength = model.beautyValue;
    self.filterSuite.filterName = model.strName;
    self.filterSuite.filterModelPath = model.strPath;
}

- (STBeautyFeatureModel *)getFilterDataModel {
    
    if (self.filterSuite.filterModelPath.length == 0) {
        return nil;
    }
    
    for (STBeautyFeatureModel* model in self.filterModelArray) {
        if ([model.strName isEqualToString:self.filterSuite.filterName]) {
            model.beautyValue = self.filterSuite.fFilterStrength;
            return model;
        }
    }
    
    return nil;
}

- (void)initFilterData {
    NSArray* orignArray = [STBeautyFeatureModel arrayOfFeatureModelWith:STBeautyCategoryFilter];
    if (orignArray.count > 0) {
        STBeautyFeatureModel* model = [orignArray firstObject];
        self.filterModelArray = [NSMutableArray arrayWithArray:model.subFilterItemsArr];
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        NSString * key = [NSString stringWithUTF8String:name];
        @try {
            [aCoder encodeObject:[self valueForKey:key] forKey:key];
        }@catch (NSException *exception) {
            
        }@finally {
            
        }
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar * ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char * name = ivar_getName(ivar);
            NSString * key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            @try {
                [self setValue:value forKey:key];
            } @catch (NSException *exception) {
            } @finally {
            }
        }
        free(ivars);
    }
    return self;
}


@end
