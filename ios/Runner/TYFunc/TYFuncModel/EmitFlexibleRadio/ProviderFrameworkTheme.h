#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProviderFrameworkTheme : NSObject

@property (nonatomic) NSMutableDictionary * searcherKind;

+ (instancetype) providerFrameworkThemeWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) interactiveLocalization;

- (NSMutableDictionary *) implementFactory;

- (int) layoutTint;

- (NSMutableSet *) adaptiveRect;

- (NSMutableArray *) promiseNumber;

@end

NS_ASSUME_NONNULL_END
        