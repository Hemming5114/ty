#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnbindCapsuleExtension : NSObject

@property (nonatomic) int referenceHue;

+ (instancetype) unbindCapsuleExtensionWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) metricsFlags;

- (NSMutableDictionary *) multiLifecycle;

- (int) smartLog;

- (NSMutableSet *) shouldPaintAspectRatio;

- (NSMutableArray *) canEncodeView;

@end

NS_ASSUME_NONNULL_END
        