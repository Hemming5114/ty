#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TemporaryNewestGem : NSObject

@property (nonatomic) NSString * singleCreator;

+ (instancetype) temporaryNewestGemWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) createAsset;

- (NSMutableDictionary *) fillDelegate;

- (int) displayableDependency;

- (NSMutableSet *) lockZone;

- (NSMutableArray *) persistAnimation;

@end

NS_ASSUME_NONNULL_END
        