//
//  STBeautyFeatureModel.m
//  SenseMeEffects

//  Copyright © 2018年 SenseTime. All rights reserved.
//

#import "STBeautyFeatureModel.h"
#import "STBeautyValueCache.h"


@implementation STBeautyFeatureModel

+ (instancetype)featureModelWith:(STBeautyFeatureType)featureType inCategory:(STBeautyCategory)category {
    
    STBeautyFeatureModel * ret = [[STBeautyFeatureModel alloc] init];
    ret.category    = category;
    ret.featureType = featureType;
    
    switch (category) {
        case STBeautyCategoryFilter:
            [ret setupSubFeatureItems];
            break;
            
        default:
            break;
    }
    
    
    STBeautySuiteValueModel *beautySuite = STBeautyValueCache.sharedCache.currentBeautySuite;
    
    switch (featureType) {
            
        case STBeautyTypeWhiten: ret.beautyValue = beautySuite.fWhitenStrength; // 美白
            break;
        case STBeautyTypeRuddy: ret.beautyValue = beautySuite.fReddenStrength; // 红润
            break;
        case STBeautyTypeDermabrasion: ret.beautyValue = beautySuite.fSmoothStrength; // 磨皮
            break;
            
            
        case STBeautyTypeShrinkFace: ret.beautyValue = beautySuite.fShrinkFaceStrength; // 瘦脸
            break;
        case STBeautyTypeEnlargeEyes: ret.beautyValue = beautySuite.fEnlargeEyeStrength; // 大眼
            break;
        case STBeautyTypeShrinkJaw: ret.beautyValue = beautySuite.fShrinkJawStrength; // 小脸
            break;
        case STBeautyTypeNarrowFace: ret.beautyValue = beautySuite.fNarrowFaceStrength; // 窄脸
            break;
        case STBeautyTypeRoundEye: ret.beautyValue = beautySuite.fRoundEyeStrength; // 圆眼
            break;
            
            
        case STBeautyTypeThinFaceShape: ret.beautyValue = beautySuite.fThinFaceShapeStrength; // 瘦脸型
            break;
        case STBeautyTypeChin: ret.beautyValue = beautySuite.fChinStrength; // 下巴
            break;
        case STBeautyTypeHairLine: ret.beautyValue = beautySuite.fHairLineStrength; // 额头
            break;
        case STBeautyTypeNarrowNose: ret.beautyValue = beautySuite.fNarrowNoseStrength; // 瘦鼻翼
            break;
        case STBeautyTypeLengthNose: ret.beautyValue = beautySuite.fLongNoseStrength; // 长鼻
            break;
        case STBeautyTypeMouthSize: ret.beautyValue = beautySuite.fMouthStrength; // 嘴形
            break;
        case STBeautyTypeBrightEye: ret.beautyValue = beautySuite.fBrightEyeStrength; // 亮眼
            break;
        case STBeautyTypeRemoveDarkCircles: ret.beautyValue = beautySuite.fRemoveDarkCirclesStrength; // 祛黑眼圈
            break;
        case STBeautyTypeRemoveNasolabialFolds: ret.beautyValue = beautySuite.fRemoveNasolabialFoldsStrength; // 祛法令纹
            break;
        case STBeautyTypeWhiteTeeth: ret.beautyValue = beautySuite.fWhiteTeethStrength; // 亮牙
            break;
        case STBeautyTypeShrinkCheekbone: ret.beautyValue = beautySuite.fShrinkCheekboneStrength; // 瘦颧骨
            break;
            
            
        case STBeautyTypeAppleMusle: ret.beautyValue = beautySuite.fAppleMusleStrength; // 苹果肌
            break;
        case STBeautyTypeProfileRhinoplasty: ret.beautyValue = beautySuite.fProfileRhinoplastyStrength; // 侧脸隆鼻
            break;
        case STBeautyTypeLengthPhiltrum: ret.beautyValue = beautySuite.fPhiltrumStrength; // 缩人中
            break;
        case STBeautyTypeEyeDistance: ret.beautyValue = beautySuite.fEyeDistanceStrength; // 眼距
            break;
        case STBeautyTypeEyeAngle: ret.beautyValue = beautySuite.fEyeAngleStrength; // 眼睛角度
            break;
        case STBeautyTypeOpenCanthus: ret.beautyValue = beautySuite.fOpenCanthusStrength; // 开眼角
            break;
            
            
        case STBeautyTypeContrast: ret.beautyValue = beautySuite.fContrastStrength; // 对比度
            break;
        case STBeautyTypeSaturation: ret.beautyValue = beautySuite.fSaturationStrength; // 饱和度
            break;
        case STBeautyTypeSharpen: ret.beautyValue = beautySuite.fSharpenStrength; // 锐化
            break;
                        
        default:
            break;
    }
    
    return ret;
    
}

