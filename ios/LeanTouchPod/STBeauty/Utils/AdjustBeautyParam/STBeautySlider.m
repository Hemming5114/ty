//
//  STBeautySlider.m
//  SenseMeEffects
//
//  Created by Sunshine on 2019/2/11.
//  Copyright © 2019 SenseTime. All rights reserved.
//

#import "STBeautySlider.h"
#import "UIImage+STBeauty.h"

#define Bar_Height 3
#define OffsetFactor 0.8


@interface STBeautySlider ()
@property (nonatomic, strong) UIView *bgBar;
@property (nonatomic, strong) UIView *progressBar;
@property (nonatomic, strong) UIView *dotView;
@end

@implementation STBeautySlider

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _valueView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_valueView setTitle:@"" forState:UIControlStateNormal];
        _valueView.userInteractionEnabled = NO;
        [_valueView setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _valueView.titleLabel.textAlignment = NSTextAlignmentCenter;
        _valueView.titleLabel.adjustsFontSizeToFitWidth = YES;
        _valueView.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 5, 0);
        _valueView.titleLabel.font = [UIFont systemFontOfSize:12
                                                       weight:(UIFontWeightRegular)];
        [_valueView setBackgroundImage:[UIImage ST_Image:@"icon_lj_value"] forState:UIControlStateNormal];
        [self addSubview:_valueView];
        
        _bgBar = [[UIView alloc] initWithFrame:CGRectZero];
        _bgBar.backgroundColor = [UIColor whiteColor];
        _bgBar.layer.cornerRadius = Bar_Height/2.f;
        _bgBar.clipsToBounds = YES;
        [self insertSubview:_bgBar atIndex:0];
        
        _progressBar = [[UIView alloc] initWithFrame:CGRectZero];
        _progressBar.backgroundColor = [UIColor whiteColor];
        _progressBar.layer.cornerRadius = Bar_Height/2.f;
        _progressBar.clipsToBounds = YES;
        [self insertSubview:_progressBar aboveSubview:_bgBar];
        
        _dotView = [[UIView alloc] init];
        _dotView.backgroundColor     = UIColor.whiteColor;
        _dotView.layer.cornerRadius  = 4.f;
        _dotView.clipsToBounds       = YES;
        _dotView.hidden = YES;
        [self insertSubview:_dotView aboveSubview:_progressBar];
    }
    
    return self;
}

- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
    _progressBar.backgroundColor= minimumTrackTintColor;
    [super setMinimumTrackTintColor:UIColor.clearColor];
}
- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
    _bgBar.backgroundColor = maximumTrackTintColor;
    [super setMaximumTrackTintColor:UIColor.clearColor];
}
- (void)setHalfMode:(BOOL)halfMode {
    
    _halfMode = halfMode;
    _dotView.hidden = (halfMode==NO);
    
}

- (CGRect)trackRectForBounds:(CGRect)bounds {
    
    CGRect trackRect = [super trackRectForBounds:bounds];
    return CGRectMake(trackRect.origin.x,
                      bounds.size.height * OffsetFactor,
                      trackRect.size.width,
                      trackRect.size.height);
}
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value {
    
    CGFloat h = CGRectGetHeight(bounds);
    CGFloat w = CGRectGetWidth(rect);
    
    CGFloat xOffset = CGRectGetMinX(rect);
    CGFloat yoffset = h*OffsetFactor;
    
    _bgBar.frame = CGRectMake(xOffset, yoffset, w, Bar_Height);
    
    if (_dotView.hidden == NO ) {
        _dotView.frame = CGRectMake((w-8)/2.f + xOffset, (h*OffsetFactor+(Bar_Height-8)/2.f), 8, 8);
    }
    
    if (_halfMode) {
        if (value > 0.5) {
            _progressBar.frame = CGRectMake(w/2.f + xOffset, yoffset, (value-0.5)*w, Bar_Height);
        } else {
            _progressBar.frame = CGRectMake(value * w + xOffset, yoffset, (0.5-value)*w, Bar_Height);
        }
    } else {
        _progressBar.frame = CGRectMake(xOffset, yoffset, value * w, Bar_Height);
    }
    
    CGRect thumbRect = [super thumbRectForBounds:bounds trackRect:rect value:value];
    _valueView.frame = CGRectMake(CGRectGetMidX(thumbRect) - 13, (yoffset - 28 - CGRectGetHeight(thumbRect)/2.f),
                                  26, 28);
    return thumbRect;
}
- (void)configShowValue:(CGFloat)value {
    if (value > -100) {
        _valueView.titleLabel.font = [UIFont systemFontOfSize:12
                                                       weight:(UIFontWeightRegular)];
    }else {
        _valueView.titleLabel.font = [UIFont systemFontOfSize:11
                                                       weight:(UIFontWeightRegular)];
    }
    [_valueView setTitle:[NSString stringWithFormat:@"%.0f", value] forState:UIControlStateNormal];
    
}

- (UIImage *)thumbImageForState:(UIControlState)state {
    

    return [UIImage ST_Image:@"icon_lj_bar"];
    
}
- (UIImage *)currentThumbImage {

    return [UIImage ST_Image:@"icon_lj_bar"];

}

@end
