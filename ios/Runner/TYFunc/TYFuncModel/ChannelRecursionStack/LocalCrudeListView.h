#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalCrudeListView : NSObject

@property (nonatomic) NSString * logOrigin;

+ (instancetype) localCrudelistViewWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) disconnectNotification;

- (NSMutableDictionary *) introspecthash;

- (int) mediumTopic;

- (NSMutableSet *) pendingUnary;

- (NSMutableArray *) channelBrightness;

@end

NS_ASSUME_NONNULL_END
        