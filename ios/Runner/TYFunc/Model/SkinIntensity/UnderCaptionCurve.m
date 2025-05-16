#import "UnderCaptionCurve.h"
    
@interface UnderCaptionCurve ()

@end

@implementation UnderCaptionCurve

+ (instancetype) underCaptionCurveWithDictionary: (NSDictionary *)dict
{
	return [[self alloc] initWithDictionary:dict];
}

- (instancetype) initWithDictionary: (NSDictionary *)dict
{
	if (self = [super init]) {
		[self setValuesForKeysWithDictionary:dict];
	}
	return self;
}

- (NSString *) shouldPushNavigator
{
	return @"explicitSegue";
}

- (NSMutableDictionary *) loopIndex
{
	NSMutableDictionary *scheduleNode = [NSMutableDictionary dictionary];
	scheduleNode[@"visibleGraph"] = @"otherSchema";
	scheduleNode[@"wraptheme"] = @"chooserForce";
	return scheduleNode;
}

- (int) substantialMovement
{
	return 5;
}

- (NSMutableSet *) streamcontextcoord
{
	NSMutableSet *shouldShowSubpixel = [NSMutableSet set];
	[shouldShowSubpixel addObject:@"canUnmountedSubpixel"];
	[shouldShowSubpixel addObject:@"formatBottom"];
	return shouldShowSubpixel;
}

- (NSMutableArray *) interfacemargin
{
	NSMutableArray *exponentDepth = [NSMutableArray array];
	for (int i = 0; i < 9; ++i) {
		[exponentDepth addObject:[NSString stringWithFormat:@"explicitMenu%d", i]];
	}
	return exponentDepth;
}


@end
        