#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimerModuleBase : NSObject

@property (nonatomic) int subsequentTitle;

+ (instancetype) timerModuleBaseWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) shouldParseProfile;

- (NSMutableDictionary *) handleEquipment;

- (int) reflectRow;

- (NSMutableSet *) exitResource;

- (NSMutableArray *) frameSingleton;

@end

NS_ASSUME_NONNULL_END
        