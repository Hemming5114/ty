#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TickerPatternBehavior : NSObject

@property (nonatomic) NSMutableDictionary * volumebehavior;

@property (nonatomic) int anchorSpeed;

+ (instancetype) tickerPatternBehaviorWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) euclideanReducer;

- (NSMutableDictionary *) compositionanimation;

- (int) shouldLoadExpanded;

- (NSMutableSet *) canCreateAnimation;

- (NSMutableArray *) priorAxis;

@end

NS_ASSUME_NONNULL_END
        