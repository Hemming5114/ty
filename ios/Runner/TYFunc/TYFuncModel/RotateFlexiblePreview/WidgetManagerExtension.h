#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WidgetManagerExtension : NSObject

@property (nonatomic) int keyDetector;

+ (instancetype) widgetManagerExtensionWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) detachCollection;

- (NSMutableDictionary *) standaloneScene;

- (int) ascentTransparency;

- (NSMutableSet *) canUnmountPromise;

- (NSMutableArray *) agilemesh;

@end

NS_ASSUME_NONNULL_END
        