#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UniquePlaybackScheduler : NSObject


- (void) dismissCopyOffStateful: (NSMutableSet *)permanentDistinction;

- (void) processPersistentComposition: (int)oldGraph;

@end

NS_ASSUME_NONNULL_END
        