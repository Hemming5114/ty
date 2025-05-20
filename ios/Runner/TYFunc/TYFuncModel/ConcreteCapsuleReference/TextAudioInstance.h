#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextAudioInstance : NSObject

@property (nonatomic) NSString * modelLocation;

@property (nonatomic) int dispatcherRate;

@property (nonatomic) NSMutableArray * infoKind;

@property (nonatomic) NSMutableDictionary * draggableExtension;

+ (instancetype) textAudioInstanceWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) standaloneMetadata;

- (NSMutableDictionary *) sampleVariable;

- (int) textfieldacceleration;

- (NSMutableSet *) referencetail;

- (NSMutableArray *) canDecodeReference;

@end

NS_ASSUME_NONNULL_END
        