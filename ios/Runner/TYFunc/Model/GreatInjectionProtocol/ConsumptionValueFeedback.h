#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConsumptionValueFeedback : NSObject

@property (nonatomic) NSMutableArray * resizableOptimizer;

+ (instancetype) consumptionValueFeedbackWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) missedStack;

- (NSMutableDictionary *) baselineColor;

- (int) taskstructurepressure;

- (NSMutableSet *) progressbarOperation;

- (NSMutableArray *) endCurve;

@end

NS_ASSUME_NONNULL_END
        