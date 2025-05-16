#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MountBrushResult : NSObject


- (void) decodeShaderState: (int)ignoredVariant;

- (void) restoreCustomCallback;

- (void) makeCanvasState;

@end

NS_ASSUME_NONNULL_END
        