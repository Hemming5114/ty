#import "SymmetricObserverDecorator.h"
#import "ReconcileDraggableGrain.h"
#import "ImperativePriorityEvent.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlaybackControllerArray : NSObject


- (void) unbindWithoutCacheMemento;

- (void) buildConsultativeVariant;

@end

NS_ASSUME_NONNULL_END
        