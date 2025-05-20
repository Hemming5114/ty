#import "NotificationStageOffset.h"
#import "CupertinoExpandedSubscription.h"
#import "RectFacadeOrientation.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UpDependencyScheduler : NSObject


- (void) materializeEphemeralAnimatedContainer;

- (void) rotatePageViewAgainstThreshold;

@end

NS_ASSUME_NONNULL_END
        