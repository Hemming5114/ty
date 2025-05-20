#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SensorOwner : NSObject

@property (nonatomic) NSMutableSet * shouldPresentTabView;

@property (nonatomic) int statefulPet;

@property (nonatomic) NSMutableArray * activeConsumption;

@property (nonatomic) NSMutableDictionary * remainderOrigin;

@property (nonatomic) NSMutableArray * unactivatedSchema;

+ (instancetype) sensorOwnerWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) accordionBaseline;

- (NSMutableDictionary *) statefulSorter;

- (int) shouldValidateDocument;

- (NSMutableSet *) viewPhase;

- (NSMutableArray *) shouldPushCompletion;

@end

NS_ASSUME_NONNULL_END
        