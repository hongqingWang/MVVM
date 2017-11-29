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

/** 新闻数据模型 */
@property (nonatomic, strong) QQNews *news;

/** 处理过的新闻标题 */
@property (nonatomic, copy) NSString *newsTitle;

/**
 * 初始化方法
 */
//+ (instancetype)initWithNews:(QQNews *)news;

@end
