#import "RouterDistinctionDecorator.h"
    
@interface RouterDistinctionDecorator ()

@end

@implementation RouterDistinctionDecorator

- (void) convertOutFactoryActivity: (NSMutableSet *)otheritem
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSInteger notificationTail =  [otheritem count];
		UISlider *replicatop = [[UISlider alloc] init];
		replicatop.value = notificationTail;
		replicatop.maximumValue = 54;
		replicatop.minimumValue = 54;
		replicatop.enabled = YES;
		//NSLog(@"sets= bussiness4 gen_set %@", bussiness4);
	});
}


@end
        