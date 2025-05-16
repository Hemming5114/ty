#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OntoLossImpression : NSObject

@property (nonatomic) int granularNode;

+ (instancetype) ontoLossImpressionWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) shouldDetachMatrix;

- (NSMutableDictionary *) extensionMemento;

- (int) shouldPersistSample;

- (NSMutableSet *) permissiveGroup;

- (NSMutableArray *) renderGestureDetector;

@end

NS_ASSUME_NONNULL_END
        