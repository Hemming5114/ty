#import "TickerInstance.h"
    
@interface TickerInstance ()

@end

@implementation TickerInstance

- (void) analyzeResponder
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSMutableArray *intermediateLayout = [NSMutableArray array];
		for (int i = 0; i < 8; ++i) {
			[intermediateLayout addObject:[NSString stringWithFormat:@"cartesianReference%d", i]];
		}
		UIActivityIndicatorView *fixedCluster = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
		[fixedCluster startAnimating];
		//NSLog(@"sets= bussiness5 gen_arr %@", bussiness5);
	});
}


@end
        