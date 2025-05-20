//
//  STBeautyTopItemView.m

//
//  Created by GJ on 2020/7/7.
//  Copyright © 2020 STBeauty All rights reserved.
//

#import "STBeautyTopItemView.h"

@interface STBeautyTopItemView ()
@property (nonatomic, strong) UIView* sliderView;

@property (nonatomic,weak) UIButton* selectButton;
@end

@implementation STBeautyTopItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        NSArray* items = @[@"美颜",@"滤镜"];
        STBeautyItemType tag = STBeautType;
        CGFloat buttonW = 56;
        CGFloat buttonX = 6;
        for (NSString* item in items) {
            UIButton* itemButton = [self creatButton:item itemType:tag];
            [self addSubview:itemButton];
            itemButton.frame = CGRectMake(buttonX, 0, buttonW, 50);
            buttonX = buttonW+buttonX;
            tag = tag+1;
            if ([items indexOfObject:item] == 0) {
                [self buttonItemChange:itemButton];
            }
        }
        [self addSubview:self.sliderView];
        self.sliderView.frame = CGRectMake(29, 37, 10, 2);
    }
    return self;
}
- (UIButton*) creatButton:(NSString*)item itemType:(STBeautyItemType) type{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:item forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:195/255.0 green:189/255.0 blue:185/255.0 alpha:1] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    button.tag = type;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(buttonItemChange:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (void) buttonItemChange:(UIButton*) sender {
    if (sender.selected) {
        return;
    }
    self.selectButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.selectButton.selected = NO;
    sender.selected = YES;
    self.selectButton = sender;
    if (self.sliderView.superview) {
        CGFloat transFormX = (sender.tag-STBeautType)*56;
        [UIView animateWithDuration:0.25 animations:^{
            self.sliderView.transform = CGAffineTransformMakeTranslation(transFormX, 0);
        }];
    }

    if ([self.delegate respondsToSelector:@selector(changeTopItem:)]) {
        [self.delegate changeTopItem:sender.tag];
    }
}
- (UIView *)sliderView {
    if (!_sliderView) {
        _sliderView = [UIView new];
        _sliderView.backgroundColor = [UIColor whiteColor];
    }
    return _sliderView;
}

@end
