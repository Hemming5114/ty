#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PriorTopicMatrix : NSObject

@property (nonatomic) NSMutableArray * missedFragment;

@property (nonatomic) NSString * numericalCell;

+ (instancetype) priorTopicMatrixWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) persistSpine;

- (NSMutableDictionary *) updateChapter;

- (int) showCompleter;

- (NSMutableSet *) restrictionSpacing;

- (NSMutableArray *) nibFunction;

@end

NS_ASSUME_NONNULL_END
        