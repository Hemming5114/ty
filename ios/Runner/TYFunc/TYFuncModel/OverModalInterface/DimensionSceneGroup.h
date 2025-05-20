#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DimensionSceneGroup : NSObject

@property (nonatomic) int signType;

+ (instancetype) dimensionSceneGroupWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) stateVisible;

- (NSMutableDictionary *) canEndFuture;

- (int) deserializeMatrix;

- (NSMutableSet *) lazyGate;

- (NSMutableArray *) eventtint;

@end

NS_ASSUME_NONNULL_END
        