/// 是否限制了上限在90
- (BOOL) isLimitMaxNightValue {
    if (self.featureType == STBeautyTypeShrinkFace || self.featureType == STBeautyTypeShrinkJaw || self.featureType == STBeautyTypeNarrowFace || self.featureType == STBeautyTypeThinFaceShape) {
        //上限是90
       return YES;
    }
    return NO;
}

+ (NSArray *)arrayOfFeatureModelWith:(STBeautyCategory)categoryType {
    
    NSArray *featureTypes = nil;
    
    switch (categoryType) {
        case STBeautyCategoryBase:
            featureTypes = @[
                @(STBeautyTypeWhiten),         // 美白
                @(STBeautyTypeDermabrasion),   // 磨皮
                @(STBeautyTypeRuddy),          // 红润
            ];
            break;
            
        case STBeautyCategoryShape:
            featureTypes = @[
                @(STBeautyTypeShrinkFace),     // 瘦脸
                @(STBeautyTypeEnlargeEyes),    // 大眼
                @(STBeautyTypeShrinkJaw),      // 小脸
                @(STBeautyTypeNarrowFace),     // 窄脸
                @(STBeautyTypeRoundEye),       // 圆眼
            ];
            break;
            
        case STBeautyCategoryMicroSurgery:
            featureTypes = @[
                
                @(STBeautyTypeThinFaceShape),  // 瘦脸型
                @(STBeautyTypeChin),           // 下巴
                @(STBeautyTypeHairLine),       // 额头
                @(STBeautyTypeNarrowNose),     // 瘦鼻翼
                @(STBeautyTypeLengthNose),     // 长鼻
                @(STBeautyTypeMouthSize),          // 嘴形
                @(STBeautyTypeBrightEye),          // 亮眼
                @(STBeautyTypeRemoveDarkCircles),  // 祛黑眼圈
                @(STBeautyTypeRemoveNasolabialFolds),  // 祛法令纹
                @(STBeautyTypeWhiteTeeth),         // 亮牙
                @(STBeautyTypeShrinkCheekbone),    // 瘦颧骨
                
                //  @(STBeautyTypeAppleMusle),     // 苹果肌
                //  @(STBeautyTypeProfileRhinoplasty), // 侧脸隆鼻
                //  @(STBeautyTypeLengthPhiltrum),     // 缩人中
                //  @(STBeautyTypeEyeDistance),        // 眼距
                //  @(STBeautyTypeEyeAngle),           // 眼睛角度
                //  @(STBeautyTypeOpenCanthus),        // 开眼角
            ];
            break;
            
        
            
        case STBeautyCategoryFilter:
            featureTypes = @[
                @(STEffectsTypeFilterPortrait),
            ];
            break;
            
     
            
        default:
            break;
    }
    
    if (featureTypes.count > 0) {
        
        NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:featureTypes.count];
        
        for (int i = 0; i < featureTypes.count; i++) {
            
            STBeautyFeatureType featureType = [featureTypes[i] integerValue];
            STBeautyFeatureModel *model = [STBeautyFeatureModel featureModelWith:featureType
                                                                      inCategory:categoryType];
            if (model) {
                [tmp addObject:model];
            }
        }
        
        return tmp.copy;
    }
    
    return nil;
}

