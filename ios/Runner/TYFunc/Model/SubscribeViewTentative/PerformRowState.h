#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PerformRowState : NSObject

@property (nonatomic) NSString * prevSearcher;

+ (instancetype) performRowStateWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) mutableRange;

- (NSMutableDictionary *) canSaveBox;

- (int) capacityFormat;

- (NSMutableSet *) shouldObserveNotification;

- (NSMutableArray *) ephemeralCurve;

@end

NS_ASSUME_NONNULL_END
        