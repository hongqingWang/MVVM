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

/** 单条新闻`视图模型`数组 */
@property (nonatomic, strong) NSArray<QQNewsViewModel *> *newsViewModelList;

- (void)loadNewsData;

@end
