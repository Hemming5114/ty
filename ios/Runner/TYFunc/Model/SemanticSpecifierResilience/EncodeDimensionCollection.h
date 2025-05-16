#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EncodeDimensionCollection : NSObject

@property (nonatomic) NSString * loopSkewY;

+ (instancetype) encodeDimensionCollectionWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) shouldRouteIcon;

- (NSMutableDictionary *) prevAudio;

- (int) augmentGrain;

- (NSMutableSet *) diffableCheckbox;

- (NSMutableArray *) previewDelay;

@end

NS_ASSUME_NONNULL_END
        