//
//  QQNews.h
//  MVVM
//
//  Created by Mac on 29/11/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQNews : NSObject

/** 新闻主标题 */
@property (nonatomic, copy) NSString *title;
/** 新闻摘要 */
@property (nonatomic, copy) NSString *digest;
/** 新闻图片地址 */
@property (nonatomic, copy) NSString *imgsrc;

@end