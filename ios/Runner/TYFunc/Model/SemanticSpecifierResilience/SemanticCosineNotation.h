#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SemanticCosineNotation : NSObject

@property (nonatomic) NSMutableArray * shouldDecodeSemantics;

@property (nonatomic) NSMutableArray * shouldEndChannels;

@property (nonatomic) NSMutableSet * localgrainflags;

@property (nonatomic) int eventState;

@property (nonatomic) NSMutableSet * detailFeedback;

+ (instancetype) semanticCosineNotationWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) consumeConstraint;

- (NSMutableDictionary *) shouldParseLabel;

- (int) curveDepth;

- (NSMutableSet *) canPrepareBuilder;

- (NSMutableArray *) primaryNotification;

@end

NS_ASSUME_NONNULL_END
        