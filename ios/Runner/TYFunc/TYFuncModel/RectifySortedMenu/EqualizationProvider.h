#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EqualizationProvider : NSObject

@property (nonatomic) int unactivatedGesture;

@property (nonatomic) NSMutableArray * fixedPlayback;

@property (nonatomic) int associatedOccasion;

+ (instancetype) equalizationProviderWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) shouldFinishHistogram;

- (NSMutableDictionary *) prevView;

- (int) replaceBullet;

- (NSMutableSet *) shouldHandleShader;

- (NSMutableArray *) cartesianOffset;

@end

NS_ASSUME_NONNULL_END
        