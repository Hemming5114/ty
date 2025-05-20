//
//  STBeautyFeatureModel.h

//  Copyright © 2018年 SenseTime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "STParamUtil.h"
#import "STBaseModel.h"

@interface STBeautyFeatureModel : STBaseModel

@property (nonatomic, assign) STBeautyCategory category;
@property (nonatomic, assign) STBeautyFeatureType featureType;

@property (nonatomic, assign) CGFloat beautyValue;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *norImageName;
@property (nonatomic, copy) NSString *selImageName;

@property (nonatomic, copy) NSString *zipPath;
@property (nonatomic, copy) NSString *strPath;
@property (nonatomic, copy) NSString *strName;

@property (nonatomic, copy) NSString *strMaterialPath;
@property (nonatomic, assign) NSInteger state;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL isSelected;

///滤镜数组
@property (nonatomic, strong) NSArray<STBeautyFeatureModel *> *subFilterItemsArr;
///滤镜图片
@property (nonatomic,copy) NSString* filterNormalImageName;
///滤镜图片
@property (nonatomic,copy) NSString* filterPressImageName;
///是否选中该滤镜
@property (nonatomic,assign) BOOL isSelect;

- (BOOL)canEdit;

+ (instancetype)featureModelWith:(STBeautyFeatureType)featureType inCategory:(STBeautyCategory)category;

+ (NSArray *)arrayOfFeatureModelWith:(STBeautyCategory)categoryType;

+ (NSDictionary *)beautyFeatureCategoryInfoWith:(NSArray *)categoryTypes;

// 展示的值，【0，100】或【-100，100】
- (CGFloat)showBeautyValue;

// 美颜数值是否只用正数
- (BOOL)isOnlyPositiveValue;

/// 是否限制了上限在90
- (BOOL) isLimitMaxNightValue;

@end
