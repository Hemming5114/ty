#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasicTransformerCreator : NSObject

@property (nonatomic) NSString * shouldCacheDescriptor;

@property (nonatomic) NSMutableSet * missedPositioned;

+ (instancetype) basicTransformerCreatorWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) frameOffset;

- (NSMutableDictionary *) readNavigator;

- (int) canLayoutBehavior;

- (NSMutableSet *) finishCollection;

- (NSMutableArray *) buttonSpacing;

@end

NS_ASSUME_NONNULL_END
        