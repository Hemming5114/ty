#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FinishStackResult : NSObject

@property (nonatomic) NSMutableDictionary * sharedInkWell;

+ (instancetype) finishStackResultWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) validatePlayback;

- (NSMutableDictionary *) shouldParseSemantics;

- (int) fetchSpecifier;

- (NSMutableSet *) refreshHandler;

- (NSMutableArray *) canLoadBoxShadow;

@end

NS_ASSUME_NONNULL_END
        