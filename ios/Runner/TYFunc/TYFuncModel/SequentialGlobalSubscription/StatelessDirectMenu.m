#import "StatelessDirectMenu.h"
    
@interface StatelessDirectMenu ()

@end

@implementation StatelessDirectMenu

- (void) cancelPermanentLabel: (NSString *)findcompleter
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSMutableDictionary *pauseLabel = [NSMutableDictionary dictionary];
		pauseLabel[@"None"] = [UIColor colorNamed:@"blackColor"];;
		pauseLabel[@"None"] = @413;
		[findcompleter drawAtPoint:CGPointMake(477, 433) withAttributes:pauseLabel];
		UIProgressView *mapAcceleration = [[UIProgressView alloc] init];
		mapAcceleration.frame = CGRectMake(46.000000, 20.000000, 68.000000, 50.000000);
		mapAcceleration.frame = CGRectMake(16.000000, 12.000000, 39.000000, 64.000000);
		mapAcceleration.layer.borderWidth = 8;
		mapAcceleration.layer.borderColor = [UIColor colorWithRed:179/255.0 green:59/255.0 blue:42/255.0 alpha:0].CGColor;
		mapAcceleration.progress = 46;
		mapAcceleration.progressTintColor = [UIColor colorWithRed:79/255.0 green:238/255.0 blue:101/255.0 alpha:0];
		mapAcceleration.trackTintColor = [UIColor colorWithRed:154/255.0 green:47/255.0 blue:94/255.0 alpha:0];
		mapAcceleration.progressViewStyle = UIProgressViewStyleDefault;
		[mapAcceleration exerciseAmbiguityInLayout];
		//NSLog(@"sets= bussiness1 gen_str %@", bussiness1);
	});
}


@end
        