#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistogramActionTag : NSObject

@property (nonatomic) NSString * shouldPersistBox;

+ (instancetype) histogramActionTagWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) commonsize;

- (NSMutableDictionary *) currentTimeline;

- (int) shouldPresentGate;

- (NSMutableSet *) projectopacity;

- (NSMutableArray *) persistInteger;

@end

NS_ASSUME_NONNULL_END
        