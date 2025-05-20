#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertView : NSObject


- (void) listenService;

- (void) connectCellAwayObserver: (NSMutableSet *)initialListView;

@end

NS_ASSUME_NONNULL_END
        