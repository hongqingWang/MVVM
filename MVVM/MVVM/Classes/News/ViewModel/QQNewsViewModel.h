//
//  QQNewsViewModel.h
//  MVVM
//
//  Created by Mac on 30/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QQNews;

@interface QQNewsViewModel : NSObject

/// 新闻数据模型
@property (nonatomic, strong) QQNews *news;
/// 新闻图片URL
@property (nonatomic, strong) NSURL *imgsrc_url;
/// 跟帖数(在此处理)
@property (nonatomic, copy) NSString *replyCount_string;

+ (instancetype)viewModelWithNews:(QQNews *)news;

@end
