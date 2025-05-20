#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParallelStackShape : NSObject

@property (nonatomic) NSString * shouldPauseKernel;

@property (nonatomic) NSMutableDictionary * equivalentOpacity;

+ (instancetype) parallelStackShapeWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) ignoredProgressBar;

- (NSMutableDictionary *) missedIcon;

- (int) batchPattern;

- (NSMutableSet *) iconOrigin;

- (NSMutableArray *) appbartint;

@end

NS_ASSUME_NONNULL_END
        