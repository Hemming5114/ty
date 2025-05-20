#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WidgetCompositeBorder : NSObject

@property (nonatomic) NSMutableDictionary * explicitAnchor;

+ (instancetype) widgetCompositeBorderWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) resizableDecoration;

- (NSMutableDictionary *) obtainCallback;

- (int) discardedSensor;

- (NSMutableSet *) backwardLoader;

- (NSMutableArray *) asynchronousShader;

@end

NS_ASSUME_NONNULL_END
        