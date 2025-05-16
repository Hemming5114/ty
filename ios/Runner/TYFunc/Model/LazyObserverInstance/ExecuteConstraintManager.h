#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExecuteConstraintManager : NSObject

@property (nonatomic) NSString * permanentCanvas;

+ (instancetype) executeConstraintManagerWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) persistoverlay;

- (NSMutableDictionary *) layoutParameter;

- (int) fillPosition;

- (NSMutableSet *) originalConnector;

- (NSMutableArray *) canLoadSpot;

@end

NS_ASSUME_NONNULL_END
        