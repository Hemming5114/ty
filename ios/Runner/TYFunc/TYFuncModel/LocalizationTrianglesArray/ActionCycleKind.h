#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActionCycleKind : NSObject

@property (nonatomic) NSMutableSet * unsortedbehavior;

+ (instancetype) actionCycleKindWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) commonSubpixel;

- (NSMutableDictionary *) shouldParseCell;

- (int) thresholdVisibility;

- (NSMutableSet *) scaleBorder;

- (NSMutableArray *) prevGram;

@end

NS_ASSUME_NONNULL_END
        