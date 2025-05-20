#import "SubscriptionChooser.h"
#import "FlexibleGraphGroup.h"
#import "MediaRect.h"
#import "ByAppBarAudio.h"
#import "ImmediatePickerBase.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuildCapsuleCallback : NSObject


- (void) skipDedicatedMaster;

- (void) refreshSmallTicker;

@end

NS_ASSUME_NONNULL_END
        