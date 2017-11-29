//
//  QQNewsViewModel.m
//  MVVM
//
//  Created by Mac on 29/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQNewsViewModel.h"
#import "QQNews.h"

@implementation QQNewsViewModel

+ (instancetype)viewModelWithNews:(QQNews *)news {
    
    QQNewsViewModel *viewModel = [[self alloc] init];
    
    viewModel.news = news;
    
    return viewModel;
}

- (NSURL *)news_imgsrc {
    return [NSURL URLWithString:self.news.imgsrc];
}

- (NSString *)news_replyCount {
    
    // 测试跟帖数超过1万显示是否正确
    self.news.replyCount = 23456;
    
    if (self.news.replyCount >= 10000) {
        
        NSString *string = [NSString stringWithFormat:@"%ld万 跟帖", self.news.replyCount / 10000];
        return string;
    }
    return [NSString stringWithFormat:@"%ld 跟帖", self.news.replyCount];
}

@end
