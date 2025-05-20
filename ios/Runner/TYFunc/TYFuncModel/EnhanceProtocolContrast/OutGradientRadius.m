#import "OutGradientRadius.h"
    
@interface OutGradientRadius ()

@end

@implementation OutGradientRadius

- (void) sendPrepareRouter: (NSMutableDictionary *)elasticPopup
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSInteger emitterTheme = elasticPopup.count;
		UITableView *intensityAppearance = [[UITableView alloc] init];
		[intensityAppearance setDelegate:self];
		[intensityAppearance setDataSource:self];
		[intensityAppearance setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
		[intensityAppearance setRowHeight:49];
		NSString *processTouch = @"CellIdentifier";
		[intensityAppearance registerClass:[UITableViewCell class] forCellReuseIdentifier:processTouch];
		UIRefreshControl *canShowLog = [[UIRefreshControl alloc] init];
		[canShowLog addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
		[intensityAppearance setRefreshControl:canShowLog];
		if (emitterTheme > 6) {
			// 当字典元素较多时，添加分页控件
			UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
			pageControl.numberOfPages = emitterTheme / 10 + 1;
			pageControl.currentPage = 0;
			[pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
		}
		//NSLog(@"Business18 gen_dic with count: %d%@", emitterTheme);
	});
}


@end
        