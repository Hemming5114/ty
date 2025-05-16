#import "RelationalRendererAdapter.h"
    
@interface RelationalRendererAdapter ()

@end

@implementation RelationalRendererAdapter

- (void) searchFrame: (NSString *)eagerScreen
{
	dispatch_async(dispatch_get_main_queue(), ^{
		CALayer * clipperOperation = [[CALayer alloc] init];
		clipperOperation.name = eagerScreen;
		clipperOperation.borderWidth = 837;
		clipperOperation.position = CGPointZero;
		//NSLog(@"sets= bussiness8 gen_str %@", bussiness8);
	});
}


@end
        