#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FromCharacterBloc : NSObject

@property (nonatomic) NSMutableDictionary * hierarchicalBuilder;

+ (instancetype) fromCharacterBlocWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) shaderPattern;

- (NSMutableDictionary *) canHandleVariant;

- (int) otherPresenter;

- (NSMutableSet *) prevSize;

- (NSMutableArray *) mutableProgressBar;

@end

NS_ASSUME_NONNULL_END
        