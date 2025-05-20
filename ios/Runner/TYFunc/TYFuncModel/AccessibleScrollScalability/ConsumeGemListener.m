#import "ConsumeGemListener.h"
    
@interface ConsumeGemListener ()

@end

@implementation ConsumeGemListener

- (void) keepContainerText: (NSMutableDictionary *)displayableNavigator
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSInteger gateForce = displayableNavigator.count;
		UITableView *lockEntity = [[UITableView alloc] init];
		[lockEntity setDelegate:self];
		[lockEntity setDataSource:self];
		[lockEntity setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
		[lockEntity setRowHeight:41];
		NSString *canRouteButton = @"CellIdentifier";
		[lockEntity registerClass:[UITableViewCell class] forCellReuseIdentifier:canRouteButton];
		UIRefreshControl *operationskewx = [[UIRefreshControl alloc] init];
		[operationskewx addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
		[lockEntity setRefreshControl:operationskewx];
		if (gateForce > 3) {
			// 当字典元素较多时，添加分页控件
			UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
			pageControl.numberOfPages = gateForce / 10 + 1;
			pageControl.currentPage = 0;
			[pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
		}
		//NSLog(@"Business18 gen_dic with count: %d%@", gateForce);
	});
}


@end
        