#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SessionConfigurationCollection : NSObject

@property (nonatomic) NSString * localEvaluation;

@property (nonatomic) int detailDelay;

+ (instancetype) sessionConfigurationCollectionWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) cycleLocation;

- (NSMutableDictionary *) ignoredAnimatedContainer;

- (int) defaulttext;

- (NSMutableSet *) pivotaltime;

- (NSMutableArray *) listenerTask;

@end

NS_ASSUME_NONNULL_END
        