//
//  STFilterListItemCell.m

//
//  Created by GJ on 2020/7/7.
//  Copyright © 2020 STBeauty All rights reserved.
//

#import "STFilterListItemCell.h"
#import "Masonry.h"
#import "UIImage+STBeauty.h"

@interface STFilterListItemCell ()
@property (nonatomic,strong) UIImageView* iconView;

@property (nonatomic,strong) UILabel* nameLab;
///选中时候的外圈标记框
@property (nonatomic, strong) UIView* borderView;
@end

@implementation STFilterListItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.borderView];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLab];
        
        CGFloat itemW = (STScreenWidth-34-15*4)/5;
        self.borderView.layer.cornerRadius = itemW/2;
        self.borderView.layer.masksToBounds = YES;
        
        [self.borderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.mas_equalTo(self.contentView);
            make.height.mas_equalTo(itemW);
        }];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.borderView);
            make.width.height.mas_equalTo(itemW-6);
        }];
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.borderView.mas_bottom).mas_offset(8);
            make.leading.trailing.mas_equalTo(self.contentView);
        }];
    }
    return self;
}
- (void)setModel:(STBeautyFeatureModel *)model {
    _model = model;
     
    self.iconView.image = [UIImage ST_Image:model.filterNormalImageName];
    self.nameLab.text = model.strName;
    self.borderView.hidden = !model.isSelected;
    if (model.isSelected) {
        self.nameLab.textColor = [UIColor colorWithRed:1 green:157/255.0 blue:0 alpha:1];
    }else {
        self.nameLab.textColor = [UIColor whiteColor];
    }
}
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [UIImageView new];
    }
    return _iconView;
}
- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [UILabel new];
        _nameLab.font = [UIFont systemFontOfSize:12];
        _nameLab.textColor = [UIColor whiteColor];
        _nameLab.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLab;
}
- (UIView *)borderView {
    if (!_borderView) {
        _borderView = [UIView new];
        _borderView.backgroundColor = [UIColor clearColor];
        _borderView.layer.borderColor = [UIColor colorWithRed:1 green:157/255.0 blue:0 alpha:1].CGColor;
        _borderView.layer.borderWidth = 1;
        _borderView.hidden = YES;
    }
    return _borderView;
}
@end
