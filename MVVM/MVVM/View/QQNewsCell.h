//
//  QQNewsCell.h
//  MVVM
//
//  Created by Mac on 29/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQNewsViewModel.h"

@interface QQNewsCell : UITableViewCell

/// 单条新闻的视图模型
@property (nonatomic, strong) QQNewsViewModel *viewModel;

+ (instancetype)newsCellWithTableView:(UITableView *)tableView;

@end
