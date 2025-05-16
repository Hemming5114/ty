#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RadioTextAdapter : NSObject

@property (nonatomic) int joinerSize;

@property (nonatomic) int rectDepth;

+ (instancetype) radioTextAdapterWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) resolverDecorator;

- (NSMutableDictionary *) pageviewFrequency;

- (int) popupStatus;

- (NSMutableSet *) buildcallback;

- (NSMutableArray *) shouldRebuildTernary;

@end

NS_ASSUME_NONNULL_END
        