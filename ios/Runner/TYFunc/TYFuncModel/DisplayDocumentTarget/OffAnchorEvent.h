#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OffAnchorEvent : NSObject

@property (nonatomic) NSString * robustTransition;

+ (instancetype) offAnchorEventWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) renameRoute;

- (NSMutableDictionary *) dimensionVelocity;

- (int) taskinfo;

- (NSMutableSet *) loadvector;

- (NSMutableArray *) cartesianPosition;

@end

NS_ASSUME_NONNULL_END
        