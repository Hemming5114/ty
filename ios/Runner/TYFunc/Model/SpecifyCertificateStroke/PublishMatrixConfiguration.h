#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublishMatrixConfiguration : NSObject

@property (nonatomic) int deliveryFrequency;

+ (instancetype) publishMatrixConfigurationWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) symbolbutton;

- (NSMutableDictionary *) specifyUseCase;

- (int) canDismissDrawer;

- (NSMutableSet *) listenEquipment;

- (NSMutableArray *) originalRichText;

@end

NS_ASSUME_NONNULL_END
        