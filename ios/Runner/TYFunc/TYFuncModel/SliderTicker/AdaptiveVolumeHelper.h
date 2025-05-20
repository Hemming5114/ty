#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdaptiveVolumeHelper : NSObject

@property (nonatomic) int gesturedetectorvolume;

@property (nonatomic) NSMutableSet * currentSegment;

+ (instancetype) adaptiveVolumeHelperWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) granularCanvas;

- (NSMutableDictionary *) inactiveCharacteristic;

- (int) resolvercapacity;

- (NSMutableSet *) deserializeModulus;

- (NSMutableArray *) lastAllocator;

@end

NS_ASSUME_NONNULL_END
        