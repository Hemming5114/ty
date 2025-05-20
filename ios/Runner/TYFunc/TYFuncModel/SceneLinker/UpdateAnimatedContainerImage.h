#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UpdateAnimatedContainerImage : NSObject

@property (nonatomic) int permissiveStack;

+ (instancetype) updateAnimatedContainerImageWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) drawInteractor;

- (NSMutableDictionary *) playbackNumber;

- (int) cacheInterval;

- (NSMutableSet *) canPauseNotifier;

- (NSMutableArray *) customizedFilter;

@end

NS_ASSUME_NONNULL_END
        