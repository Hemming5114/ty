//
//  STBeautyCollectionView.h

//  Copyright © 2020 STBeauty All rights reserved.
//

#import <UIKit/UIKit.h>

#import "STParamUtil.h"
#import "STBeautyFeatureModel.h"
#import "STBeautyValueCache.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, STCollectionType) {
    STCollectionType_Unknown = 0,
    STCollectionType_Suite = 1,
    STCollectionType_Feature = 2,
};

/*!
 * 美颜选项的列表视图
 */
@interface STBeautyCollectionView : UICollectionView

@property (nonatomic, assign, readonly) STCollectionType viewType;
@property (nonatomic, copy) void (^didSelectHandler)(STBeautyFeatureModel * featureItem);
@property (nonatomic, copy) void (^suiteHandler)(STBeautySuite beforeSuiteType,STBeautySuite afterSuiteType);

- (instancetype)initWithFrame:(CGRect)frame type:(STCollectionType)type;

// 
- (void)setCurSuiteType:(STBeautySuite)curSuiteType;
- (void)resetDefaultBeautySuite;

@end



/*!
 * 具体item的cell
 */
@interface STBeautyIconTitleCell : UICollectionViewCell
@property (nonatomic, strong) STBeautyFeatureModel *featureItem;

- (void)configIcon:(NSString *)iconName
      selectedIcon:(NSString *)selectedIconName
             title:(NSString *)title
        isSelected:(BOOL)isSelected;

@end

 
NS_ASSUME_NONNULL_END
