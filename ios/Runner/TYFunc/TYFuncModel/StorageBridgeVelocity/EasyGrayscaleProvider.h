#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EasyGrayscaleProvider : NSObject

@property (nonatomic) NSMutableSet * modulusagainststate;

@property (nonatomic) NSMutableDictionary * shouldLoadBaseline;

+ (instancetype) easyGrayscaleProviderWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) shouldcachelog;

- (NSMutableDictionary *) marshalDescription;

- (int) stringifyMetadata;

- (NSMutableSet *) listeneroperationstate;

- (NSMutableArray *) newestResult;

@end

NS_ASSUME_NONNULL_END
        