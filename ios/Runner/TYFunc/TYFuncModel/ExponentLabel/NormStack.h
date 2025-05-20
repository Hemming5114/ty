#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NormStack : NSObject

@property (nonatomic) NSMutableDictionary * sharedMusic;

@property (nonatomic) int decodegroup;

@property (nonatomic) int shoulddisconnecticon;

@property (nonatomic) NSString * reducermethodtag;

+ (instancetype) normStackWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) moveLabel;

- (NSMutableDictionary *) shouldFinishScreen;

- (int) shouldSetStateCard;

- (NSMutableSet *) singleSubscriber;

- (NSMutableArray *) conformChart;

@end

NS_ASSUME_NONNULL_END
        