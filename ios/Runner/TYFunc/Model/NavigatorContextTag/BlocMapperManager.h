#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlocMapperManager : NSObject

@property (nonatomic) NSMutableArray * lazytween;

@property (nonatomic) NSMutableArray * shouldDeserializeStep;

@property (nonatomic) int usedtextdepth;

@property (nonatomic) NSMutableSet * remainderformat;

@property (nonatomic) NSMutableSet * persiststate;

+ (instancetype) blocMapperManagerWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) pendingNotifier;

- (NSMutableDictionary *) canStreamDrawer;

- (int) shouldPrepareFuture;

- (NSMutableSet *) unbindCanvas;

- (NSMutableArray *) parseAnimation;

@end

NS_ASSUME_NONNULL_END
        