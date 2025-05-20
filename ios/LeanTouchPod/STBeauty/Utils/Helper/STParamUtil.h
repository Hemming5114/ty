//
//  STParamUtil.h
//
//  Created by HaifengMay on 16/11/5.
//  Copyright © 2016年 SenseTime. All rights reserved.
//

/*
 * function: 主要用来获取一些系统的参数，如 CPU占用率，帧率等
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "st_mobile_human_action.h"
#import "st_mobile_common.h"
#import "st_mobile_beautify.h"


#define kNotificationBeautyFeatureModity @"Notification.Beauty.Feature.Modity"
///选择滤镜通知
#define kNotificationSelectBeautyFilter @"Notification.Beauty.Filter.Modity"
///滤镜强度变化通知
#define kNotificationBeautyFilterValueChange @"Notification.Beauty.Filter.ValueChange"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define STWeakSelf __weak __typeof(self) weakSelf = self;

#define STStrongSelf __strong __typeof(weakSelf) strongSelf = weakSelf;

#define STScreenWidth     [UIScreen mainScreen].bounds.size.width
#define STScreenHeight    [UIScreen mainScreen].bounds.size.height


typedef NS_ENUM(NSInteger, STTitleViewStyle) {
    STTitleViewStyleOnlyImage = 0,
    STTitleViewStyleOnlyCharacter
};

/*!
 * 美颜的类别
 */
typedef NS_ENUM(NSInteger, STBeautyCategory) {
    
    STBeautyCategoryUnknown = 0,
    
    STBeautyCategoryBase,
    STBeautyCategoryShape,
    STBeautyCategoryMicroSurgery,
    STBeautyCategoryFilter,
};
 

typedef NS_ENUM(NSInteger, STBeautyFeatureType) {

    STBeautyFeatureTypeUnknown = 0,
    
    // 美颜
    STBeautyTypeWhiten = 101,   // 美白
    STBeautyTypeRuddy,          // 红润
    STBeautyTypeDermabrasion,   // 磨皮
     
    // 美形
    STBeautyTypeShrinkFace,     // 瘦脸
    STBeautyTypeEnlargeEyes,    // 大眼
    STBeautyTypeShrinkJaw,      // 小脸
    STBeautyTypeNarrowFace,     // 窄脸
    STBeautyTypeRoundEye,       // 圆眼
    
    // 微整形
    STBeautyTypeThinFaceShape,  // 瘦脸型
    STBeautyTypeChin,           // 下巴
    STBeautyTypeHairLine,       // 额头
    STBeautyTypeNarrowNose,     // 瘦鼻翼
    STBeautyTypeLengthNose,     // 长鼻
    STBeautyTypeMouthSize,          // 嘴形
    STBeautyTypeBrightEye,          // 亮眼
    STBeautyTypeRemoveDarkCircles,  // 祛黑眼圈
    STBeautyTypeRemoveNasolabialFolds,  // 祛法令纹
    STBeautyTypeWhiteTeeth,         // 亮牙
    STBeautyTypeShrinkCheekbone,    // 瘦颧骨
    
    STBeautyTypeProfileRhinoplasty, // 侧脸隆鼻
    STBeautyTypeLengthPhiltrum,     // 缩人中
    STBeautyTypeAppleMusle,         // 苹果肌
    STBeautyTypeEyeDistance,        // 眼距
    STBeautyTypeEyeAngle,           // 眼睛角度
    STBeautyTypeOpenCanthus,        // 开眼角

    // 调整
    STBeautyTypeContrast,       // 对比度
    STBeautyTypeSaturation,     // 饱和度
    STBeautyTypeSharpen,        // 锐化

    
    
    // 滤镜
    STEffectsTypeFilterPortrait,    //
    STEffectsTypeFilterScenery,     //
    STEffectsTypeFilterStillLife,   //
    STEffectsTypeFilterDeliciousFood,   //
    STEffectsTypeFilter_SubItem, // 滤镜的子项
    
};

//// 别名
//typedef STBeautyFeatureType STBeautyType;
//typedef STBeautyFeatureType STEffectsType;



void setBeautifyParam(st_handle_t beautifyHandle, st_beautify_type type, float value);
 
 
/*!
 * 工具类 STParamUtil
 */
@interface STParamUtil : NSObject

@end
