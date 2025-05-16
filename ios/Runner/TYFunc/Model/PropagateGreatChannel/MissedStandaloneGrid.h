#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MissedStandaloneGrid : NSObject

@property (nonatomic) int shouldUnmountTool;

+ (instancetype) missedStandaloneGridWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) disposeAlpha;

- (NSMutableDictionary *) storyboardValue;

- (int) shouldPublishWidget;

- (NSMutableSet *) statefulCapacities;

- (NSMutableArray *) accordionSelector;

@end

NS_ASSUME_NONNULL_END
        