+ (NSDictionary *)beautyFeatureCategoryInfoWith:(NSArray *)categoryTypes {
    
    if (categoryTypes.count > 0) {
        
        NSMutableDictionary *tmp = [NSMutableDictionary dictionaryWithCapacity:categoryTypes.count];
        
        for (int i = 0; i < categoryTypes.count; i++) {
            
            STBeautyCategory cateType = [categoryTypes[i] integerValue];
            NSArray *featureModelsArr = [self arrayOfFeatureModelWith:cateType];
            
            if (featureModelsArr) {
                tmp[@(cateType).description] = featureModelsArr;
            }
        }
        
        return tmp.copy;
    }
    
    
    return nil;
}

- (void)setupSubFeatureItems {
    switch (self.category) {
        case STBeautyCategoryFilter:
            _subFilterItemsArr =  [self getFilterBundleSource:@"STBeauty"];
            break;
        default:
            break;
    }
}

- (NSMutableArray*) getFilterBundleSource:(NSString*) bundleName {
    
    NSString *strLocalBundlePath =  [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[bundleName stringByAppendingString:@".bundle"]];
    NSArray *arrFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:strLocalBundlePath error:nil];

    NSMutableArray *arrFilterPaths = [NSMutableArray array];
    ///先加入原片
    STBeautyFeatureModel* model = [STBeautyFeatureModel new];
    model.filterNormalImageName = @"icon_lj_original_nor";
    model.filterPressImageName = @"icon_lj_original_pre";
    model.strName = @"原片";
    [arrFilterPaths addObject:model];
    
    NSMutableDictionary* sourceDict = [NSMutableDictionary dictionaryWithCapacity:0];
    for (NSString *strFileName in arrFiles) {
        if ([strFileName hasSuffix:@"model"]) {
            NSString* orignName = [strFileName stringByReplacingOccurrencesOfString:@"filter_style_" withString:@""];
            orignName = [orignName stringByReplacingOccurrencesOfString:@".model" withString:@""];
            orignName = [[orignName componentsSeparatedByString:@"_"] firstObject];
            if (orignName) {
                sourceDict[orignName] = [NSString pathWithComponents:@[strLocalBundlePath,strFileName]];
            }
        }
    }
    NSArray* listNameArray = @[@"tender",
                               @"sofina",
                               @"peach",
                               @"ruby",
                               @"ol",
                               @"se",
                               @"cherry",
                               @"pretty",
                               @"scarlet",
                               @"lovely"];
    
    NSDictionary* filterNameDict = @{@"tender"  : @"标准",
                                     @"sofina"  : @"自然",
                                     @"peach"   : @"清爽",
                                     @"ruby"    : @"红宝石",
                                     @"ol"      : @"美白",
                                     @"se"      : @"蜜桃茶",
                                     @"cherry"  : @"甜美",
                                     @"pretty"  : @"可人",
                                     @"scarlet" : @"甜品",
                                     @"lovely"  : @"白皙"};
    
    NSDictionary* defaultValueDict =  @{@"tender"   : @"0.4",
                                        @"sofina"   : @"0.4",
                                        @"peach"    : @"0.3",
                                        @"ruby"     : @"0.4",
                                        @"ol"       : @"0.4",
                                        @"se"       : @"0.4",
                                        @"cherry"   : @"0.3",
                                        @"pretty"   : @"0.4",
                                        @"scarlet"  : @"0.4",
                                        @"lovely"   : @"0.6"};
    
    for (NSString* filterName in listNameArray) {
        if ([sourceDict objectForKey:filterName]) {
            STBeautyFeatureModel* model = [STBeautyFeatureModel new];
            model.filterNormalImageName = [NSString stringWithFormat:@"icon_lj_%@_nor",filterName];
            model.filterPressImageName = [NSString stringWithFormat:@"icon_lj_%@_pre",filterName];
            model.strName = [filterNameDict objectForKey:filterName];
            model.strPath = [sourceDict objectForKey:filterName];
            model.beautyValue = [defaultValueDict[filterName] floatValue];
            [arrFilterPaths addObject:model];
        }
    }
    return arrFilterPaths;
}

