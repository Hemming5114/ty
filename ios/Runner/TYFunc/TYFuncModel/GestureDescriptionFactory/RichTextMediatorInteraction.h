#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RichTextMediatorInteraction : NSObject


- (void) retainBySingletonJob;

- (void) waitHasChecklist: (NSString *)associatedAlert;

@end

NS_ASSUME_NONNULL_END
        