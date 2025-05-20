#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OnCurveAnalyzer : NSObject

@property (nonatomic) NSMutableSet * shouldFinishNorm;

@property (nonatomic) int flexDensity;

@property (nonatomic) NSMutableDictionary * taskmetrics;

+ (instancetype) onCurveAnalyzerWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) segmentthanadapter;

- (NSMutableDictionary *) canBuildExpanded;

- (int) currentDetail;

- (NSMutableSet *) resilientFilter;

- (NSMutableArray *) variantPlatform;

@end

NS_ASSUME_NONNULL_END
        