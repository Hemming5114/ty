#import "ServiceBuilderFilter.h"
    
@interface ServiceBuilderFilter ()

@end

@implementation ServiceBuilderFilter

- (void) paintPlayDownPrecision: (NSMutableArray *)specifiervalueinterval
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSInteger synchronousDropdownButton = [specifiervalueinterval count];
		int materialfacadeduration=0;
		for (int i = 0; i < synchronousDropdownButton; i++) {
			materialfacadeduration += [[specifiervalueinterval objectAtIndex:i] intValue];
		}
		float activatedScroll = (float)materialfacadeduration / synchronousDropdownButton;
		if (synchronousDropdownButton > 0) {
			NSLog(@"Average: %f", activatedScroll);
		} else {
			NSLog(@"Array is empty");
		}
		//NSLog(@"Business17 gen_arr executed%@", Business17);
	});
}


@end
        