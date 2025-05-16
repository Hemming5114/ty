#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BehaviorSingleton : NSObject

@property (nonatomic) int intermediateCupertino;

+ (instancetype) behaviorSingletonWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) grainRotation;

- (NSMutableDictionary *) cubeName;

- (int) canFinishSegue;

- (NSMutableSet *) skipWidget;

- (NSMutableArray *) shouldCacheMap;

@end

NS_ASSUME_NONNULL_END
        