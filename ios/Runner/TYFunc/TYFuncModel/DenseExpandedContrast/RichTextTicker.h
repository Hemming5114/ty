#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RichTextTicker : NSObject

@property (nonatomic) int disparateFilter;

+ (instancetype) richTextTickerWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) blocFrequency;

- (NSMutableDictionary *) borderPadding;

- (int) shouldStopStateful;

- (NSMutableSet *) shouldUnmountSample;

- (NSMutableArray *) buttonopacity;

@end

NS_ASSUME_NONNULL_END
        