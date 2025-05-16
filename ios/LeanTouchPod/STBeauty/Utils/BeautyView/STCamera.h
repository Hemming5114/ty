//
//  STCamera.h
//
//  Created by sluin on 16/5/4.
//  Copyright © 2016年 SenseTime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@protocol STCameraDelegate <NSObject>

// call back in bufferQueue
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection;

@end

/*!
 * 封装相机采集
 */
@interface STCamera : NSObject

@property (nonatomic , assign) id <STCameraDelegate> delegate;

@property (nonatomic , readonly) dispatch_queue_t bufferQueue;

@property (nonatomic , assign) AVCaptureDevicePosition devicePosition; // default AVCaptureDevicePositionFront

@property (nonatomic , assign) AVCaptureVideoOrientation videoOrientation;

@property (nonatomic , assign) BOOL needVideoMirrored;

@property (nonatomic , strong , readonly) AVCaptureConnection *videoConnection;

@property (nonatomic , copy) AVCaptureSessionPreset sessionPreset;  // default  

@property (nonatomic , strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (atomic , assign) BOOL bSessionPause;

@property (nonatomic , assign) int iExpectedFPS;

@property (nonatomic, readwrite, strong) NSDictionary *videoCompressingSettings;

// old
@property (nonatomic , assign) int iFPS;

- (instancetype)initWithDevicePosition:(AVCaptureDevicePosition)iDevicePosition
                        sessionPresset:(AVCaptureSessionPreset)sessionPreset
                                   fps:(int)iFPS
                         needYuvOutput:(BOOL)needYuvOutput;

- (void)setExposurePoint:(CGPoint)point inPreviewFrame:(CGRect)frame;

- (void)setISOValue:(float)value;

- (void)startRunning;

- (void)stopRunning;

- (void)snapStillImageCompletionHandler:(void (^)(CMSampleBufferRef imageDataSampleBuffer, NSError *error))handler;

- (CGRect)getZoomedRectWithRect:(CGRect)rect scaleToFit:(BOOL)bScaleToFit;

- (BOOL)sessionState;

@end
