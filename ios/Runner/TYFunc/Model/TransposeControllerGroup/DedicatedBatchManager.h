#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DedicatedBatchManager : NSObject


- (void) startToModulusWork;

- (void) emitRestoreToAlert: (int)immediatePopup;

@end

NS_ASSUME_NONNULL_END
        