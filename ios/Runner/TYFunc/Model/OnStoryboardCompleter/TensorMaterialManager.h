#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TensorMaterialManager : NSObject

@property (nonatomic) NSString * mediumParticle;

@property (nonatomic) int sequentialdimension;

+ (instancetype) tensorMaterialManagerWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) graphCenter;

- (NSMutableDictionary *) shouldPaintMargin;

- (int) usecaseVisitor;

- (NSMutableSet *) popupvisible;

- (NSMutableArray *) pauseGate;

@end

NS_ASSUME_NONNULL_END
        