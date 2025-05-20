#import "UnmountedBulletDecorator.h"
    
@interface UnmountedBulletDecorator ()

@end

@implementation UnmountedBulletDecorator

- (void) holdProfileThanManager
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSMutableArray *stoppoint = [NSMutableArray array];
		for (int i = 4; i != 0; --i) {
			[stoppoint addObject:[NSString stringWithFormat:@"connectChapter%d", i]];
		}
		UITableView *shouldStreamCupertino = [[UITableView alloc] initWithFrame:CGRectMake(76, 183, 440, 155) style:UITableViewStylePlain];
		[shouldStreamCupertino registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
		CABasicAnimation *notifytext = [CABasicAnimation animationWithKeyPath:@"greatProjection"];
		notifytext.fillMode = kCAFillModeBackwards;
		notifytext.repeatCount = 29;
		notifytext.toValue = [NSValue valueWithCGPoint:CGPointMake(264, 192)];
		notifytext.cumulative = NO;
		notifytext.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
		notifytext.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
		//NSLog(@"Business19 gen_arr with count: %lu%@", (unsigned long)[stoppoint count]);
	});
}


@end
        