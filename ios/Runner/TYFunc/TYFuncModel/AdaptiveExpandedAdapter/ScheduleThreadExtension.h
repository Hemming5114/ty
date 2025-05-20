#import "CompleterReducerOwner.h"
#import "InactiveObserverDelegate.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleThreadExtension : NSObject


- (void) pushSymbolBeyondThreshold;

- (void) escalateReactiveReduction;

@end

NS_ASSUME_NONNULL_END
        