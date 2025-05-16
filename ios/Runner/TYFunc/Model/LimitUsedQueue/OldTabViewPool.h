#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OldTabViewPool : NSObject

@property (nonatomic) int configurationOffset;

+ (instancetype) oldTabViewPoolWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) commonIsolate;

- (NSMutableDictionary *) interpolateResource;

- (int) threadFlyweight;

- (NSMutableSet *) hasStream;

- (NSMutableArray *) liteAmortization;

@end

NS_ASSUME_NONNULL_END
        