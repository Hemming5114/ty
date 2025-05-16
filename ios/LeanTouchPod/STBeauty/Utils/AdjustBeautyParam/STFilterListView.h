//
//  STFilterListView.h

//
//  Created by GJ on 2020/7/7.
//  Copyright © 2020 STBeauty All rights reserved.
// 滤镜列表

#import <UIKit/UIKit.h>
#import "STBeautyFeatureModel.h"
#import "STBeautySuiteValueModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface STFilterListView : UIView

@property (nonatomic, strong) STBeautyFeatureModel* selectModel;

@property (nonatomic, copy) void (^SelectFilterBlock)(STBeautyFeatureModel * featureItem);

- (void)reLoadSetFilter:(STBeautySuiteValueModel*) model;

@end

NS_ASSUME_NONNULL_END
