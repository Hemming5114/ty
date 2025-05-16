#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StatefulNotation : NSObject

@property (nonatomic) NSMutableArray * interactiveObject;

@property (nonatomic) int materialCoord;

+ (instancetype) statefulNotationWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) robustBehavior;

- (NSMutableDictionary *) stopKernel;

- (int) playCompleter;

- (NSMutableSet *) activatedTrajectory;

- (NSMutableArray *) currentmatrix;

@end

NS_ASSUME_NONNULL_END
        