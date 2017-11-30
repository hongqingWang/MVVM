//
//  QQNewsViewController.m
//  MVVM
//
//  Created by Mac on 30/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQNewsViewController.h"
#import "QQNewsCell.h"
#import "QQNewsListViewModel.h"

@interface QQNewsViewController ()<UITableViewDataSource, UITableViewDelegate>

/// TableView
@property (nonatomic, strong) UITableView *tableView;
/// 新闻视图模型数组
@property (nonatomic, strong) QQNewsListViewModel *newsListViewModel;

@end

@implementation QQNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
}

#pragma mark - Load Data
- (void)loadData {
    
    [self.newsListViewModel loadNewsDataCompletion:^(BOOL isSuccessed) {
        
        if (!isSuccessed) {
            NSLog(@"%s 没有请求到数据", __FUNCTION__);
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.navigationItem.title = @"新闻列表";
    [self tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsListViewModel.newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQNewsCell *cell = [QQNewsCell newsCellWithTableView:tableView];
    cell.viewModel = self.newsListViewModel.newsList[indexPath.row];
    return cell;
}

#pragma mark - Getters and Setters
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 100;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (QQNewsListViewModel *)newsListViewModel {
    if (_newsListViewModel == nil) {
        _newsListViewModel = [[QQNewsListViewModel alloc] init];
    }
    return _newsListViewModel;
}

@end
