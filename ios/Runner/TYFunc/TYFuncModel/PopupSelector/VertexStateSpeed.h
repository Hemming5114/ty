#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VertexStateSpeed : NSObject

@property (nonatomic) NSMutableSet * shouldSerializeSwitch;

+ (instancetype) vertexStateSpeedWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) skipasset;

- (NSMutableDictionary *) resolveFeature;

- (int) pinchableSkin;

- (NSMutableSet *) capacitiesSkewY;

- (NSMutableArray *) anchorAction;

@end

NS_ASSUME_NONNULL_END
        