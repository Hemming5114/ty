#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DiscardedAudioType : NSObject

@property (nonatomic) int shouldContinueGrayscale;

@property (nonatomic) int interpolationInterval;

+ (instancetype) discardedAudioTypeWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) defaultCapacities;

- (NSMutableDictionary *) shouldUpdateMatrix;

- (int) associatedBoxShadow;

- (NSMutableSet *) cycleTheme;

- (NSMutableArray *) observePageView;

@end

NS_ASSUME_NONNULL_END
        