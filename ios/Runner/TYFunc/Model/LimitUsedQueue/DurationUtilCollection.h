#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DurationUtilCollection : NSObject

@property (nonatomic) int channelCenter;

@property (nonatomic) NSMutableSet * shouldReplaceAnchor;

+ (instancetype) durationUtilCollectionWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) uniqueMedia;

- (NSMutableDictionary *) checkUseCase;

- (int) webNotifier;

- (NSMutableSet *) responsiveRouter;

- (NSMutableArray *) difficultComposition;

@end

NS_ASSUME_NONNULL_END
        