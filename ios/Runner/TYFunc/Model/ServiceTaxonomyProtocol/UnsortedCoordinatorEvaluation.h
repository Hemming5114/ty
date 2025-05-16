#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnsortedCoordinatorEvaluation : NSObject

@property (nonatomic) NSMutableDictionary * flexVisibility;

+ (instancetype) unsortedCoordinatorEvaluationWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) deprecateLayout;

- (NSMutableDictionary *) tabbarParam;

- (int) permissiveDrawer;

- (NSMutableSet *) canDisposeAppBar;

- (NSMutableArray *) coordinatorActivity;

@end

NS_ASSUME_NONNULL_END
        