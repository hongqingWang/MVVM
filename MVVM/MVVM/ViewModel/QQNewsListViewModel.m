//
//  QQNewsListViewModel.m
//  MVVM
//
//  Created by Mac on 29/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQNewsListViewModel.h"
#import "QQNewsViewModel.h"
#import "QQNetworkManager.h"
#import "QQNews.h"
#import <MJExtension.h>

@implementation QQNewsListViewModel

- (void)loadNewsCompleted:(void (^)(BOOL))completed {
    
    NSString *urlString = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-10.html";
    [[QQNetworkManager sharedManager] qq_request:GET urlString:urlString parameters:nil finished:^(id result, NSError *error) {
        
        if (error) {
            
            NSLog(@"QQNewsListViewModel - error = %@", error);
            return;
        }
        NSLog(@"QQNewsListViewModel - result = %@", result[@"T1348647853363"]);
        
        NSArray *resultArray = result[@"T1348647853363"];
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:resultArray.count];
        
        for (NSDictionary *dict in resultArray) {
            
            QQNews *news = [QQNews mj_objectWithKeyValues:dict];
            [arrayM addObject:[QQNewsViewModel viewModelWithNews:news]];
        }
        
        // 新闻视图模型数组
        [self.newsList addObjectsFromArray:arrayM];
        
        // 完成回调
        completed(YES);
    }];
}

#pragma mark - Getters And Setters
- (NSMutableArray *)newsList {
    if (_newsList == nil) {
        _newsList = [[NSMutableArray alloc] init];
    }
    return _newsList;
}

@end
