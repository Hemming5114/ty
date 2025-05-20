#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyEagerConfiguration : NSObject

@property (nonatomic) NSMutableDictionary * smartCaption;

@property (nonatomic) NSMutableArray * parallelTimeline;

+ (instancetype) keyEagerConfigurationWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) canSaveSegue;

- (NSMutableDictionary *) schedulervisibility;

- (int) interceptOffset;

- (NSMutableSet *) stopChannels;

- (NSMutableArray *) canDisconnectProjection;

@end

NS_ASSUME_NONNULL_END
        