- (BOOL)canEdit {
    
    switch (self.featureType) {
        case STBeautyTypeWhiten: return                 YES;
        case STBeautyTypeRuddy: return                  YES;
        case STBeautyTypeDermabrasion: return           YES;
            
        case STBeautyTypeShrinkFace: return             YES;
        case STBeautyTypeEnlargeEyes: return            YES;
        case STBeautyTypeShrinkJaw: return              YES;
        case STBeautyTypeNarrowFace: return             YES;
        case STBeautyTypeRoundEye: return               YES;
            
        case STBeautyTypeThinFaceShape: return          YES;
        case STBeautyTypeChin: return                   YES;
        case STBeautyTypeHairLine: return               YES;
        case STBeautyTypeAppleMusle: return             YES;
        case STBeautyTypeNarrowNose: return             YES;
        case STBeautyTypeLengthNose: return             YES;
        case STBeautyTypeProfileRhinoplasty: return     YES;
        case STBeautyTypeMouthSize: return              YES;
        case STBeautyTypeLengthPhiltrum: return         YES;
        case STBeautyTypeEyeDistance: return            YES;
        case STBeautyTypeEyeAngle: return               YES;
        case STBeautyTypeOpenCanthus: return            YES;
        case STBeautyTypeBrightEye: return              YES;
        case STBeautyTypeRemoveDarkCircles: return      YES;
        case STBeautyTypeRemoveNasolabialFolds: return  YES;
        case STBeautyTypeWhiteTeeth: return             YES;
        case STBeautyTypeShrinkCheekbone: return        YES;
            
        case STBeautyTypeContrast: return               YES;
        case STBeautyTypeSaturation: return             YES;
        case STBeautyTypeSharpen: return                YES;
            
            break;
            
        default:  break;
    }
    
    return NO;
    
}

- (CGFloat)showBeautyValue {
    
    CGFloat value = self.beautyValue;
    ///是否向上取整
    BOOL isSetCeil = NO;
    switch (self.featureType) {
        case STBeautyTypeLengthNose:
        case STBeautyTypeMouthSize:
        case STBeautyTypeChin:
        case STBeautyTypeHairLine:
        case STBeautyTypeLengthPhiltrum:
        case STBeautyTypeEyeDistance:
        case STBeautyTypeEyeAngle:
            value = rangeMappedValueFrom(value);
            break;
        case STBeautyTypeShrinkFace:
        case STBeautyTypeShrinkJaw:
        case STBeautyTypeNarrowFace:
        case STBeautyTypeThinFaceShape:
         //瘦脸  小脸   窄脸 瘦脸型  上限为0.9
            value = value/0.9;
            isSetCeil = YES;
            break;
        default:
            break;
    }
    if (isSetCeil) {
        return ceilf(value*100) > 100 ? 100 : ceilf(value*100);
    }else {
       return value*100;
    }
    
}

// 美颜数值是否只用正数
- (BOOL)isOnlyPositiveValue {
    
    switch (self.featureType) {
        case STBeautyTypeLengthNose:
        case STBeautyTypeMouthSize:
        case STBeautyTypeChin:
        case STBeautyTypeHairLine:
        case STBeautyTypeLengthPhiltrum:
        case STBeautyTypeEyeDistance:
        case STBeautyTypeEyeAngle:
            return NO;
        default:
            break;
    }
    
    return YES;
}


- (NSString *)title {
    
    switch (self.featureType) {
        case STBeautyTypeWhiten: return                 @"美白";
        case STBeautyTypeRuddy: return                  @"红润";
        case STBeautyTypeDermabrasion: return           @"磨皮";
            
        case STBeautyTypeShrinkFace: return             @"瘦脸";
        case STBeautyTypeEnlargeEyes: return            @"大眼";
        case STBeautyTypeShrinkJaw: return              @"小脸";
        case STBeautyTypeNarrowFace: return             @"窄脸";
        case STBeautyTypeRoundEye: return               @"圆眼";
            
        case STBeautyTypeThinFaceShape: return          @"瘦脸型";
        case STBeautyTypeChin: return                   @"下巴";
        case STBeautyTypeHairLine: return               @"额头";
        case STBeautyTypeAppleMusle: return             @"苹果肌";
        case STBeautyTypeNarrowNose: return             @"瘦鼻翼";
        case STBeautyTypeLengthNose: return             @"长鼻";
        case STBeautyTypeProfileRhinoplasty: return     @"侧脸隆鼻";
        case STBeautyTypeMouthSize: return              @"嘴形";
        case STBeautyTypeLengthPhiltrum: return         @"缩人中";
        case STBeautyTypeEyeDistance: return            @"眼距";
        case STBeautyTypeEyeAngle: return               @"眼睛角度";
        case STBeautyTypeOpenCanthus: return            @"开眼角";
        case STBeautyTypeBrightEye: return              @"亮眼";
        case STBeautyTypeRemoveDarkCircles: return      @"祛黑眼圈";
        case STBeautyTypeRemoveNasolabialFolds: return  @"祛法令纹";
        case STBeautyTypeWhiteTeeth: return             @"亮牙";
        case STBeautyTypeShrinkCheekbone: return        @"瘦颧骨";
            
        case STBeautyTypeContrast: return               @"对比度";
        case STBeautyTypeSaturation: return             @"饱和度";
        case STBeautyTypeSharpen: return                @"锐化";
                    
            
        default:  break;
    }
    
    return _title;
}

