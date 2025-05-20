#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PriorSensorManager : NSObject


- (void) replaceBehaviorResponse;

- (void) lockDisplayableDimension;

- (void) routeConcretePosition: (int)moduleFrequency;

- (void) fetchDismissWithoutMovement: (NSString *)customizedChannel;

@end

NS_ASSUME_NONNULL_END
        