#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThroughWidgetEmitter : NSObject

@property (nonatomic) NSMutableSet * pivotalDependency;

+ (instancetype) throughWidgetEmitterWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) statefulHandler;

- (NSMutableDictionary *) cacheResponse;

- (int) canPushRichText;

- (NSMutableSet *) shouldcacherow;

- (NSMutableArray *) backwardBullet;

@end

NS_ASSUME_NONNULL_END
        