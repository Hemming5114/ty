#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConvolutionStrategyKind : NSObject

@property (nonatomic) NSString * mainModel;

@property (nonatomic) NSMutableArray * smallLatency;

+ (instancetype) convolutionStrategyKindWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) nodeSystem;

- (NSMutableDictionary *) pendingPet;

- (int) canUnmountCycle;

- (NSMutableSet *) smallNib;

- (NSMutableArray *) primaryOperation;

@end

NS_ASSUME_NONNULL_END
        