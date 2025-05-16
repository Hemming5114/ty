#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LayerInfo : NSObject

@property (nonatomic) NSMutableSet * resizablePlayback;

+ (instancetype) layerInfoWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) basicBaseline;

- (NSMutableDictionary *) layoutBaseline;

- (int) unmarshalcontainer;

- (NSMutableSet *) invisibleResponder;

- (NSMutableArray *) retainedProtocol;

@end

NS_ASSUME_NONNULL_END
        