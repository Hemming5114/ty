#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompileStampMethod : NSObject

@property (nonatomic) int shouldInflateDescriptor;

+ (instancetype) compileStampMethodWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) saveObserver;

- (NSMutableDictionary *) deferredDialogs;

- (int) vectorSkewX;

- (NSMutableSet *) emitMediaQuery;

- (NSMutableArray *) pinchableMethod;

@end

NS_ASSUME_NONNULL_END
        