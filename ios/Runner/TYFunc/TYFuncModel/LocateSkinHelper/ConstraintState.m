#import "ConstraintState.h"
    
@interface ConstraintState ()

@end

@implementation ConstraintState

- (void) validateMultiOffset: (NSMutableArray *)characteristicDistance
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSInteger shouldParseArithmetic = [characteristicDistance count];
		int encodeappbar=0;
		for (int i = 0; i < shouldParseArithmetic; i++) {
			encodeappbar += [[characteristicDistance objectAtIndex:i] intValue];
		}
		float singletonanimation = (float)encodeappbar / shouldParseArithmetic;
		if (shouldParseArithmetic > 0) {
			NSLog(@"Average: %f", singletonanimation);
		} else {
			NSLog(@"Array is empty");
		}
		//NSLog(@"Business17 gen_arr executed%@", Business17);
	});
}


@end
        