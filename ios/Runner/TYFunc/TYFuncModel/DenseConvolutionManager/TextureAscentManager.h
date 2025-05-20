#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextureAscentManager : NSObject


- (void) cacheSpot;

- (void) afterPrecisionMetadata: (NSString *)trajectoryAlignment;

- (void) deserializeChecklistLikeRoute;

- (void) renameWithNodeLevel;

@end

NS_ASSUME_NONNULL_END
        