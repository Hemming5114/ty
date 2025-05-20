#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaveBaseAnalyzer : NSObject

@property (nonatomic) NSMutableArray * textorigin;

+ (instancetype) saveBaseAnalyzerWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) processorScale;

- (NSMutableDictionary *) canLoadSlider;

- (int) bindReduction;

- (NSMutableSet *) shouldSkipNavigator;

- (NSMutableArray *) semanticContrast;

@end

NS_ASSUME_NONNULL_END
        