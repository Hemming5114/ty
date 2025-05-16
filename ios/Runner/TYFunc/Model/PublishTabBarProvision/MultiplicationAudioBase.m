#import "MultiplicationAudioBase.h"
    
@interface MultiplicationAudioBase ()

@end

@implementation MultiplicationAudioBase

- (void) transitionVector: (int)clusterVisible
{
	dispatch_async(dispatch_get_main_queue(), ^{
		UIActivityIndicatorView *shouldRenderSample = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(33, 46, 57, 52)];
		shouldRenderSample.hidesWhenStopped = NO;
		[shouldRenderSample setFrame:CGRectMake(52, 42, 64, 54)];
		[shouldRenderSample stopAnimating];
		[shouldRenderSample setFrame:CGRectMake(clusterVisible, 291, 718, 86)];
		shouldRenderSample.hidesWhenStopped = YES;
		if (shouldRenderSample.animating) {
			[shouldRenderSample stopAnimating];
			[shouldRenderSample stopAnimating];
			shouldRenderSample.color = UIColor.darkGrayColor;
		}
		UITextView *equalizationMethod = [[UITextView alloc] initWithFrame:CGRectMake(23, 95, 124, 237)];
		equalizationMethod.textAlignment = NSTextAlignmentJustified;
		equalizationMethod.contentOffset = CGPointMake(82, 16);
		equalizationMethod.textColor = [UIColor colorWithRed:241/255.0 green:153/255.0 blue:232/255.0 alpha:0.043137];
		equalizationMethod.contentOffset = CGPointMake(78, 82);
		equalizationMethod.contentInset = UIEdgeInsetsMake(78, 89, 78, 89);
		equalizationMethod.contentInset = UIEdgeInsetsMake(8, 5, 8, 5);
		equalizationMethod.backgroundColor = [UIColor colorWithRed:109/255.0 green:153/255.0 blue:9/255.0 alpha:0.733333];
		//NSLog(@"sets= business14 gen_int %@", business14);
	});
}


@end
        