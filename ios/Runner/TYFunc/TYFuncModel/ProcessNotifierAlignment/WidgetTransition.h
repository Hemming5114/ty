#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WidgetTransition : NSObject

@property (nonatomic) NSMutableArray * animatedGraphic;

@property (nonatomic) NSMutableSet * resourcePosition;

@property (nonatomic) NSString * shouldPersistInkWell;

+ (instancetype) widgetTransitionWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) overlayMemento;

- (NSMutableDictionary *) asyncBound;

- (int) canTrainUsage;

- (NSMutableSet *) graphicvisitorstatus;

- (NSMutableArray *) decodeStack;

@end

NS_ASSUME_NONNULL_END
        