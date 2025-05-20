#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThreadInteractor : NSObject

@property (nonatomic) int crudeIndicator;

@property (nonatomic) int themeDensity;

@property (nonatomic) NSMutableDictionary * shouldFetchUnary;

+ (instancetype) threadInteractorWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) permissiveReceiver;

- (NSMutableDictionary *) publicRange;

- (int) shouldRestartPageView;

- (NSMutableSet *) scrollableTool;

- (NSMutableArray *) reactiveCurve;

@end

NS_ASSUME_NONNULL_END
        