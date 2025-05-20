#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransformBatchCache : NSObject

@property (nonatomic) int persistentgestureedge;

@property (nonatomic) NSMutableSet * temporaryPositioned;

+ (instancetype) transformBatchCacheWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) canDecodeStateful;

- (NSMutableDictionary *) canCacheCube;

- (int) shouldStopConstraint;

- (NSMutableSet *) sliderPosition;

- (NSMutableArray *) methodInterpreter;

@end

NS_ASSUME_NONNULL_END
        