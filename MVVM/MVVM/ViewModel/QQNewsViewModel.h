//
//  QQNewsViewModel.h
//  MVVM
//
//  Created by Mac on 29/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QQNews;

@interface QQNewsViewModel : NSObject

/// 新闻数据模型
@property (nonatomic, strong) QQNews *news;
/// 新闻图片URL
@property (nonatomic, strong) NSURL *news_imgsrc;
/// 跟帖数(在此处理)
@property (nonatomic, copy) NSString *news_replyCount;

/**
 * 新闻模型实例化视图模型
 */
+ (instancetype)viewModelWithNews:(QQNews *)news;

@end
