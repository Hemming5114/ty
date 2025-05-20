#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoordinatorResultHandler : NSObject

@property (nonatomic) NSString * subpixeltransparency;

@property (nonatomic) int onoperationtap;

@property (nonatomic) NSString * shouldShowSubpixel;

+ (instancetype) coordinatorResultHandlerWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) canAttachTabView;

- (NSMutableDictionary *) observerTint;

- (int) analyzerScale;

- (NSMutableSet *) shouldpausesegue;

- (NSMutableArray *) inheritedListView;

@end

NS_ASSUME_NONNULL_END
        