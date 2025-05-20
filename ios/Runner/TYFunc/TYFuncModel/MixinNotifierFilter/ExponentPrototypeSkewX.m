#import "ExponentPrototypeSkewX.h"
    
@interface ExponentPrototypeSkewX ()

@end

@implementation ExponentPrototypeSkewX

- (void) processReferenceByTask: (NSMutableDictionary *)movementleft
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSInteger saveRole = movementleft.count;
		UITableView *labelAlignment = [[UITableView alloc] init];
		[labelAlignment setDelegate:self];
		[labelAlignment setDataSource:self];
		[labelAlignment setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
		[labelAlignment setRowHeight:46];
		NSString *shouldPublishMusic = @"CellIdentifier";
		[labelAlignment registerClass:[UITableViewCell class] forCellReuseIdentifier:shouldPublishMusic];
		UIRefreshControl *fetchGesture = [[UIRefreshControl alloc] init];
		[fetchGesture addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
		[labelAlignment setRefreshControl:fetchGesture];
		if (saveRole > 2) {
			// 当字典元素较多时，添加分页控件
			UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
			pageControl.numberOfPages = saveRole / 10 + 1;
			pageControl.currentPage = 0;
			[pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
		}
		//NSLog(@"Business18 gen_dic with count: %d%@", saveRole);
	});
}


@end
        