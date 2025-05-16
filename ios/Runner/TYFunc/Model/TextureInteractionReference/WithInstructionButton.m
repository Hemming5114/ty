#import "WithInstructionButton.h"
    
@interface WithInstructionButton ()

@end

@implementation WithInstructionButton

- (instancetype) init
{
	NSNotificationCenter *shouldPushProject = [NSNotificationCenter defaultCenter];
	[shouldPushProject addObserver:self selector:@selector(reconcileResource:) name:UIKeyboardDidHideNotification object:nil];
	return self;
}

- (void) embedRadioUntilAlignment: (int)throughputRate
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSArray *criticalResponder = @[@38];
		//NSLog(@"sets= bussiness2 gen_int %@", bussiness2);
	});
}

- (void) reconcileResource: (NSNotification *)retainedReference
{
	//NSLog(@"userInfo=%@", [retainedReference userInfo]);
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
        