//
//  STBeautyAdjustView.h

//

//  Copyright © 2020 STBeauty All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STBeautyTopItemView.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 * 商汤美颜调整视图
 */
@interface STBeautyAdjustView : UIView
///当前处于哪个item类型
@property (nonatomic,assign) STBeautyItemType currentItemType;


@property (nonatomic, copy) void(^resetBeautyBlock)(void);




- (void)show;

- (void)resetBeauty;

@end
NS_ASSUME_NONNULL_END

