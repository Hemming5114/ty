#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SmartListenerBase : NSObject

@property (nonatomic) int captionOffset;

@property (nonatomic) int shouldTransitionTechnique;

+ (instancetype) smartListenerBaseWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) factoryStatus;

- (NSMutableDictionary *) segueAdapter;

- (int) canDecodeBuilder;

- (NSMutableSet *) sensorcenter;

- (NSMutableArray *) nibFacade;

@end

NS_ASSUME_NONNULL_END
        