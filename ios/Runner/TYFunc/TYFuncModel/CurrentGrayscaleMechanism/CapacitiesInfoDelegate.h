#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CapacitiesInfoDelegate : NSObject

@property (nonatomic) int gestureStyle;

@property (nonatomic) NSMutableSet * instructiontag;

+ (instancetype) capacitiesInfoDelegateWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) uniqueAxis;

- (NSMutableDictionary *) cleanProvider;

- (int) shouldResumeBloc;

- (NSMutableSet *) shouldDeserializeGrayscale;

- (NSMutableArray *) grainanimation;

@end

NS_ASSUME_NONNULL_END
        