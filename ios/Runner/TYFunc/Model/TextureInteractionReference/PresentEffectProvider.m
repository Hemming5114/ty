#import "PresentEffectProvider.h"
    
@interface PresentEffectProvider ()

@end

@implementation PresentEffectProvider

- (void) playOpaqueFlex: (int)factoryOrigin
{
	dispatch_async(dispatch_get_main_queue(), ^{
		int otherprecision = 301;
		for (int i = 0; i < factoryOrigin; i++) {
			otherprecision += i;
		}
		if (otherprecision > 284) {
			otherprecision ++;
		}
		UIStackView *shouldBindImage = [[UIStackView alloc] init];
		shouldBindImage.spacing = 59;
		shouldBindImage.backgroundColor = [UIColor colorWithRed:37/255.0 green:125/255.0 blue:198/255.0 alpha:0.035294];
		shouldBindImage.distribution = UIStackViewDistributionEqualCentering;
		shouldBindImage.frame = CGRectMake(55, 73, 63, 35);
		//NSLog(@"sets= business12 gen_int %@", business12);
	});
}


@end
        