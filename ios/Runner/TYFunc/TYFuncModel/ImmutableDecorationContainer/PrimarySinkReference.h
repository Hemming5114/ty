#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PrimarySinkReference : NSObject

@property (nonatomic) NSMutableSet * functionalInterface;

@property (nonatomic) NSString * tappableTimeline;

+ (instancetype) primarySinkReferenceWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) transformerScale;

- (NSMutableDictionary *) canStartSample;

- (int) optionType;

- (NSMutableSet *) buildCatalyst;

- (NSMutableArray *) largeTraversal;

@end

NS_ASSUME_NONNULL_END
        