#import "BaselineHashProtocol.h"
#import "DecouplePaddingStore.h"
#import "AllocateSemanticsManager.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResourceStateTop : NSObject


- (void) holdOriginalAction;

- (void) willValidateNorm;

@end

NS_ASSUME_NONNULL_END
        