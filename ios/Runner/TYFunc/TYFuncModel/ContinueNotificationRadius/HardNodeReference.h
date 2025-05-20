#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HardNodeReference : NSObject

@property (nonatomic) NSMutableArray * sequentialRecursion;

@property (nonatomic) NSMutableSet * localStore;

+ (instancetype) hardNodeReferenceWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) largeUtil;

- (NSMutableDictionary *) hardTransition;

- (int) operationBound;

- (NSMutableSet *) taskVariable;

- (NSMutableArray *) requestMetadata;

@end

NS_ASSUME_NONNULL_END
        