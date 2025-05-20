#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OverSliderNavigator : NSObject

@property (nonatomic) int largeAnimation;

+ (instancetype) overSliderNavigatorWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) interactiveAspectRatio;

- (NSMutableDictionary *) granularCluster;

- (int) nextEquivalent;

- (NSMutableSet *) storyboardMode;

- (NSMutableArray *) canUpdateDocument;

@end

NS_ASSUME_NONNULL_END
        