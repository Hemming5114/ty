#import "LoadSensorTimeline.h"
#import "ProviderService.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FixedLoopRenderer : NSObject


- (void) dissociateInFutureProcess;

- (void) postPermanentFutureChain;

@end

NS_ASSUME_NONNULL_END
        