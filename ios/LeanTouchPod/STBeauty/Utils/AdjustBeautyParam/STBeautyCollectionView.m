//
//  STBeautyCollectionView.m

//  Copyright © 2020 STBeauty All rights reserved.
//

#import "STBeautyCollectionView.h"
#import "UIImage+STBeauty.h"

@interface STBeautyCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) STBeautyFeatureModel *curItem;
@property (nonatomic, strong) NSArray *featureItems;
@property (nonatomic, assign) STBeautySuite curSuiteType;
@end
 
@implementation STBeautyCollectionView

- (instancetype)initWithFrame:(CGRect)frame type:(STCollectionType)type {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    NSInteger colums = 5;
    CGFloat itemWidth = 56;
    CGFloat margin = (STScreenWidth - colums * itemWidth - 10)/(colums+1);
    
    switch (type) {
        case STCollectionType_Suite:
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            layout.sectionInset = UIEdgeInsetsMake(16, margin + 5, 00, margin + 5);
            break;
        case STCollectionType_Feature:
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            layout.sectionInset = UIEdgeInsetsMake(0, margin + 5, 10, margin + 5);
            break;
            
        default: return nil; break;
    }
    
    layout.minimumLineSpacing       = 0;
    layout.minimumInteritemSpacing  = margin;
    layout.itemSize = CGSizeMake(itemWidth, 96);
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        _viewType = type;
        
        self.backgroundColor =[UIColor clearColor];
        self.alwaysBounceVertical = NO;
        self.delegate = self;
        self.dataSource = self;
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"placeholder"]; //
        [self registerClass:[STBeautyIconTitleCell class] forCellWithReuseIdentifier:@"featureCell"]; // 普通项目cell
        [self registerClass:[STBeautyIconTitleCell class] forCellWithReuseIdentifier:@"suiteCell"]; //
        
        if (type == STCollectionType_Suite) {
            self.scrollEnabled = NO;
        }
    }
    
    return self;
}

- (void)setupData {
    
    switch (self.curSuiteType) {
        case STBeautySuite_Custom:
        {
            NSArray *baseArr  = [STBeautyFeatureModel  arrayOfFeatureModelWith:STBeautyCategoryBase];
            NSArray *shapeArr = [STBeautyFeatureModel arrayOfFeatureModelWith:STBeautyCategoryShape];
            NSArray *msgrArr  = [STBeautyFeatureModel arrayOfFeatureModelWith:STBeautyCategoryMicroSurgery];
            
            NSMutableArray *tmp = [NSMutableArray array];
            [tmp addObjectsFromArray:baseArr];
            [tmp addObjectsFromArray:shapeArr];
            [tmp addObjectsFromArray:msgrArr];
            
            _featureItems = tmp;
            [self configDefaultSelectItem];
        }
            break;
            
        case STBeautySuite_Natural:
        case STBeautySuite_BigEye:
        default:
            _featureItems = @[];
            break;
    }
    
}

- (void)configDefaultSelectItem {
    
    
    /*!
     * 1、找到当前featureType对应的item
     * 2、没有找到，就使用数组firstObject
     */
    STBeautyFeatureType curFeature = STBeautyValueCache.sharedCache.curFeature;
    if (self.curItem) {
        self.curItem.isSelected = NO;
        curFeature = self.curItem.featureType;
    }
    
    // 1
    for (STBeautyFeatureModel *aFeature in _featureItems) {
        if (curFeature == aFeature.featureType) {
            aFeature.isSelected = YES;
            self.curItem = aFeature;
            break;
        }
    }
    
    // 2
    if (self.curItem == nil) {
        STBeautyFeatureModel *aFeature = _featureItems.firstObject;
        aFeature.isSelected = YES;
        self.curItem = aFeature;
    }
    
}


//
- (void)setCurItem:(STBeautyFeatureModel *)curItem {
    
    if (self.viewType == STCollectionType_Feature) {
        
        _curItem = curItem;
        if (_curItem) {
            
            STBeautyValueCache.sharedCache.curFeature = _curItem.featureType;// 记录
            
            if (_didSelectHandler) {
                _didSelectHandler(_curItem);
            }
        }
        
        [self reloadData];
    }
}

- (void)setCurSuiteType:(STBeautySuite)curSuiteType {
    
    _curSuiteType = curSuiteType;
    
    if (self.viewType == STCollectionType_Feature) {
        [self setupData];
    }
    
    [self reloadData];
}

- (void)resetDefaultBeautySuite {
    
    _curSuiteType = STBeautySuite_Custom;
    
    if (self.viewType == STCollectionType_Feature) {
        
        [self setupData];
    }
    
    [self reloadData];
    
}


