#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TensorStreamImage : NSObject

@property (nonatomic) int visibleCycle;

+ (instancetype) tensorStreamImageWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) scrollabledecorationmode;

- (NSMutableDictionary *) canEmitCache;

- (int) containerinfo;

- (NSMutableSet *) reusableInfo;

- (NSMutableArray *) shouldAttachAperture;

@end

NS_ASSUME_NONNULL_END
        