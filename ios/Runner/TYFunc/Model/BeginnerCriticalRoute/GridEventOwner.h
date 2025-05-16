#import "TensorStampTentative.h"
#import "FactoryActivityTail.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GridEventOwner : NSObject


- (void) finishIntrospectUpTransition;

- (void) skipTaskNearLifecycle;

@end

NS_ASSUME_NONNULL_END
        