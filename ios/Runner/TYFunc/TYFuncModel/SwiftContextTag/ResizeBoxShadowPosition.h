#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResizeBoxShadowPosition : NSObject

@property (nonatomic) NSMutableArray * requiredCursor;

@property (nonatomic) NSMutableDictionary * animatorState;

+ (instancetype) resizeBoxShadowPositionWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) canPopSlash;

- (NSMutableDictionary *) refreshResponse;

- (int) statePhase;

- (NSMutableSet *) compositionalqueuedepth;

- (NSMutableArray *) localizationmode;

@end

NS_ASSUME_NONNULL_END
        