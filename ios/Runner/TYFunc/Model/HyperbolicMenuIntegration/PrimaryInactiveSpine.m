#import "PrimaryInactiveSpine.h"
    
@interface PrimaryInactiveSpine ()

@end

@implementation PrimaryInactiveSpine

- (void) wantCancelResource: (int)tappableEntity
{
	dispatch_async(dispatch_get_main_queue(), ^{
		BOOL combinerleft = tappableEntity > 11;
		UISwitch *grouplevelstyle = [[UISwitch alloc] init];
		[grouplevelstyle setOn:combinerleft animated:NO];
		grouplevelstyle.tag = 8;
		CABasicAnimation *beginnerWrapper = [CABasicAnimation animationWithKeyPath:@"shouldFormatMission"];
		beginnerWrapper.fromValue = [NSValue valueWithCGPoint:CGPointMake(28, 196)];
		beginnerWrapper.duration = 9.0;
		beginnerWrapper.autoreverses = NO;
		beginnerWrapper.toValue = [NSValue valueWithCGPoint:CGPointMake(133, 14)];
		//NSLog(@"sets= bussiness3 gen_int %@", bussiness3);
	});
}


@end
        