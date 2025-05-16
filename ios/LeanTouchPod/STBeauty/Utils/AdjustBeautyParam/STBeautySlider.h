//
//  STBeautySlider.h
//  SenseMeEffects
//
//  Created by Sunshine on 2019/2/11.
//  Copyright © 2019 SenseTime. All rights reserved.
//

#import <UIKit/UIKit.h>

 
NS_ASSUME_NONNULL_BEGIN

/*!
 * 
 */
@interface STBeautySlider : UISlider

@property (nonatomic, assign) BOOL halfMode;
@property (nonatomic, strong) UIButton *valueView;

- (void)configShowValue:(CGFloat)value;

@end

NS_ASSUME_NONNULL_END
