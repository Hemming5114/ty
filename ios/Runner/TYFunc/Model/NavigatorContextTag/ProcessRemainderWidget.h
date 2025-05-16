#import "TrainMarginDecorator.h"
#import "UnactivatedReplicaHandler.h"
#import "ViewCompositeMode.h"
#import "LockGestureError.h"
#import "ResultImpactTarget.h"
#import "StringifyDecorationType.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProcessRemainderWidget : NSObject


- (void) attachCriticalCycle;

- (void) quitSymbolOutsidePicker;

@end

NS_ASSUME_NONNULL_END
        