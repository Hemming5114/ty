#import "NavigateTextAdapter.h"
    
@interface NavigateTextAdapter ()

@end

@implementation NavigateTextAdapter

- (void) animateAccessoryBesideFormat
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSMutableSet *loopmaterial = [NSMutableSet set];
		for (int i = 7; i != 0; --i) {
			[loopmaterial addObject:[NSString stringWithFormat:@"mountedAspect%d", i]];
		}
		NSInteger tabbarrotation =  [loopmaterial count];
		UISegmentedControl *unmountProject = [[UISegmentedControl alloc] init];
		__block NSInteger shouldPresentMusic = 0;
		[loopmaterial enumerateObjectsUsingBlock:^(id  _Nonnull yieldDecoration, BOOL * _Nonnull stop) {
		    if (shouldPresentMusic < 5) {
		        [unmountProject insertSegmentWithTitle:[yieldDecoration description] atIndex:shouldPresentMusic animated:NO];
		        shouldPresentMusic++;
		    } else {
		        *stop = YES;
		    }
		}];
		[unmountProject setSelectedSegmentIndex:0];
		[unmountProject setTintColor:[UIColor grayColor]];
		UIAlertController *concurrentEvolution = [UIAlertController alertControllerWithTitle:@"Set Operations" message:[NSString stringWithFormat:@"Set contains %lu items", (unsigned long)tabbarrotation] preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *timelineBrightness = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
		[concurrentEvolution addAction:timelineBrightness];
		if (tabbarrotation > 4) {
			// 当集合元素较多时，添加额外的操作按钮
			UIAlertAction *extraAction = [UIAlertAction actionWithTitle:@"Process Set" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
			    // 处理集合的代码
			    NSLog(@"Processing set with %lu items", (unsigned long)tabbarrotation);
			}];
			[concurrentEvolution addAction:extraAction];
		}
		//NSLog(@"Business18 gen_set with size: %lu%@", (unsigned long)tabbarrotation);
	});
}


@end
        