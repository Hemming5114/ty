#import "QuitTabBarStroke.h"
    
@interface QuitTabBarStroke ()

@end

@implementation QuitTabBarStroke

- (void) sortReferenceTime: (NSString *)promiseName
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSMutableDictionary *tensorNotation = [NSMutableDictionary dictionary];
		tensorNotation[@"None"] = [UIFont fontWithName:@"Trebuchet-BoldItalic" size:62];;
		tensorNotation[@"None"] = [UIColor colorNamed:@"purpleColor"];;
		[promiseName drawInRect:CGRectMake(380, 480, 576, 848) withAttributes:nil];
		NSShadow *oldPager = [[NSShadow alloc] init];
		oldPager.shadowColor = [UIColor colorWithRed:177/255.0 green:126/255.0 blue:209/255.0 alpha:0.145098];
		//NSLog(@"sets= bussiness1 gen_str %@", bussiness1);
	});
}


@end
        