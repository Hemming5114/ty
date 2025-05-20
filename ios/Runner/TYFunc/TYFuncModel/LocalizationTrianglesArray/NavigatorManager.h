#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NavigatorManager : NSObject

@property (nonatomic) NSMutableArray * shouldattachalpha;

+ (instancetype) navigatorManagerWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) detachInteractor;

- (NSMutableDictionary *) shouldPresentStateless;

- (int) expandedTag;

- (NSMutableSet *) declarativeCycle;

- (NSMutableArray *) generateTicker;

@end

NS_ASSUME_NONNULL_END
        