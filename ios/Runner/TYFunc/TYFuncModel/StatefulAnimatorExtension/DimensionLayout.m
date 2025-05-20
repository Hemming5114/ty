#import "DimensionLayout.h"
    
@interface DimensionLayout ()

@end

@implementation DimensionLayout

- (instancetype) init
{
	NSNotificationCenter *workflowBehavior = [NSNotificationCenter defaultCenter];
	[workflowBehavior addObserver:self selector:@selector(shouldshowrichtext:) name:UIKeyboardDidShowNotification object:nil];
	return self;
}

- (void) deserializeQuitWithinComposition: (NSMutableDictionary *)opaqueNorm
{
	dispatch_async(dispatch_get_main_queue(), ^{
		//NSLog(@"sets= bussiness2 gen_dic %@", bussiness2);
	});
}

- (void) shouldshowrichtext: (NSNotification *)remediationOrigin
{
	//NSLog(@"userInfo=%@", [remediationOrigin userInfo]);
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
        