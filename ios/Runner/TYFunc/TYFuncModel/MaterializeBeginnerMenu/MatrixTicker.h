#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MatrixTicker : NSObject

@property (nonatomic) int shouldUnbindExpanded;

@property (nonatomic) NSMutableSet * lazyrichtext;

@property (nonatomic) NSMutableDictionary * playbackMomentum;

+ (instancetype) matrixTickerWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) semanticTimeline;

- (NSMutableDictionary *) newestState;

- (int) shouldCancelScroll;

- (NSMutableSet *) swiftEdge;

- (NSMutableArray *) matrixCycle;

@end

NS_ASSUME_NONNULL_END
        