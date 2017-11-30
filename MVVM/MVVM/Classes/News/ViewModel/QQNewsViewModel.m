//
//  QQNewsViewModel.m
//  MVVM
//
//  Created by Mac on 30/11/2017.
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

- (NSURL *)imgsrc_url {
    
    return [NSURL URLWithString:self.news.imgsrc];
}

- (NSString *)replyCount_string {
    
    // 测试跟帖数超过1万
//    self.news.replyCount = 23456;
    
    if (self.news.replyCount >= 10000) {
        
        NSString *string = [NSString stringWithFormat:@"%ld万 跟帖", self.news.replyCount / 10000];
        return string;
    }
    return [NSString stringWithFormat:@"%ld 跟帖", self.news.replyCount];
}

@end
