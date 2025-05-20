#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IndicatorFuture : NSObject

@property (nonatomic) NSString * associatedTheme;

+ (instancetype) indicatorFutureWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) skipCell;

- (NSMutableDictionary *) unmarshalFrame;

- (int) shouldAnimateRemainder;

- (NSMutableSet *) coordinatorCenter;

- (NSMutableArray *) canContinueSpine;

@end

NS_ASSUME_NONNULL_END
        