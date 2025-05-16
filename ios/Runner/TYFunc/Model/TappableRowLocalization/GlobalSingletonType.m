#import "GlobalSingletonType.h"
    
@interface GlobalSingletonType ()

@end

@implementation GlobalSingletonType

- (void) unlockPaddingRect
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSMutableDictionary *greatPositioned = [NSMutableDictionary dictionary];
		for (int i = 0; i < 3; ++i) {
			greatPositioned[[NSString stringWithFormat:@"componentValidation%d", i]] = @"shouldFormatPoint";
		}
		//NSLog(@"sets= bussiness2 gen_dic %@", bussiness2);
	});
}


@end
        