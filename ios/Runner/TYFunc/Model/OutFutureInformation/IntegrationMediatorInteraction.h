#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntegrationMediatorInteraction : NSObject

@property (nonatomic) NSMutableDictionary * metricsShape;

+ (instancetype) integrationMediatorinteractionWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) canRebuildPainter;

- (NSMutableDictionary *) customizedStream;

- (int) scaleBound;

- (NSMutableSet *) taskTint;

- (NSMutableArray *) cacheBehavior;

@end

NS_ASSUME_NONNULL_END
        