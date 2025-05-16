#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LayoutConsumer : NSObject

@property (nonatomic) NSMutableDictionary * popupName;

+ (instancetype) layoutConsumerWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) canParseCertificate;

- (NSMutableDictionary *) canShowButton;

- (int) shouldAnimateIndicator;

- (NSMutableSet *) statefulCoord;

- (NSMutableArray *) declarativeObserver;

@end

NS_ASSUME_NONNULL_END
        