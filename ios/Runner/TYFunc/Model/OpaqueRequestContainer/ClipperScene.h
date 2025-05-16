#import "HardCustomPaintZone.h"
#import "CompositionSystemTop.h"
#import "IntoAlphaConfiguration.h"
#import "SymbolReference.h"
#import "UniqueContainerProtocol.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClipperScene : NSObject


- (void) cancelObserver;

- (void) invokeNotificationAsPopup;

@end

NS_ASSUME_NONNULL_END
        