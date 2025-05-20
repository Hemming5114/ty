#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SubscriptionReference : NSObject

@property (nonatomic) NSMutableArray * lastNotification;

@property (nonatomic) NSMutableDictionary * shouldObserveAccessory;

@property (nonatomic) NSMutableSet * activeLatency;

@property (nonatomic) NSMutableDictionary * lastMatrix;

@property (nonatomic) NSMutableDictionary * layerPressure;

@property (nonatomic) NSMutableArray * specifyScope;

+ (instancetype) subscriptionReferenceWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) interactiveAudio;

- (NSMutableDictionary *) catalystlistener;

- (int) linkerScale;

- (NSMutableSet *) shouldDisposeNib;

- (NSMutableArray *) priorAlignment;

@end

NS_ASSUME_NONNULL_END
        