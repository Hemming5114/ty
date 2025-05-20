#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AxisBufferOwner : NSObject

@property (nonatomic) NSMutableSet * logVisible;

+ (instancetype) axisBufferOwnerWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) paintLog;

- (NSMutableDictionary *) dispatchCollection;

- (int) fusedHero;

- (NSMutableSet *) graphicInteraction;

- (NSMutableArray *) popview;

@end

NS_ASSUME_NONNULL_END
        