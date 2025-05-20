#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnimateInstructionCollection : NSObject

@property (nonatomic) NSMutableSet * mediumItem;

+ (instancetype) animateInstructionCollectionWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) shouldProcessStep;

- (NSMutableDictionary *) shouldMountSlider;

- (int) selectedStamp;

- (NSMutableSet *) restoreUtil;

- (NSMutableArray *) canTransitionPadding;

@end

NS_ASSUME_NONNULL_END
        