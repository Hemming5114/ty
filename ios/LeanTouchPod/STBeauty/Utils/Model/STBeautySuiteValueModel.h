//
//  STBeautySuiteValueModel.h

//  Copyright © 2020 STBeauty All rights reserved.
//



#import "STParamUtil.h"
#import "STBaseModel.h"


/*!
 * 预定义了成套的美颜参数
 */
typedef NS_ENUM(NSInteger, STBeautySuite) {
    
    STBeautySuite_Reset = 0,
    
    STBeautySuite_Natural, // 自然修颜
    STBeautySuite_BigEye, // 大眼瘦脸
    STBeautySuite_Custom, // 默认 可修改 自定义
};


NS_ASSUME_NONNULL_BEGIN

/*!
 * 商汤美颜，一套参数的模型
 */
@interface STBeautySuiteValueModel : STBaseModel

@property (nonatomic, assign) STBeautySuite beautySuite;

///滤镜 强度
@property (nonatomic, assign) float fFilterStrength;  // 滤镜强度
///滤镜名称
@property (nonatomic,copy) NSString* filterName;
///滤镜路径(实际路径以filterModelArray取出的为准)
@property (nonatomic,copy) NSString* filterModelPath;

// beauty value
// 基础美颜
@property (nonatomic, assign) float fWhitenStrength; // 美白
@property (nonatomic, assign) float fReddenStrength; // 红润
@property (nonatomic, assign) float fSmoothStrength; // 磨皮

// 美形
@property (nonatomic, assign) float fShrinkFaceStrength; // 瘦脸
@property (nonatomic, assign) float fEnlargeEyeStrength; // 大眼
@property (nonatomic, assign) float fShrinkJawStrength; // 小脸
@property (nonatomic, assign) float fNarrowFaceStrength; // 窄脸
@property (nonatomic, assign) float fRoundEyeStrength; // 圆眼

// 微整形
@property (nonatomic, assign) float fThinFaceShapeStrength; // 瘦脸型
@property (nonatomic, assign) float fChinStrength; // 下巴
@property (nonatomic, assign) float fHairLineStrength; // 额头
@property (nonatomic, assign) float fNarrowNoseStrength; //瘦鼻翼
@property (nonatomic, assign) float fLongNoseStrength; // 长鼻
@property (nonatomic, assign) float fMouthStrength; // 嘴型
@property (nonatomic, assign) float fBrightEyeStrength; // 亮眼
@property (nonatomic, assign) float fRemoveDarkCirclesStrength; // 去黑眼圈
@property (nonatomic, assign) float fRemoveNasolabialFoldsStrength; // 去法令纹
@property (nonatomic, assign) float fWhiteTeethStrength; //  白牙
@property (nonatomic, assign) float fShrinkCheekboneStrength; // 瘦颧骨


/*!
 * 下面这些项目使用默认值，UI上没有调整的交互
 */
@property (nonatomic, assign) float fPhiltrumStrength; // 缩人中
@property (nonatomic, assign) float fAppleMusleStrength; // 苹果肌
@property (nonatomic, assign) float fEyeDistanceStrength; // 眼距
@property (nonatomic, assign) float fEyeAngleStrength; // 眼角度
@property (nonatomic, assign) float fProfileRhinoplastyStrength; // 侧脸隆鼻
@property (nonatomic, assign) float fOpenCanthusStrength; // 开眼角

@property (nonatomic, assign) float fContrastStrength; // 设置对比度参数
@property (nonatomic, assign) float fSaturationStrength; // 设置饱和度参数
@property (nonatomic, assign) float fSharpenStrength; // 锐化参数


- (instancetype)initWithSuite:(STBeautySuite)suiteType;

- (void)resetBeautySuiteValueFor:(STBeautySuite)suiteType;

@end

NS_ASSUME_NONNULL_END

