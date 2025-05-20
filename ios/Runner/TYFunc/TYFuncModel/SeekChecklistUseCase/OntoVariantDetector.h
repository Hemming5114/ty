#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OntoVariantDetector : NSObject


- (void) updateMarginListener;

- (void) validateDisplayableChapter: (int)metricsCoord;

- (void) buildGemContainCallback;

- (void) unscheduleSpotLikeCallback;

@end

NS_ASSUME_NONNULL_END
        