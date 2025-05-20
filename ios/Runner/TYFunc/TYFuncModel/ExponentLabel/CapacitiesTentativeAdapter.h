#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CapacitiesTentativeAdapter : NSObject

@property (nonatomic) NSMutableDictionary * shouldFinishReference;

@property (nonatomic) NSMutableArray * platePosition;

+ (instancetype) capacitiesTentativeAdapterWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) canEmitInstruction;

- (NSMutableDictionary *) canStreamHistogram;

- (int) mountedNavigation;

- (NSMutableSet *) shouldNavigateLabel;

- (NSMutableArray *) performChapter;

@end

NS_ASSUME_NONNULL_END
        