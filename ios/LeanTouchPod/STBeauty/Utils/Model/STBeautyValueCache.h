//
//  STBeautyValueCache.h

//

//  Copyright © 2020 STBeauty All rights reserved.
//

#import <Foundation/Foundation.h>

#import "STBeautySuiteValueModel.h"
#import "STBeautyFeatureModel.h"
#import "STBaseModel.h"


// 值域为【-1,1】，将原始的【0,1】值域转化
float rangeMappedValueFrom(float rawValue);

 
NS_ASSUME_NONNULL_BEGIN

/*!
 * 美颜的参数
 */
@interface STBeautyValueCache : STBaseModel
@property (nonatomic, assign) STBeautySuite curBeautySuite;
@property (nonatomic, assign) STBeautyFeatureType curFeature;
/// 用户的滤镜设置
@property (nonatomic, strong) STBeautySuiteValueModel *filterSuite;
///滤镜列表模型数组
@property (nonatomic, strong) NSMutableArray* filterModelArray;

+ (instancetype)sharedCache;

- (STBeautySuiteValueModel *)currentBeautySuite;

- (void)store;
- (void)resetCustomDefSuite;

/// 获取所有滤镜数据
- (void) initFilterData;

/// 更新记录的滤镜数据
/// @param model _
- (void) reloadFilterData:(STBeautyFeatureModel*) model;

/// 根据缓存的滤镜类型去现有的滤镜数组取相应的滤镜
- (STBeautyFeatureModel*) getFilterDataModel;
@end

NS_ASSUME_NONNULL_END
