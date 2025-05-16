//
//  STFilterListView.m

//
//  Created by GJ on 2020/7/7.
//  Copyright © 2020 STBeauty All rights reserved.
//

#import "STFilterListView.h"
#import "STFilterListItemCell.h"
#import "STBeautyValueCache.h"

@interface STFilterListView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView* collectionView;
@end

@implementation STFilterListView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.selectModel = [[STBeautyValueCache sharedCache].filterModelArray firstObject];
        self.selectModel.isSelected = YES;
        [self addSubview:self.collectionView];
        [self.collectionView reloadData];
    }
    
    return self;
}
- (void)reLoadSetFilter:(STBeautySuiteValueModel *)model {
    
    if ([self.selectModel.strName isEqualToString:model.filterName]) {
        return;
    }
    
    for (STBeautyFeatureModel* childM in [STBeautyValueCache sharedCache].filterModelArray) {
        
        if ([childM.strName isEqualToString:model.filterName]) {
            self.selectModel.isSelected = NO;
            childM.isSelected = YES;
            childM.beautyValue = model.fFilterStrength;
            self.selectModel = childM;
            [self.collectionView reloadData];
            NSInteger index = [[STBeautyValueCache sharedCache].filterModelArray indexOfObject:childM];
            if (index >= 10) {
                index = [STBeautyValueCache sharedCache].filterModelArray.count-1;
            }
            NSIndexPath* indexp = [NSIndexPath indexPathForItem:index inSection:0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.collectionView scrollToItemAtIndexPath:indexp atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
            });
            break;
        }
    }
    
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
        layout.sectionInset = UIEdgeInsetsMake(17, 17, 17, 17);
        layout.minimumLineSpacing = 14;
        layout.minimumInteritemSpacing = 15;
        CGFloat itemW = (self.frame.size.width -34 - 15*4)/5;
        layout.itemSize = CGSizeMake(itemW, itemW+25);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[STFilterListItemCell class] forCellWithReuseIdentifier:@"STFilterListItemCell"];
    }
    return _collectionView;
}

//
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [STBeautyValueCache sharedCache].filterModelArray.count;
}
-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    STFilterListItemCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"STFilterListItemCell" forIndexPath:indexPath];
    cell.model = [STBeautyValueCache sharedCache].filterModelArray[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    STBeautyFeatureModel* model = [STBeautyValueCache sharedCache].filterModelArray[indexPath.item];
    if (self.selectModel == model) {
        return;
    }
    self.selectModel.isSelected = NO;
    self.selectModel = model;
    self.selectModel.isSelected = YES;
    [self.collectionView reloadData];
    if (self.SelectFilterBlock) {
        self.SelectFilterBlock(self.selectModel);
    }
}


@end
