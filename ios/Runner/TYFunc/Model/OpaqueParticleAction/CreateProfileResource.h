#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreateProfileResource : NSObject

@property (nonatomic) int replicaIndex;

+ (instancetype) createProfileResourceWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) groupVar;

- (NSMutableDictionary *) tappableCertificate;

- (int) resourceDecorator;

- (NSMutableSet *) shouldTransformRole;

- (NSMutableArray *) shouldEndTabView;

@end

NS_ASSUME_NONNULL_END
        