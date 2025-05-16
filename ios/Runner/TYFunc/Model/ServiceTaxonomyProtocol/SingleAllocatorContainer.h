#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingleAllocatorContainer : NSObject


- (void) throughBaseThreshold;

- (void) measureOutGraphVisitor: (int)eventrange;

@end

NS_ASSUME_NONNULL_END
        