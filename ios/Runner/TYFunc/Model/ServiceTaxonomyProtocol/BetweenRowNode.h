#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BetweenRowNode : NSObject

@property (nonatomic) NSMutableArray * shouldContinueIcon;

+ (instancetype) betweenRowNodeWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) cubitstate;

- (NSMutableDictionary *) lossDistance;

- (int) queuetraversal;

- (NSMutableSet *) computeTransition;

- (NSMutableArray *) disabledGestureDetector;

@end

NS_ASSUME_NONNULL_END
        