- (NSString *)norImageName {
    
    switch (self.featureType) {
        case STBeautyTypeWhiten:            return @"st_mb_nor";     // 美白
        case STBeautyTypeRuddy:             return @"st_hr_nor";     // 红润
        case STBeautyTypeDermabrasion:      return @"st_mp_nor";     // 磨皮
                
        case STBeautyTypeShrinkFace:        return @"st_sl_nor";     // 瘦脸
        case STBeautyTypeEnlargeEyes:       return @"st_dy_nor";     // 大眼
        case STBeautyTypeShrinkJaw:         return @"st_xl_nor";     // 小脸
        case STBeautyTypeNarrowFace:        return @"st_zl_nor";     // 窄脸
        case STBeautyTypeRoundEye:          return @"st_yy_nor";     // 圆眼
            
        case STBeautyTypeThinFaceShape:     return @"st_slx_nor";    // 瘦脸型
        case STBeautyTypeChin:              return @"st_xb_nor";     // 下巴
        case STBeautyTypeHairLine:          return @"st_et_nor";     // 额头
        case STBeautyTypeNarrowNose:        return @"st_sb_nor";     // 瘦鼻翼
        case STBeautyTypeLengthNose:        return @"st_cb_nor";     // 长鼻
        case STBeautyTypeMouthSize:         return @"st_zx_nor";     // 嘴形
        case STBeautyTypeBrightEye:         return @"st_ly_nor";     // 亮眼
        case STBeautyTypeRemoveDarkCircles: return @"st_qhyq_nor";   // 祛黑眼圈
        case STBeautyTypeRemoveNasolabialFolds: return @"st_qflw_nor";  // 祛法令纹
        case STBeautyTypeWhiteTeeth:        return @"st_lyy_nor";    // 亮牙
        case STBeautyTypeShrinkCheekbone:   return @"st_sqg_nor";    // 瘦颧骨
            
            
        case STBeautyTypeAppleMusle: return @"st_microsurgery_apple";     // 苹果肌
        case STBeautyTypeProfileRhinoplasty: return @"st_microsurgery_rhinoplasty"; // 侧脸隆鼻
        case STBeautyTypeLengthPhiltrum: return @"st_microsurgery_suorenzhong";     // 缩人中
        case STBeautyTypeEyeDistance: return @"st_microsurgery_eyeDistance";        // 眼距
        case STBeautyTypeEyeAngle: return @"st_microsurgery_eyeAngle";           // 眼睛角度
        case STBeautyTypeOpenCanthus: return @"st_microsurgery_openCanthus";        // 开眼角
            
        case STBeautyTypeContrast: return @"st_adjust_contrast";       // 对比度
        case STBeautyTypeSaturation: return @"st_adjust_saturation";     // 饱和度
        case STBeautyTypeSharpen: return @"st_adjust_sharpen";        // 锐化
            
            break;
            
        default:  break;
    }
    
    
    return _norImageName;
}

- (NSString *)selImageName {
    
    switch (self.featureType) {
            
        default:
        {
            NSString *norImageName = [self norImageName];
            if (norImageName) {
                return norImageName;
            }
        }
            break;
    }
    
    return _selImageName;
}

@end
