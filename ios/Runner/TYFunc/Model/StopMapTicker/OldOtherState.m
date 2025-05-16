#import "OldOtherState.h"
    
@interface OldOtherState ()

@end

@implementation OldOtherState

- (void) observeTransition
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSString *currentDescription = @"flexibleInstruction";
		UISegmentedControl *gramvialevel = [[UISegmentedControl alloc] init];
		[gramvialevel insertSegmentWithTitle:currentDescription atIndex:0 animated:YES];
		gramvialevel.enabled = NO;
		gramvialevel.selected = YES;
		//NSLog(@"sets= bussiness5 gen_str %@", bussiness5);
	});
}


@end
        