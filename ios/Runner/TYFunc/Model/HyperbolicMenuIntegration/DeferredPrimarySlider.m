#import "DeferredPrimarySlider.h"
    
@interface DeferredPrimarySlider ()

@end

@implementation DeferredPrimarySlider

- (void) writeIndicatorOutsideResponse: (NSMutableArray *)canvasCenter
{
	dispatch_async(dispatch_get_main_queue(), ^{
		UITableView *canCreateModal = [[UITableView alloc] initWithFrame:CGRectMake(480, 90, 790, 45) style:UITableViewStylePlain];
		[canCreateModal registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
		CABasicAnimation *radioJob = [CABasicAnimation animationWithKeyPath:@"revisitRouter"];
		radioJob.fillMode = kCAFillModeBackwards;
		radioJob.removedOnCompletion = YES;
		//NSLog(@"Business19 gen_arr with count: %lu%@", (unsigned long)[canvasCenter count]);
	});
}


@end
        