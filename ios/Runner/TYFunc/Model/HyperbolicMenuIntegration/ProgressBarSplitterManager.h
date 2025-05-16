#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProgressBarSplitterManager : NSObject


- (void) storeCallback;

- (void) captureClipper: (NSMutableDictionary *)widgetcoord and: (NSString *)screenOrientation and: (NSMutableArray *)awaitIndex;

@end

NS_ASSUME_NONNULL_END
        