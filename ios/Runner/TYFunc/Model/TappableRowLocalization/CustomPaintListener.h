#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomPaintListener : NSObject


- (void) computeBehaviorWithFilter;

- (void) listenPresenter: (NSString *)webRequest;

@end

NS_ASSUME_NONNULL_END
        