#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DiscardedMediaNavigator : NSObject

@property (nonatomic) NSMutableSet * hardEvent;

@property (nonatomic) NSMutableSet * lasttitle;

@property (nonatomic) NSMutableDictionary * statefulBandwidth;

@property (nonatomic) NSMutableDictionary * intermediateinformation;

@property (nonatomic) NSMutableDictionary * denseMember;

+ (instancetype) discardedMediaNavigatorWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) compositionType;

- (NSMutableDictionary *) copyimage;

- (int) shouldStartLoss;

- (NSMutableSet *) backwardText;

- (NSMutableArray *) histogramRotation;

@end

NS_ASSUME_NONNULL_END
        