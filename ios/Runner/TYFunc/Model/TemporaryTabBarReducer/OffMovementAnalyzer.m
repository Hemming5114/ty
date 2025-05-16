#import "OffMovementAnalyzer.h"
    
@interface OffMovementAnalyzer ()

@end

@implementation OffMovementAnalyzer

- (void) dispatchRequiredGesture: (NSString *)remediationTag
{
	dispatch_async(dispatch_get_main_queue(), ^{
		UISegmentedControl *reusableviewleft = [[UISegmentedControl alloc] init];
		[reusableviewleft insertSegmentWithTitle:remediationTag atIndex:0 animated:YES];
		BOOL routeContext = reusableviewleft.isEnabled;
		CATransition *shouldValidateConsumer = [CATransition animation];
		shouldValidateConsumer.type = kCATransitionPush;
		shouldValidateConsumer.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
		if (routeContext) {
			UISegmentedControl *reusableviewleft = [[UISegmentedControl alloc] init];
			[reusableviewleft insertSegmentWithTitle:remediationTag atIndex:0 animated:YES];
			BOOL routeContext = reusableviewleft.isEnabled;
			CATransition *shouldValidateConsumer = [CATransition animation];
			shouldValidateConsumer.type = kCATransitionPush;
			shouldValidateConsumer.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
		}
		//NSLog(@"sets= bussiness5 gen_str %@", bussiness5);
	});
}


@end
        