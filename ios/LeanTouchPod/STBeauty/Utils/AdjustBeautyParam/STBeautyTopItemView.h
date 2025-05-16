//
//  STBeautyTopItemView.h

//
//  Created by GJ on 2020/7/7.
//  Copyright © 2020 STBeauty All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, STBeautyItemType) {
    ///美颜
    STBeautType = 100,
    ///滤镜
    STFilterType = 101,
};
NS_ASSUME_NONNULL_BEGIN

@protocol STBeautyItemDelegate <NSObject>

@optional
- (void) changeTopItem:(STBeautyItemType) itemType;

@end
@interface STBeautyTopItemView : UIView

@property (nonatomic, weak) id<STBeautyItemDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
