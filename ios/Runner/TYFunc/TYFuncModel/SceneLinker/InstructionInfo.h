#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InstructionInfo : NSObject

@property (nonatomic) int prevGrain;

@property (nonatomic) NSMutableDictionary * slidertag;

+ (instancetype) instructioninfoWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) deserializeBinary;

- (NSMutableDictionary *) radiospacing;

- (int) observeExtension;

- (NSMutableSet *) layoutCanvas;

- (NSMutableArray *) canDisposeProject;

@end

NS_ASSUME_NONNULL_END
        