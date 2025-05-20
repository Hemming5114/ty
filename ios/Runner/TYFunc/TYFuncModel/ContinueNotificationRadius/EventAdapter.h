#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EventAdapter : NSObject

@property (nonatomic) NSMutableSet * tappableequivalent;

+ (instancetype) eventAdapterWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) pushState;

- (NSMutableDictionary *) shouldEncodeBatch;

- (int) layoutSizedBox;

- (NSMutableSet *) pinchableReducer;

- (NSMutableArray *) pivotalPreview;

@end

NS_ASSUME_NONNULL_END
        