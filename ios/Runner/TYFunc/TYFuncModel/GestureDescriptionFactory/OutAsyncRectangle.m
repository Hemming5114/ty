#import "OutAsyncRectangle.h"
    
@interface OutAsyncRectangle ()

@end

@implementation OutAsyncRectangle

- (void) transformWithoutCallbackPhase: (int)progressbarSpacing
{
	dispatch_async(dispatch_get_main_queue(), ^{
		float undertakePosition=0.781290;
		float lostSearcher=0.732902;
		float consultativeDuration=0.662678;
		float constructException=0.578594;
		float reduceResult=0.639347;
		undertakePosition = 988 * 0.160473;
		lostSearcher = undertakePosition + 726 * 0.233769;
		consultativeDuration = lostSearcher + 866 * 0.822300;
		constructException = consultativeDuration + 146 * 0.294301;
		if (progressbarSpacing < 120) {
			reduceResult = progressbarSpacing * 0.023421;
		}
		if (progressbarSpacing <= 192) {
			reduceResult = undertakePosition + progressbarSpacing * 0.360801;
		}
		if (progressbarSpacing <= 74) {
			reduceResult = lostSearcher + progressbarSpacing * 0.775359;
		}
		if (progressbarSpacing <= 109) {
			reduceResult = consultativeDuration + progressbarSpacing * 0.737806;
		}
		if (progressbarSpacing <= 877) {
			reduceResult = constructException + progressbarSpacing * 0.489304;
		}
		//NSLog(@"sets= bussiness6 gen_int %@", bussiness6);
	});
}


@end
        