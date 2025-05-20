#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GrayscalePhaseTail : NSObject

@property (nonatomic) NSMutableDictionary * inactiveVertex;

+ (instancetype) grayscalePhaseTailWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) binaryBrightness;

- (NSMutableDictionary *) mutableGrain;

- (int) customizedEntropy;

- (NSMutableSet *) largetransitiontail;

- (NSMutableArray *) canPrepareMediaQuery;

@end

NS_ASSUME_NONNULL_END
        