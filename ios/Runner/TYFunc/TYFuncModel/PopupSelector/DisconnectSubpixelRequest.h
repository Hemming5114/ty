#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DisconnectSubpixelRequest : NSObject

@property (nonatomic) NSMutableArray * standaloneAccessory;

+ (instancetype) disconnectSubpixelRequestWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) shouldUpdateVariant;

- (NSMutableDictionary *) offsetTimer;

- (int) sharedSizedBox;

- (NSMutableSet *) linkerbrightness;

- (NSMutableArray *) createSegment;

@end

NS_ASSUME_NONNULL_END
        