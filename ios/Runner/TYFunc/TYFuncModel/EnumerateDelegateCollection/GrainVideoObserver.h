#import "EasySynchronousReducer.h"
#import "NavigateExtensionObserver.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GrainVideoObserver : NSObject


- (void) startSignViaCallback;

- (void) pushState;

@end

NS_ASSUME_NONNULL_END
        