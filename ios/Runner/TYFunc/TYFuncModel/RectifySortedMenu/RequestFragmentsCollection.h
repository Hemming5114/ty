#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RequestFragmentsCollection : NSObject

@property (nonatomic) NSMutableDictionary * seamlessTime;

@property (nonatomic) NSString * fixedPolygon;

@property (nonatomic) int contractioncount;

+ (instancetype) requestFragmentsCollectionWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) canDismissPlayback;

- (NSMutableDictionary *) rebuildChannels;

- (int) resumeduration;

- (NSMutableSet *) sequentialCreator;

- (NSMutableArray *) shouldReplaceDecoration;

@end

NS_ASSUME_NONNULL_END
        