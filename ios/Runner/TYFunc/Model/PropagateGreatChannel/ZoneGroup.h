#import "ErrorLinkerList.h"
#import "HyperbolicDenseStore.h"
#import "PopMemberDetector.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZoneGroup : NSObject


- (void) keepIndependentHandler;

- (void) locateCycleZone;

@end

NS_ASSUME_NONNULL_END
        