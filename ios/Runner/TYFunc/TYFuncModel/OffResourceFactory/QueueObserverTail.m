#import "QueueObserverTail.h"
    
@interface QueueObserverTail ()

@end

@implementation QueueObserverTail

- (void) pushFragmentAndMapper
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSMutableArray *layoutTernary = [NSMutableArray array];
		[layoutTernary addObject:@"combinelog"];
		[layoutTernary addObject:@"resultTheme"];
		[layoutTernary addObject:@"managerOperation"];
		[layoutTernary addObject:@"logarithmShade"];
		[layoutTernary addObject:@"associateRequest"];
		NSInteger elasticRadius = [layoutTernary count];
		int disabledMenu=0;
		for (int i = 0; i < elasticRadius; i++) {
			disabledMenu += [[layoutTernary objectAtIndex:i] intValue];
		}
		float multiMend = (float)disabledMenu / elasticRadius;
		if (elasticRadius > 0) {
			NSLog(@"Average: %f", multiMend);
		} else {
			NSLog(@"Array is empty");
		}
		//NSLog(@"Business17 gen_arr executed%@", Business17);
	});
}


@end
        