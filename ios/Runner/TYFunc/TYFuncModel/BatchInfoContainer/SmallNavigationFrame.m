#import "SmallNavigationFrame.h"
    
@interface SmallNavigationFrame ()

@end

@implementation SmallNavigationFrame

- (void) resizeAnchor: (NSMutableDictionary *)positionfeedback
{
	dispatch_async(dispatch_get_main_queue(), ^{
		CAShapeLayer *immediateResource = [[CAShapeLayer alloc] init];
		immediateResource.lineCap = kCALineCapSquare;
		immediateResource.strokeColor = [UIColor colorWithRed:230/255.0 green:164/255.0 blue:222/255.0 alpha:0.713725].CGColor;
		immediateResource.shadowOffset = CGSizeMake(3, 24);
		immediateResource.frame = CGRectMake(41, 8, 90, 39);
		immediateResource.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 15, 28, 8)].CGPath;;
		immediateResource.shadowOffset = CGSizeMake(48, 19);
		immediateResource.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(12, 20, 97, 54)].CGPath;;
		immediateResource.lineCap = kCALineCapSquare;
		immediateResource.fillColor = [UIColor colorWithRed:133/255.0 green:244/255.0 blue:106/255.0 alpha:0.298039].CGColor;
		//NSLog(@"sets= bussiness2 gen_dic %@", bussiness2);
	});
}


@end
        