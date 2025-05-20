#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScreenEfficiencyFactory : NSObject

@property (nonatomic) NSMutableArray * sortedFormat;

@property (nonatomic) int polyfillSpacing;

+ (instancetype) screenEfficiencyFactoryWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) richtextInset;

- (NSMutableDictionary *) accessibleCaption;

- (int) batchVisibility;

- (NSMutableSet *) canResumeStream;

- (NSMutableArray *) canvasStage;

@end

NS_ASSUME_NONNULL_END
        