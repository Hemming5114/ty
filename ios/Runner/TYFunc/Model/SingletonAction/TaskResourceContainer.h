#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskResourceContainer : NSObject

@property (nonatomic) NSMutableArray * shouldUnbindGesture;

+ (instancetype) taskResourceContainerWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) shouldBuildCell;

- (NSMutableDictionary *) pivotalController;

- (int) originalFactory;

- (NSMutableSet *) canHandleProtocol;

- (NSMutableArray *) graphOperation;

@end

NS_ASSUME_NONNULL_END
        