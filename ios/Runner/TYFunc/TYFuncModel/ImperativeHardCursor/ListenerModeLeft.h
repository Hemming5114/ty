#import "MultiTextDetector.h"
#import "AttachStampMetadata.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListenerModeLeft : NSObject


- (void) inTaskStream;

- (void) finishPromiseOutsideDetector;

@end

NS_ASSUME_NONNULL_END
        