#import "StoryboardAdapter.h"
#import "ConformContainerList.h"
#import "ListenScaffoldFilter.h"
#import "DisconnectRichTextRequest.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResizableLoopAdapter : NSObject


- (void) serializeProjection;

- (void) setupGrain;

@end

NS_ASSUME_NONNULL_END
        