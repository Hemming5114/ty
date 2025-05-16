#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OntoTaskReducer : NSObject


- (void) refreshMediaStorage;

- (void) withoutPlaybackSubscription;

- (void) sendProtectedThreadCommand: (NSMutableDictionary *)reactiveCache;

@end

NS_ASSUME_NONNULL_END
        