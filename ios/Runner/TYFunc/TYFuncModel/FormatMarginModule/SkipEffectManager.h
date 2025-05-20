#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SkipEffectManager : NSObject

@property (nonatomic) NSMutableSet * discardedPicker;

+ (instancetype) skipEffectManagerWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) sequentialMetadata;

- (NSMutableDictionary *) deferredCallback;

- (int) radioamongtype;

- (NSMutableSet *) actionFeedback;

- (NSMutableArray *) zoneShade;

@end

NS_ASSUME_NONNULL_END
        