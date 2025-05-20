//
//  STBeautyAdjustView.m

//

//  Copyright © 2020 STBeauty All rights reserved.
//

#import "STBeautyAdjustView.h"
#import "STBeautyCollectionView.h"
#import "STBeautySlider.h"
#import "STBeautyValueCache.h"
#import "STBeautyTopItemView.h"
#import "STFilterListView.h"
#import "zhPopupController.h"
#import "UIImage+STBeauty.h"


@interface STBeautyAdjustView () <STBeautyItemDelegate>

@property (nonatomic, strong) STBeautySlider        *beautySlider;
@property (nonatomic, strong) UIScrollView          *beautyContainerView;
@property (nonatomic, strong) STBeautyTopItemView   *topItemView;
@property (nonatomic, strong) UIView                *lineView;

@property (nonatomic, strong) STBeautyCollectionView *suiteCollectionView;
@property (nonatomic, strong) STBeautyCollectionView *itemCollectionView;  // 具体的美颜特征

@property (nonatomic, strong) STFilterListView       *filterListView; ///滤镜列表


@property (nonatomic, strong) STBeautyFeatureModel *curFeatureItem;

///记录下美颜选择的类型
@property (nonatomic, assign) STBeautySuite beautySuiteType;

@end

@implementation STBeautyAdjustView

- (void)dealloc {
    
    [STBeautyValueCache.sharedCache store];
}
- (instancetype)init {
    
    return [self initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    frame = CGRectMake(0, 0, STScreenWidth, 50 + 290 + 15);
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        self.currentItemType = STBeautType;
    }
    return self;
}

