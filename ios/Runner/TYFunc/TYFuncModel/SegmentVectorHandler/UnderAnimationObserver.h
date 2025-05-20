#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnderAnimationObserver : NSObject

@property (nonatomic) NSString * progressbarduration;

@property (nonatomic) int graphicOffset;

+ (instancetype) underAnimationObserverWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) shouldTransitionSegue;

- (NSMutableDictionary *) canMountCache;

- (int) introspectDependency;

- (NSMutableSet *) interactivePresenter;

- (NSMutableArray *) mainImage;

@end

NS_ASSUME_NONNULL_END
        