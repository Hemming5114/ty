#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChannelFactoryDelegate : NSObject

@property (nonatomic) NSMutableSet * declarativeMetadata;

+ (instancetype) channelFactoryDelegateWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) vectorformat;

- (NSMutableDictionary *) toolOrientation;

- (int) binderBehavior;

- (NSMutableSet *) replacehandler;

- (NSMutableArray *) mechanismInteraction;

@end

NS_ASSUME_NONNULL_END
        