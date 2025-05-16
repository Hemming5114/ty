#import "DebugMaterialHelper.h"
    
@interface DebugMaterialHelper ()

@end

@implementation DebugMaterialHelper

- (void) checkRouter: (NSString *)priorTopic
{
	dispatch_async(dispatch_get_main_queue(), ^{
		CALayer * vertexcoord = [[CALayer alloc] init];
		vertexcoord.name = priorTopic;
		vertexcoord.bounds = CGRectMake(323, 242, 5, 976);
		vertexcoord.backgroundColor = [UIColor grayColor].CGColor;
		vertexcoord.position = CGPointZero;
		vertexcoord.borderColor = [UIColor grayColor].CGColor;
		vertexcoord.borderWidth = 5;
		vertexcoord.masksToBounds = NO;
		UIButton *rapidLogarithm = [[UIButton alloc] init];
		CGRect shouldCreateSegue = rapidLogarithm.frame;
		rapidLogarithm.layer.shadowOpacity = 0.510000;
		rapidLogarithm.backgroundColor = UIColor.cyanColor;
		shouldCreateSegue.size.height += 520;
		rapidLogarithm.frame=shouldCreateSegue;
		rapidLogarithm.layer.shadowRadius = 10.000000;
		[rapidLogarithm setTitleColor:[UIColor colorWithRed:62/255.0 green:24/255.0 blue:96/255.0 alpha:0.8] forState:UIControlStateNormal];
		[rapidLogarithm  setImageEdgeInsets:UIEdgeInsetsMake(42.400000f, 59.600000f, 100.400000f, 155.200000f)];
		[rapidLogarithm setTitleColor:[UIColor colorWithRed:203/255.0 green:195/255.0 blue:204/255.0 alpha:0.7] forState:UIControlStateNormal];
		[rapidLogarithm setTitleShadowColor:[UIColor colorWithRed:185/255.0 green:180/255.0 blue:80/255.0 alpha:0.541176] forState:UIControlStateNormal];
		rapidLogarithm.bounds = CGRectMake(53.000000, 32.000000, 53.000000, 32.000000);
		shouldCreateSegue.size.width += 67;
		rapidLogarithm.center = CGPointMake(46.000000, 57.000000);
		rapidLogarithm.backgroundColor = UIColor.whiteColor;
		shouldCreateSegue.size.height += 696;
		rapidLogarithm.adjustsImageWhenDisabled = YES;
		//NSLog(@"sets= business16 gen_str %@", business16);
	});
}


@end
        