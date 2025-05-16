#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MissedCertificateAnimator : NSObject

@property (nonatomic) int emitterValidation;

@property (nonatomic) NSMutableArray * activatedJoiner;

@property (nonatomic) NSMutableDictionary * semanticMetadata;

+ (instancetype) missedCertificateAnimatorWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) instantiateWidget;

- (NSMutableDictionary *) materialCell;

- (int) shouldFormatSession;

- (NSMutableSet *) responsiveRemainder;

- (NSMutableArray *) canPersistHistogram;

@end

NS_ASSUME_NONNULL_END
        