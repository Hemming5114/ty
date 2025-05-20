#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SustainableLogProvider : NSObject

@property (nonatomic) int shouldPersistOverlay;

@property (nonatomic) int shouldObserveStep;

@property (nonatomic) int mainWidget;

@property (nonatomic) NSString * analyzerShade;

+ (instancetype) sustainableLogProviderWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) shouldLayoutMobile;

- (NSMutableDictionary *) equipmentVelocity;

- (int) alertType;

- (NSMutableSet *) normalAlpha;

- (NSMutableArray *) currentInfo;

@end

NS_ASSUME_NONNULL_END
        