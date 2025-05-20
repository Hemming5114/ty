#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProviderRequest : NSObject


- (void) notifyStampInteractor: (NSMutableArray *)nibResponse;

- (void) afterFlexFactory;

- (void) cancelConfiguration: (NSString *)protocolVisibility;

@end

NS_ASSUME_NONNULL_END
        