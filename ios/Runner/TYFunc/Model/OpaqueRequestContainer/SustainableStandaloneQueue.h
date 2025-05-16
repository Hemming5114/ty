#import "BackwardResolverProtocol.h"
#import "EncodeResourceOwner.h"
#import "UnregisterScreenZone.h"
#import "DismissNavigatorBase.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SustainableStandaloneQueue : NSObject


- (void) waitOnConsumerChanged;

- (void) sendSubscribeSink;

@end

NS_ASSUME_NONNULL_END
        