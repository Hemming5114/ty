//
//  STBeautyView.h

//  Copyright © 2018年 STBeauty All rights reserved.
//

#import <UIKit/UIKit.h>

#import "STCamera.h"
#import "STGLPreview.h"

#define kDefaultSTCameraAVCaptureSessionPreset AVCaptureSessionPreset1280x720 //


@class STBeautyView;

@protocol STBeautyProcessProtocol <NSObject>
@optional
- (void)stBeautyView:(STBeautyView *)beautyView didProcessSampleBuffer:(CMSampleBufferRef)sampleBuffer;

- (void)stVideoBeautyView:(STBeautyView *)beautyView didProcessVideoSampleBuffer:(CVPixelBufferRef)sampleBuffer;
@end



/*!
 * 商汤美颜；封装相机，视频预览，采样输出
 */
@interface STBeautyView : UIView

@property (nonatomic, strong, readonly) STCamera *stCamera;
@property (nonatomic, strong, readonly) STGLPreview *glPreview;

@property (nonatomic, weak) id<STBeautyProcessProtocol> delegate;

@property (nonatomic, assign) CGFloat imageWidth;
@property (nonatomic, assign) CGFloat imageHeight;
@property (nonatomic, copy) NSString *currentSessionPreset;


- (instancetype)initWithVideoPhone:(NSString*)sessionPreset;

/// 设置视频通话预览的采集大小
/// @param isVideoPhoneSmall _
- (void)configVideoPhonePreviewLayout:(BOOL)isVideoPhoneSmall;

- (void)destory;

@property (nonatomic, assign) BOOL pause;

- (void)dropSomeFrameWhenModifyRevolution;


@end
