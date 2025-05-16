#import "GranularPopupCallback.h"
#import "ThroughMenuLifecycle.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CancelIterativeSegment : NSObject


- (void) annotateDiscardedState;

- (void) callEphemeralPopupWork;

@end

NS_ASSUME_NONNULL_END
        