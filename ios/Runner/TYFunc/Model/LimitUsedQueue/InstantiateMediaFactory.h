#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InstantiateMediaFactory : NSObject

@property (nonatomic) NSMutableSet * desktopScenario;

+ (instancetype) instantiateMediaFactoryWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) usedEntropy;

- (NSMutableDictionary *) analyzeContainer;

- (int) shouldEncodeModal;

- (NSMutableSet *) canYieldComposition;

- (NSMutableArray *) movementOrientation;

@end

NS_ASSUME_NONNULL_END
        