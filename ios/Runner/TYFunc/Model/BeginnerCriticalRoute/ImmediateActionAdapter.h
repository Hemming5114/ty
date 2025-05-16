#import "YieldRelationalTransition.h"
#import "HistogramAscent.h"
#import "LayoutPlateAlignment.h"
#import "CubitControllerPool.h"
#import "FindAccessibleView.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImmediateActionAdapter : NSObject


- (void) observeTicker;

- (void) unbindStoryboardAgainstModel;

@end

NS_ASSUME_NONNULL_END
        