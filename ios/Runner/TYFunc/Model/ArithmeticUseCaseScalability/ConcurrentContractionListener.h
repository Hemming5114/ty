#import "WorkflowParticleHandler.h"
#import "ReplaceInheritedRect.h"
#import "DialogsTime.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConcurrentContractionListener : NSObject


- (void) keepCurrentLayout;

- (void) playAlphaFrame;

@end

NS_ASSUME_NONNULL_END
        