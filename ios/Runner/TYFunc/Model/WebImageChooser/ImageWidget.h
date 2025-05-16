#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageWidget : NSObject

@property (nonatomic) NSMutableArray * storelabel;

@property (nonatomic) NSString * entityShape;

+ (instancetype) imageWidgetWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) shouldUpdateSpot;

- (NSMutableDictionary *) usedLabel;

- (int) reliabilityKind;

- (NSMutableSet *) composableAscent;

- (NSMutableArray *) draggableSink;

@end

NS_ASSUME_NONNULL_END
        