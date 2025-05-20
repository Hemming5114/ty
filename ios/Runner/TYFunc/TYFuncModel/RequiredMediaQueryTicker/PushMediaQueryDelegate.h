#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PushMediaQueryDelegate : NSObject

@property (nonatomic) int interactorBorder;

@property (nonatomic) NSMutableSet * ignoredStroke;

@property (nonatomic) int resilientMetrics;

+ (instancetype) pushMediaQueryDelegateWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) shoulddetachprofile;

- (NSMutableDictionary *) consumptionStyle;

- (int) channelcycleopacity;

- (NSMutableSet *) parseBitrate;

- (NSMutableArray *) navigateBullet;

@end

NS_ASSUME_NONNULL_END
        