#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UsedSignModule : NSObject

@property (nonatomic) NSMutableDictionary * permanentReference;

@property (nonatomic) NSMutableArray * deferredMaster;

+ (instancetype) usedSignModuleWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) combinerTransparency;

- (NSMutableDictionary *) backwardRecursion;

- (int) shouldLayoutBaseline;

- (NSMutableSet *) channelsFunction;

- (NSMutableArray *) entropyVisible;

@end

NS_ASSUME_NONNULL_END
        