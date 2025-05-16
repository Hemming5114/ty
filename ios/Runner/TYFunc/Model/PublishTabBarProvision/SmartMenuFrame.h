#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SmartMenuFrame : NSObject

@property (nonatomic) NSMutableSet * shouldPersistRow;

@property (nonatomic) NSMutableArray * bloccallback;

+ (instancetype) smartMenuFrameWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) shouldUnmountedCache;

- (NSMutableDictionary *) undertakeText;

- (int) resizableRect;

- (NSMutableSet *) textVisitor;

- (NSMutableArray *) canLayoutFlex;

@end

NS_ASSUME_NONNULL_END
        