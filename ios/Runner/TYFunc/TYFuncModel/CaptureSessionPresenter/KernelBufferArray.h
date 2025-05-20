#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KernelBufferArray : NSObject


- (void) mountImmutableLoss;

- (void) markTransitionInsideResource: (NSMutableDictionary *)resilientBuffer;

@end

NS_ASSUME_NONNULL_END
        