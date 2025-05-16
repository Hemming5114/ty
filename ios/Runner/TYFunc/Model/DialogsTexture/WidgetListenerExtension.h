#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WidgetListenerExtension : NSObject

@property (nonatomic) NSMutableSet * pauseanimation;

@property (nonatomic) NSString * shouldHandleAlpha;

@property (nonatomic) NSMutableArray * scrollTag;

@property (nonatomic) NSMutableDictionary * arithmeticrouter;

+ (instancetype) widgetListenerExtensionWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) asynchronousCurve;

- (NSMutableDictionary *) shouldDisconnectSpot;

- (int) shaderMode;

- (NSMutableSet *) layoutperobserver;

- (NSMutableArray *) resizeObserver;

@end

NS_ASSUME_NONNULL_END
        