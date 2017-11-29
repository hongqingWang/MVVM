//
//  QQNewsViewController.m
//  MVVM
//
//  Created by Mac on 29/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQNewsViewController.h"
#import "QQNewsCell.h"

@interface QQNewsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation QQNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - SetupUI
- (void)setupUI {
    
    [self tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQNewsCell *cell = [QQNewsCell newsCellWithTableView:tableView];
//    cell.model = self.dataArr[indexPath.row];
    return cell;
}

#pragma mark - Getters and Setters
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 80;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
