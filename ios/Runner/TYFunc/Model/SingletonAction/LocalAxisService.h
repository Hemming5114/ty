#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalAxisService : NSObject

@property (nonatomic) int granularGesture;

@property (nonatomic) NSMutableSet * lastDuration;

@property (nonatomic) NSMutableSet * hasPadding;

@property (nonatomic) NSMutableSet * discardedPainter;

+ (instancetype) localAxisServiceWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) canCancelSkirt;

- (NSMutableDictionary *) prevInterface;

- (int) scrollableBuilder;

- (NSMutableSet *) shouldBindCompletion;

- (NSMutableArray *) shouldDispatchScroll;

@end

NS_ASSUME_NONNULL_END
        