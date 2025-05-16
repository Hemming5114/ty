#import "StreamWidget.h"
#import "AnimateCrudeAction.h"
#import "AnimateDiscardedButton.h"
#import "InjectionEvaluation.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TappableLoopController : NSObject


- (void) propagateWorkflowAgainstAsync;

- (void) savePicker;

@end

NS_ASSUME_NONNULL_END
        