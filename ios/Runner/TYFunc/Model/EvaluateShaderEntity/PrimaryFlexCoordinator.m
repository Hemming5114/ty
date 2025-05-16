#import "PrimaryFlexCoordinator.h"
    
@interface PrimaryFlexCoordinator ()

@end

@implementation PrimaryFlexCoordinator

- (void) showInactiveStorageLayer
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSMutableDictionary *sortedDocument = [NSMutableDictionary dictionary];
		sortedDocument[@"prevcontroller"] = @"bundleZone";
		sortedDocument[@"notificationWork"] = @"customizedConsumer";
		NSInteger keepCapsule = sortedDocument.count;
		UITableView *cacheAxis = [[UITableView alloc] init];
		[cacheAxis setDelegate:self];
		[cacheAxis setDataSource:self];
		[cacheAxis setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
		[cacheAxis setRowHeight:48];
		NSString *permissiveGesture = @"CellIdentifier";
		[cacheAxis registerClass:[UITableViewCell class] forCellReuseIdentifier:permissiveGesture];
		UIRefreshControl *channelEnvironment = [[UIRefreshControl alloc] init];
		[channelEnvironment addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
		[cacheAxis setRefreshControl:channelEnvironment];
		if (keepCapsule > 3) {
			// 当字典元素较多时，添加分页控件
			UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
			pageControl.numberOfPages = keepCapsule / 10 + 1;
			pageControl.currentPage = 0;
			[pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
		}
		//NSLog(@"Business18 gen_dic with count: %d%@", keepCapsule);
	});
}


@end
        