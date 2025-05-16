#import "DraggablePermissiveTransformer.h"
#import "IntoAppBarScope.h"
#import "IgnoredPositionDelegate.h"
#import "ResizableSpecifierPosition.h"
#import "ActivatedTransformerVertex.h"
#import "AcrossGrainReducer.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HardTransformerTarget : NSObject


- (void) renderMemberContainResponder;

- (void) attachAccessibleOverlay;

@end

NS_ASSUME_NONNULL_END
        