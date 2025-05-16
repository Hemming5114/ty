#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReadTableMapper : NSObject

@property (nonatomic) NSMutableArray * nativeSink;

+ (instancetype) readTableMapperWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) explicitProfile;

- (NSMutableDictionary *) batchFormat;

- (int) customSegment;

- (NSMutableSet *) insteadStore;

- (NSMutableArray *) sequentialVideo;

@end

NS_ASSUME_NONNULL_END
        