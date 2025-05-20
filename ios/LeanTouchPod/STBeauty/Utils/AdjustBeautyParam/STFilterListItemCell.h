//
//  STFilterListItemCell.h

//
//  Created by GJ on 2020/7/7.
//  Copyright © 2020 STBeauty All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STBeautyFeatureModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface STFilterListItemCell : UICollectionViewCell
@property (nonatomic, strong) STBeautyFeatureModel* model;
@end

NS_ASSUME_NONNULL_END
