#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ObserveExplicitTransition : NSObject

@property (nonatomic) int unregisterframe;

+ (instancetype) observeExplicitTransitionWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) selectedAxis;

- (NSMutableDictionary *) blocCoord;

- (int) buttonvisitoralignment;

- (NSMutableSet *) canTransitionRichText;

- (NSMutableArray *) shouldResumeGridView;

@end

NS_ASSUME_NONNULL_END
        