#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProviderActionKind : NSObject

@property (nonatomic) NSMutableDictionary * usedRemediation;

@property (nonatomic) NSMutableArray * ephemeralCapsule;

+ (instancetype) providerActionKindWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) invisibleGraphic;

- (NSMutableDictionary *) initializeGraph;

- (int) activePosition;

- (NSMutableSet *) projectFlyweight;

- (NSMutableArray *) routeAlert;

@end

NS_ASSUME_NONNULL_END
        