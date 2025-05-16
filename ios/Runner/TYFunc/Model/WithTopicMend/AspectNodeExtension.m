#import "AspectNodeExtension.h"
    
@interface AspectNodeExtension ()

@end

@implementation AspectNodeExtension

- (void) measureMovement: (int)firstObject
{
	dispatch_async(dispatch_get_main_queue(), ^{
		BOOL movementinteractor = firstObject > 85;
		UIProgressView *robustPositioned = [[UIProgressView alloc] init];
		robustPositioned.progress = (float)firstObject/100.0;
		//NSLog(@"Business19 gen_int with value: %d%@", firstObject);
	});
}


@end
        