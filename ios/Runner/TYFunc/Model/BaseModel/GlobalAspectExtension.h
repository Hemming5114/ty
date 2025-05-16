#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalAspectExtension : NSObject

@property (nonatomic) NSMutableDictionary * globalLoop;

+ (instancetype) globalAspectExtensionWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) specifyBuilder;

- (NSMutableDictionary *) synchronousAnimation;

- (int) canKeepStep;

- (NSMutableSet *) priorRange;

- (NSMutableArray *) canNotifyMediaQuery;

@end

NS_ASSUME_NONNULL_END
        