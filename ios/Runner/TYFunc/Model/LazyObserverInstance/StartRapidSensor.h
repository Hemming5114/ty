#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StartRapidSensor : NSObject

@property (nonatomic) NSMutableArray * schemaFormat;

@property (nonatomic) NSMutableDictionary * lazyBloc;

+ (instancetype) startRapidsensorWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) shouldCreateClipper;

- (NSMutableDictionary *) radiusStrategy;

- (int) shouldCancelModal;

- (NSMutableSet *) mainTouch;

- (NSMutableArray *) channelTier;

@end

NS_ASSUME_NONNULL_END
        