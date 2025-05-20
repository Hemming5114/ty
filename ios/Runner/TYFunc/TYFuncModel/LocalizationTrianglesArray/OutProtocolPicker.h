#import "MarkDesktopSize.h"
#import "LazyIndicatorSensor.h"
#import "ProgressBarTempleKind.h"
#import "DependencyPickerPool.h"
#import "ShaderTimeHelper.h"
#import "CollectionPlatformBehavior.h"
#import "TransitionCompletionEffect.h"
#import "LatencyProtocol.h"
#import "ProtectedToolStore.h"
#import "InjectionModuleObserver.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OutProtocolPicker : NSObject


- (void) unscheduleStaticIsolate;

- (void) registerResult;

@end

NS_ASSUME_NONNULL_END
        