#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SharedLinkerBase : NSObject


- (void) constructCoordinator: (NSMutableSet *)responderTop;

- (void) wasPersistentDelegateVariable;

- (void) unmountedOnSwitchFacade;

- (void) prepareThemeLocalization: (int)prevSkin;

@end

NS_ASSUME_NONNULL_END
        