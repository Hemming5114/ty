#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReceiveCosineLifecycle : NSObject

@property (nonatomic) NSMutableSet * diffableNode;

@property (nonatomic) NSMutableSet * standaloneScroll;

@property (nonatomic) int shouldDisconnectSegment;

+ (instancetype) receiveCosineLifecycleWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) observerProxy;

- (NSMutableDictionary *) shouldStartCatalyst;

- (int) canSkipEffect;

- (NSMutableSet *) asyncanimator;

- (NSMutableArray *) skipsegment;

@end

NS_ASSUME_NONNULL_END
        