#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MultiTextImage : NSObject

@property (nonatomic) NSString * associatedCurve;

+ (instancetype) multiTextImageWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) canShowInkWell;

- (NSMutableDictionary *) thresholdCount;

- (int) maxPainter;

- (NSMutableSet *) futureMode;

- (NSMutableArray *) shouldSetStateChallenge;

@end

NS_ASSUME_NONNULL_END
        