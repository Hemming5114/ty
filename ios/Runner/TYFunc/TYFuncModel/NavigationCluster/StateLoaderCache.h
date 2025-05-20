#import "OnPositionedScene.h"
#import "ResizableZoneComponent.h"
#import "PrevListenerHelper.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StateLoaderCache : NSObject


- (void) disposeFuture;

- (void) notifyDelegateForBitrate;

@end

NS_ASSUME_NONNULL_END
        