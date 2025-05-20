#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProviderState : NSObject

@property (nonatomic) NSString * localPromise;

+ (instancetype) providerStateWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) immediateAmortization;

- (NSMutableDictionary *) deflateHash;

- (int) switchComposite;

- (NSMutableSet *) layerProxy;

- (NSMutableArray *) uniformCanvas;

@end

NS_ASSUME_NONNULL_END
        