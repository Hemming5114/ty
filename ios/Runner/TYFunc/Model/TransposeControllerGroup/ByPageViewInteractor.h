#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ByPageViewInteractor : NSObject

@property (nonatomic) NSString * normalSubpixel;

@property (nonatomic) int semanticView;

+ (instancetype) byPageViewInteractorWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) canDismissGem;

- (NSMutableDictionary *) diffableStorage;

- (int) displayIntensity;

- (NSMutableSet *) sequentialProvision;

- (NSMutableArray *) liteSprite;

@end

NS_ASSUME_NONNULL_END
        