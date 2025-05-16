#import "BeginnerDialogsImplement.h"
#import "MonsterGroupCache.h"
#import "PersistentGramIsolate.h"
#import "DirectBlocIsolate.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SequentialRendererInstance : NSObject


- (void) paintTemporaryContainer;

- (void) subscribeCycleInsidePolygon;

@end

NS_ASSUME_NONNULL_END
        