#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    switch (self.viewType) {
        case STCollectionType_Suite:   return 4;   break;
        case STCollectionType_Feature: return _featureItems.count;    break;
        default: break;
    }
    
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    switch (self.viewType) {
        case STCollectionType_Suite:
        {
            STBeautyIconTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"suiteCell"
                                                                                    forIndexPath:indexPath];
            
            NSInteger index = indexPath.row;
            switch (index) {
                case 0: [cell configIcon:@"st_cz_default" selectedIcon:nil
                                   title:@"重置" isSelected:(index==self.curSuiteType)];
                    break;
                case 1: [cell configIcon:@"st_zrxy_nor" selectedIcon:nil
                                   title:@"自然修颜" isSelected:(index==self.curSuiteType)];
                    break;
                case 2: [cell configIcon:@"st_dysl_nor" selectedIcon:nil
                                   title:@"大眼瘦脸" isSelected:(index==self.curSuiteType)];
                    break;
                case 3: [cell configIcon:@"st_zdy_nor" selectedIcon:nil
                                   title:@"自定义" isSelected:(index==self.curSuiteType)];
                    break;
                default:
                    break;
            }
            
            return cell;
        }
            break;
            
        case STCollectionType_Feature:
        {
            if (indexPath.row < _featureItems.count) {
                
                STBeautyIconTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"featureCell"
                                                                                        forIndexPath:indexPath];
                STBeautyFeatureModel *item = _featureItems[indexPath.row];
                item.isSelected  = (item.featureType == self.curItem.featureType);
                cell.featureItem = item;
                return cell;
            }
        }
            break;
            
        default: break;
    }
    
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"placeholder" forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (self.viewType) {
        case STCollectionType_Suite:
        {
            NSInteger index = indexPath.row;
            if (_suiteHandler) {
                _suiteHandler(self.curSuiteType,(STBeautySuite)index);
            }
        }
            break;
            
        case STCollectionType_Feature:
        {
            if (indexPath.row < _featureItems.count) {
                
                STBeautyFeatureModel *item = _featureItems[indexPath.row];
                self.curItem.isSelected = NO;
                item.isSelected = YES;
                
                self.curItem = item; // setter
            }
        }
        default:
            break;
    }
    
    
}

@end



/*!
 *
 */
@implementation STBeautyIconTitleCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *iconImage = [[UIImageView alloc] init];
        iconImage.tag = 100;
        iconImage.contentMode = UIViewContentModeScaleAspectFit;
        iconImage.layer.cornerRadius = 28;
        iconImage.layer.borderWidth = 1.f;
        iconImage.layer.borderColor = UIColor.clearColor.CGColor;
        iconImage.clipsToBounds = YES;
        [self.contentView addSubview:iconImage];
        
        UILabel *titleLb = [[UILabel alloc]init];
        titleLb.tag = 200;
        titleLb.textColor = UIColor.whiteColor;
        titleLb.font = [UIFont systemFontOfSize:12 weight:(UIFontWeightRegular)];
        titleLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLb];
     }
    return self;
}

- (void)setFeatureItem:(STBeautyFeatureModel *)featureItem {
    
    if ([featureItem isKindOfClass:STBeautyFeatureModel.class] == NO) {
        _featureItem = nil;
    } else {
        _featureItem = featureItem;
    }
    
    [self configIcon:featureItem.norImageName
        selectedIcon:featureItem.selImageName
               title:featureItem.title
          isSelected:featureItem.isSelected];
}

- (void)configIcon:(NSString *)iconName
      selectedIcon:(NSString *)selectedIconName
             title:(NSString *)title
        isSelected:(BOOL)isSelected {
    
    UIImageView *iconImage = [self.contentView viewWithTag:100];
    UILabel *titleLb = [self.contentView viewWithTag:200];
    
    if (iconName) {
        iconImage.image = [UIImage ST_Image:iconName];
    } else {
        iconImage.image = nil;
    }
    
    if (selectedIconName) {
        iconImage.highlightedImage = [UIImage ST_Image:selectedIconName];
    } else {
        iconImage.highlightedImage = nil;
    }
    
    titleLb.text = title;
    
    if (isSelected) {
        UIColor *color = [UIColor colorWithRed:1 green:157/255.0 blue:0 alpha:1];
        
        iconImage.highlighted = YES;
        iconImage.layer.borderColor = color.CGColor;
        
        titleLb.textColor = color;
    } else {
        iconImage.highlighted = NO;
        iconImage.layer.borderColor = UIColor.clearColor.CGColor;
        
        titleLb.textColor = [UIColor.whiteColor colorWithAlphaComponent:0.6];
    }
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    UIImageView *iconImage = [self.contentView viewWithTag:100];
    UILabel *titleLb = [self.contentView viewWithTag:200];
    
    CGFloat w = CGRectGetWidth(self.bounds);
    
    iconImage.frame = CGRectMake((w-56)/2.f, 00, 56, 56);
    titleLb.frame   = CGRectMake(0, 62, w, 16);
    
}

@end
 
