#import "CubitState.h"
    
@interface CubitState ()

@end

@implementation CubitState

- (void) skipSkin: (int)mainComponent
{
	dispatch_async(dispatch_get_main_queue(), ^{
		BOOL inactivepaddingtop = mainComponent > 30;
		UISwitch *mediaqueryRight = [[UISwitch alloc] init];
		[mediaqueryRight setOn:inactivepaddingtop animated:NO];
		mediaqueryRight.tag = 60;
		CAShapeLayer *animatorRotation = [[CAShapeLayer alloc] init];
		animatorRotation.lineCap = kCALineCapRound;
		animatorRotation.shadowRadius = 75;
		animatorRotation.affineTransform = CGAffineTransformMake(7, 43, 14, 7, 43, 14);
		animatorRotation.opacity = 0;
		animatorRotation.shadowOpacity = 0;
		[animatorRotation setShadowColor:[UIColor colorWithRed:37/255.0 green:208/255.0 blue:36/255.0 alpha:0.866667].CGColor];
		animatorRotation.shadowOffset = CGSizeMake(38, 0);
		//NSLog(@"sets= bussiness3 gen_int %@", bussiness3);
	});
}


@end
        