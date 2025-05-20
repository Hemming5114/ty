#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuObserverHandler : NSObject

@property (nonatomic) NSMutableSet * responsiveView;

+ (instancetype) menuObserverHandlerWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) denseDescription;

- (NSMutableDictionary *) observerCoord;

- (int) unactivatedInteractor;

- (NSMutableSet *) resultSkewX;

- (NSMutableArray *) sizeContrast;

@end

NS_ASSUME_NONNULL_END
        