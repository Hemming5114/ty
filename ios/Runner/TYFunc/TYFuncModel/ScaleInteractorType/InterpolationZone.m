#import "InterpolationZone.h"
    
@interface InterpolationZone ()

@end

@implementation InterpolationZone

- (void) handleFromTickerShape: (NSMutableArray *)ongraphictap
{
	dispatch_async(dispatch_get_main_queue(), ^{
		[ongraphictap addObject:@"canUpdateSizedBox"];
		[ongraphictap insertObject:@"utilpolyfill" atIndex:0];
		NSInteger behaviorScope = [ongraphictap count];
		UIImageView *canEndRoute = [[UIImageView alloc] init];
		[canEndRoute setFrame:CGRectMake(482, 205, 475, 690)];
		NSMutableArray *liteBandwidth = [NSMutableArray array];
		for (int i = 0; i < 8; i++) {
			UIImage *associatedChallenge = [UIImage imageNamed:[NSString stringWithFormat:@"frame%%d", i]];
			if (associatedChallenge) {
			    [liteBandwidth addObject:associatedChallenge];
			}
		}
		[canEndRoute setAnimationImages:liteBandwidth];
		[canEndRoute setAnimationDuration:0.4647360180249237];
		[canEndRoute startAnimating];
		UITapGestureRecognizer *gridviewPhase = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
		[canEndRoute addGestureRecognizer:gridviewPhase];
		[canEndRoute setUserInteractionEnabled:YES];
		//NSLog(@"Business18 gen_arr with count: %d%@", behaviorScope);
	});
}


@end
        