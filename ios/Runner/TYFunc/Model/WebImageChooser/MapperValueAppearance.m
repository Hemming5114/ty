#import "MapperValueAppearance.h"
    
@interface MapperValueAppearance ()

@end

@implementation MapperValueAppearance

- (void) prepareRoleWidget
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSString *shouldMountedStateless = @"sharedRadius";
		NSMutableDictionary *heapHead = [NSMutableDictionary dictionary];
		heapHead[@"None"] = [UIFont fontWithName:@"HiraKakuProN-W6" size:11];;
		heapHead[@"None"] = [UIFont fontWithName:@"STHeitiSC-Light" size:54];;
		[shouldMountedStateless drawAtPoint:CGPointMake(377, 86) withAttributes:heapHead];
		UILabel *attachoption = [[UILabel alloc] init];
		attachoption.center = CGPointMake(11, 153);
		attachoption.layer.cornerRadius = 9.0f;
		attachoption.font = [UIFont systemFontOfSize:390];
		attachoption.center = CGPointMake(377, 420);
		attachoption.bounds = CGRectMake(287, 396, 630, 714);
		//NSLog(@"sets= business12 gen_str %@", business12);
	});
}


@end
        