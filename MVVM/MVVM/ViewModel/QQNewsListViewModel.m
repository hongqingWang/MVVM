//
//  QQNewsListViewModel.m
//  MVVM
//
//  Created by Mac on 29/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQNewsListViewModel.h"
#import "QQNetworkManager.h"
#import "QQNews.h"
#import <MJExtension.h>

@implementation QQNewsListViewModel

- (void)loadNewsData {
    
    NSString *urlString = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-10.html";
    [[QQNetworkManager sharedManager] qq_request:GET urlString:urlString parameters:nil finished:^(id result, NSError *error) {
        
        if (error) {
            
            NSLog(@"QQNewsListViewModel - error = %@", error);
            return;
        }
        NSLog(@"QQNewsListViewModel - result = %@", result[@"T1348647853363"]);
        
        // 新闻模型数组
        NSArray *newsModelArray = [QQNews mj_objectArrayWithKeyValuesArray:result[@"T1348647853363"]];
        
        // 新闻视图模型数组
        NSLog(@"%@", newsModelArray);
        self.newsViewModelList = newsModelArray;
        
    }];
}

@end
