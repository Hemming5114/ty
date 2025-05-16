#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MusicRowObserver : NSObject

@property (nonatomic) NSMutableArray * shouldTransformCache;

@property (nonatomic) NSMutableDictionary * unactivatedOperation;

@property (nonatomic) NSMutableSet * shouldBuildTable;

+ (instancetype) musicRowObserverWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) localSingleton;

- (NSMutableDictionary *) streamType;

- (int) shouldPrepareOption;

- (NSMutableSet *) shouldUnbindMovement;

- (NSMutableArray *) layerdispatcher;

@end

NS_ASSUME_NONNULL_END
        