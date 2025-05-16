#import "ScrollableHeapProtocol.h"
#import "PublishActiveNotifier.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExponentHash : NSObject


- (void) calculateAdaptiveStep;

- (void) exitCollectionSinceThreshold;

@end

NS_ASSUME_NONNULL_END
        