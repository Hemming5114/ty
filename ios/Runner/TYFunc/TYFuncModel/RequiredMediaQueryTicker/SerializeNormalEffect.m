#import "SerializeNormalEffect.h"
    
@interface SerializeNormalEffect ()

@end

@implementation SerializeNormalEffect

- (void) finishResponsiveCallback: (NSString *)responsiveEquivalent
{
	dispatch_async(dispatch_get_main_queue(), ^{
		UISegmentedControl *parsezone = [[UISegmentedControl alloc] init];
		[parsezone insertSegmentWithTitle:responsiveEquivalent atIndex:0 animated:YES];
		parsezone.selected = YES;
		parsezone.enabled = NO;
		//NSLog(@"sets= bussiness5 gen_str %@", bussiness5);
	});
}


@end
        