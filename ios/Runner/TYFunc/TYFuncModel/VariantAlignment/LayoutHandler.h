#import "CriticalGraphicChannel.h"
#import "TouchMatrixBase.h"
#import "UnregisterImageAction.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LayoutHandler : NSObject


- (void) clipDependency;

- (void) disconnectDiversifiedGraphic;

@end

NS_ASSUME_NONNULL_END
        