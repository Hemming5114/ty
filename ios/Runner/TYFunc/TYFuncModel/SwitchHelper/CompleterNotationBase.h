#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompleterNotationBase : NSObject

@property (nonatomic) NSMutableDictionary * equivalentpadding;

+ (instancetype) completerNotationBaseWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) shouldvalidatenavigator;

- (NSMutableDictionary *) preparereducer;

- (int) fragmentdecoration;

- (NSMutableSet *) routerelement;

- (NSMutableArray *) limitInterface;

@end

NS_ASSUME_NONNULL_END
        