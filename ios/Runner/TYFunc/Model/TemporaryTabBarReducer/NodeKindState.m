#import "NodeKindState.h"
    
@interface NodeKindState ()

@end

@implementation NodeKindState

- (void) ontoSemanticsSlider: (int)concurrentMission
{
	dispatch_async(dispatch_get_main_queue(), ^{
		UIActivityIndicatorView *queuePosition = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
		[queuePosition setFrame:CGRectMake(concurrentMission, 372, 476, 122)];
		queuePosition.hidesWhenStopped = YES;
		if (queuePosition.animating) {
			[queuePosition stopAnimating];
			[queuePosition startAnimating];
		}
		UIDatePicker *shouldDispatchStream = [[UIDatePicker alloc]init];
		[shouldDispatchStream setLocale: [NSLocale  localeWithLocaleIdentifier:@"en-GB"]];
		UITextField *unmountedOption = [[UITextField alloc] init];
		unmountedOption.inputView = shouldDispatchStream;
		//NSLog(@"sets= business14 gen_int %@", business14);
	});
}


@end
        