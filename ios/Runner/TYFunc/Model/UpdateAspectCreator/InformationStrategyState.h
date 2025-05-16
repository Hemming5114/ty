#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InformationStrategyState : NSObject

@property (nonatomic) NSString * fragmentcontainer;

+ (instancetype) informationStrategyStateWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) volumeFlags;

- (NSMutableDictionary *) pendingAspect;

- (int) shouldObserveScaffold;

- (NSMutableSet *) canDeserializeSensor;

- (NSMutableArray *) dynamicConstraint;

@end

NS_ASSUME_NONNULL_END
        