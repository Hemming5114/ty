#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnimateAlertHandler : NSObject

@property (nonatomic) NSMutableArray * hardColor;

+ (instancetype) animatealertHandlerWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) semanticBehavior;

- (NSMutableDictionary *) transformCache;

- (int) actionShade;

- (NSMutableSet *) sanitizeslider;

- (NSMutableArray *) scaffoldSpacing;

@end

NS_ASSUME_NONNULL_END
        