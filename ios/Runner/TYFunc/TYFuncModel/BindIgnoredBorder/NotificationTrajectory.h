#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotificationTrajectory : NSObject

@property (nonatomic) int enabledTween;

@property (nonatomic) NSMutableDictionary * equipmentOffset;

@property (nonatomic) NSMutableSet * chapterdirection;

@property (nonatomic) NSString * shouldPublishTextField;

+ (instancetype) notificationTrajectoryWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) streamConsumer;

- (NSMutableDictionary *) functionalNavigator;

- (int) shouldStartNotification;

- (NSMutableSet *) capsuleDepth;

- (NSMutableArray *) fragmentsColor;

@end

NS_ASSUME_NONNULL_END
        