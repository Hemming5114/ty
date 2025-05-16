#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClipNavigatorAdapter : NSObject

@property (nonatomic) NSMutableDictionary * processmodel;

@property (nonatomic) NSMutableDictionary * resolverPressure;

+ (instancetype) clipNavigatorAdapterWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) originalColor;

- (NSMutableDictionary *) wrapFactory;

- (int) missionKind;

- (NSMutableSet *) shouldObserveBloc;

- (NSMutableArray *) customGram;

@end

NS_ASSUME_NONNULL_END
        