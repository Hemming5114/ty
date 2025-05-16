#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "STBeautyAdjustView.h"
#import "STBeautyCollectionView.h"
#import "STBeautySlider.h"
#import "STBeautyTopItemView.h"
#import "STFilterListItemCell.h"
#import "STFilterListView.h"
#import "STBeautyView.h"
#import "STCamera.h"
#import "STGLPreview.h"
#import "STVFShader.h"
#import "STBeauty.h"
#import "STLicHelper.h"
#import "STMobileLog.h"
#import "STParamUtil.h"
#import "UIImage+STBeauty.h"
#import "STBaseModel.h"
#import "STBeautyFeatureModel.h"
#import "STBeautySuiteValueModel.h"
#import "STBeautyValueCache.h"
#import "st_mobile_animal.h"
#import "st_mobile_avatar.h"
#import "st_mobile_beautify.h"
#import "st_mobile_color_convert.h"
#import "st_mobile_common.h"
#import "st_mobile_face_attribute.h"
#import "st_mobile_filter.h"
#import "st_mobile_human_action.h"
#import "st_mobile_license.h"
#import "st_mobile_makeup.h"
#import "st_mobile_object.h"
#import "st_mobile_sticker.h"
#import "st_mobile_sticker_module.h"
#import "st_mobile_sticker_transition.h"

FOUNDATION_EXPORT double STBeautyVersionNumber;
FOUNDATION_EXPORT const unsigned char STBeautyVersionString[];

