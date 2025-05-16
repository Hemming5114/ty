#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransitionCombinerOwner : NSObject

@property (nonatomic) NSMutableArray * shouldFinishBloc;

+ (instancetype) transitionCombinerOwnerWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) connectorValidation;

- (NSMutableDictionary *) concurrentChannel;

- (int) shouldValidateFlex;

- (NSMutableSet *) implementRequest;

- (NSMutableArray *) observeOverlay;

@end

NS_ASSUME_NONNULL_END
        