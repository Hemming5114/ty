#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShearBrushNavigator : NSObject

@property (nonatomic) NSMutableSet * enabledSkirt;

@property (nonatomic) NSMutableSet * newestTrigger;

+ (instancetype) shearBrushNavigatorWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) firstDescent;

- (NSMutableDictionary *) shouldLayoutListView;

- (int) architecturespeed;

- (NSMutableSet *) escalatePreview;

- (NSMutableArray *) asynchronousMenu;

@end

NS_ASSUME_NONNULL_END
        