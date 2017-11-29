//
//  QQNewsListViewModel.h
//  MVVM
//
//  Created by Mac on 29/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QQNewsViewModel;

@interface QQNewsListViewModel : NSObject

/// 新闻`视图模型`数组
@property (nonatomic, strong) NSMutableArray *newsList;

/**
 加载数据

 @param completed 完成回调
 */
- (void)loadNewsCompleted:(void (^)(BOOL isSuccessed))completed;

@end
