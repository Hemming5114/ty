#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SeekPageViewFactory : NSObject

@property (nonatomic) int compositionalstream;

+ (instancetype) seekPageViewFactoryWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) queueActivity;

- (NSMutableDictionary *) logOperation;

- (int) granularPriority;

- (NSMutableSet *) shouldEncodeCapacities;

- (NSMutableArray *) setupInjection;

@end

NS_ASSUME_NONNULL_END
        