- (void)setupView {
    
    self.backgroundColor = UIColor.clearColor;
    
    [self addSubview:self.beautySlider];
    [self addSubview:self.beautyContainerView];
    [self addSubview:self.topItemView];
    [self addSubview:self.lineView];
    
    [self.beautyContainerView addSubview:self.suiteCollectionView];
    [self.beautyContainerView addSubview:self.itemCollectionView];
    [self.beautyContainerView addSubview:self.filterListView];

    
    __weak __typeof__(self) weakSelf = self;
    self.suiteCollectionView.suiteHandler = ^(STBeautySuite beforeSuiteType,STBeautySuite afterSuiteType) {
        [weakSelf handleSuiteChangeFrom:beforeSuiteType to:afterSuiteType];
    };
    
    self.itemCollectionView.didSelectHandler = ^(STBeautyFeatureModel *  _Nonnull featureItem) {
        [weakSelf handleSelectFeatureItem:featureItem inCategory:featureItem.category];
    };
    
    self.filterListView.SelectFilterBlock = ^(STBeautyFeatureModel * _Nonnull featureItem) {
        [weakSelf selectFilter:featureItem];
    };

    [self.suiteCollectionView setCurSuiteType:STBeautyValueCache.sharedCache.curBeautySuite];
    [self.itemCollectionView setCurSuiteType:STBeautyValueCache.sharedCache.curBeautySuite];
    [self.filterListView reLoadSetFilter:STBeautyValueCache.sharedCache.filterSuite];
    
}
- (void)show {
    zhPopupController *tmp = [[zhPopupController alloc] initWithView:self size: CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    tmp.layoutType = zhPopupLayoutTypeBottom;
    tmp.maskType = zhPopupMaskTypeClear;
    [tmp show];
}

- (void)resetBeauty{
    [STBeautyValueCache.sharedCache resetCustomDefSuite];
    [self.suiteCollectionView setCurSuiteType:STBeautySuite_Custom];
    [self.itemCollectionView resetDefaultBeautySuite];
}
- (void)handleSuiteChangeFrom:(NSInteger)beforeSuiteType to:(NSInteger)afterSuiteType {
    
    if (STBeautySuite_Reset == afterSuiteType) {
        
        if (self.resetBeautyBlock) {
            self.resetBeautyBlock();
        }else{
            [self resetBeauty];
        }
        return;
    }
    
    if (beforeSuiteType == afterSuiteType) {
        return;
    }
    [self setBeautySetSuiteType:afterSuiteType];
    
}
- (void) setBeautySetSuiteType:(NSInteger) afterSuiteType{
    self.beautySuiteType = afterSuiteType;
    STBeautyValueCache.sharedCache.curBeautySuite = afterSuiteType;
    [self.suiteCollectionView setCurSuiteType:afterSuiteType];
    [self.itemCollectionView setCurSuiteType:afterSuiteType];
    switch (afterSuiteType) {
        case STBeautySuite_Natural:
        case STBeautySuite_BigEye:
            self.beautySlider.hidden = YES;
            break;
            
        default:
            break;
    }
}

// action
- (void)handleSelectFeatureItem:(STBeautyFeatureModel *)featureItem inCategory:(STBeautyCategory)category {
    
    self.curFeatureItem = featureItem;
    if (featureItem && featureItem.canEdit) {
        self.beautySlider.enabled = YES;
        self.beautySlider.halfMode = (featureItem.isOnlyPositiveValue == NO);
        if ([featureItem isLimitMaxNightValue]) {
            self.beautySlider.value = featureItem.beautyValue/0.9;
        }else {
            self.beautySlider.value = featureItem.beautyValue;
        }
        [self.beautySlider configShowValue:self.curFeatureItem.showBeautyValue];
        self.beautySlider.hidden = NO;
    } else {
        self.beautySlider.hidden = YES;
    }
    
}

- (void)beautySliderValueChanged:(STBeautySlider *)sender {
    if (self.currentItemType == STBeautType) {
        //美颜
        if (self.curFeatureItem) {
            if ([self.curFeatureItem isLimitMaxNightValue]) {
                self.curFeatureItem.beautyValue = sender.value*0.9;
            }else {
                self.curFeatureItem.beautyValue = sender.value;
            }
            [self.beautySlider configShowValue:self.curFeatureItem.showBeautyValue];
            
            [NSNotificationCenter.defaultCenter postNotificationName:kNotificationBeautyFeatureModity
                                                              object:self.curFeatureItem];
        } else {
            sender.enabled = NO;
            sender.hidden  = YES;
        }
    }else if (self.currentItemType == STFilterType) {
        //滤镜
        self.filterListView.selectModel.beautyValue = sender.value;
        [self.beautySlider configShowValue:self.filterListView.selectModel.showBeautyValue];
        [NSNotificationCenter.defaultCenter postNotificationName:kNotificationBeautyFilterValueChange
                                                          object:self.filterListView.selectModel];
        [STBeautyValueCache.sharedCache reloadFilterData:self.filterListView.selectModel];
    }

}

#pragma mark - STBeautyItemDelegate
/// 切换item
/// @param itemType _
- (void)changeTopItem:(STBeautyItemType)itemType {
    if (itemType == STBeautType) {
        self.currentItemType = STBeautType;
        self.beautySlider.hidden = NO;
        [self.beautyContainerView setContentOffset:CGPointMake(0, 0) animated:YES];
        [self handleSelectFeatureItem:self.curFeatureItem inCategory:self.curFeatureItem.category];
    }else if (itemType == STFilterType) {
        self.currentItemType = STFilterType;
        [self.beautyContainerView setContentOffset:CGPointMake(STScreenWidth, 0) animated:YES];
        if (self.filterListView.selectModel.strPath.length == 0) {
            self.beautySlider.hidden = YES;
        }else {
            self.beautySlider.hidden = NO;
            self.beautySlider.enabled = YES;
            self.beautySlider.halfMode = NO;
            [self.beautySlider configShowValue:self.filterListView.selectModel.showBeautyValue];
            self.beautySlider.value = self.filterListView.selectModel.beautyValue;
        }
    }
}

/// 选择滤镜
/// @param featureModel _
- (void) selectFilter:(STBeautyFeatureModel*) featureModel {
    if (self.filterListView.selectModel.strPath.length == 0) {
        self.beautySlider.hidden = YES;
    }else {
        self.beautySlider.hidden = NO;
        self.beautySlider.enabled = YES;
        self.beautySlider.halfMode = NO;
        [self.beautySlider configShowValue:self.filterListView.selectModel.showBeautyValue];
        self.beautySlider.value = self.filterListView.selectModel.beautyValue;
    }
    [STBeautyValueCache.sharedCache reloadFilterData:self.filterListView.selectModel];
    [NSNotificationCenter.defaultCenter postNotificationName:kNotificationSelectBeautyFilter
                                                      object:self.filterListView.selectModel];
}


#pragma mark - Lazy UI
- (STBeautySlider *)beautySlider {

    if (!_beautySlider) {
        _beautySlider = [[STBeautySlider alloc] initWithFrame:CGRectMake(40, 0, STScreenWidth - 80, 40)];
        _beautySlider.minimumTrackTintColor = [UIColor colorWithRed:1 green:157/255.0 blue:0 alpha:1];
        _beautySlider.maximumTrackTintColor = [UIColor whiteColor];
        _beautySlider.minimumValue = 0;
        _beautySlider.maximumValue = 1.f;
        _beautySlider.value  = 0;
        _beautySlider.hidden = YES;
        [_beautySlider addTarget:self action:@selector(beautySliderValueChanged:)
                forControlEvents:UIControlEventValueChanged];
        [_beautySlider setThumbImage:[UIImage ST_Image:@"icon_lj_bar"] forState:UIControlStateNormal];
    }
    return _beautySlider;
}

- (UIScrollView *)beautyContainerView{
    if (!_beautyContainerView) {
        _beautyContainerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, STScreenWidth, self.frame.size.height + 50)];
        _beautyContainerView.contentSize = CGSizeMake(STScreenWidth*2, _beautyContainerView.frame.size.height);
        _beautyContainerView.showsHorizontalScrollIndicator = NO;
        _beautyContainerView.scrollEnabled = NO;
        _beautyContainerView.backgroundColor = [[UIColor colorWithRed:23/255.0 green:22/255.0 blue:21/255.0 alpha:1] colorWithAlphaComponent:0.9];
    }
    return _beautyContainerView;
}

- (STBeautyTopItemView *)topItemView{
    if (!_topItemView) {
        _topItemView = [STBeautyTopItemView new];
        _topItemView.delegate = self;
        _topItemView.frame = CGRectMake(0, 50, STScreenWidth, 50);
    }
    return _topItemView;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1] colorWithAlphaComponent:0.1];
        _lineView.frame = CGRectMake(0, 49, STScreenWidth, 1);
    }
    return _lineView;
}

- (STBeautyCollectionView *)suiteCollectionView{
    if (!_suiteCollectionView) {
        _suiteCollectionView = [[STBeautyCollectionView alloc] initWithFrame:CGRectMake(0, 50, STScreenWidth, 110) type:(STCollectionType_Suite)];
    }
    return _suiteCollectionView;
}

- (STBeautyCollectionView *)itemCollectionView{
    if (!_itemCollectionView) {
        _itemCollectionView = [[STBeautyCollectionView alloc] initWithFrame:CGRectMake(0, 160, STScreenWidth, 130) type:(STCollectionType_Feature)];
    }
    return _itemCollectionView;
}

- (STFilterListView *)filterListView{
    if (!_filterListView) {
        //添加滤镜
        _filterListView = [[STFilterListView alloc] initWithFrame:CGRectMake(STScreenWidth, 50, STScreenWidth, 240)];
    }
    return _filterListView;
}

@end
