![](http://upload-images.jianshu.io/upload_images/2069062-71f45a10b6969e90.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

本篇只是简单介绍一下`MVVM`的大致模式，每个人对每种架构模式有自己的理解，本文也是单纯的从获取新闻列表数据，并将其显示到界面上而已。暂时不做过多的考虑。

---

## MVVM 简介

看下`MVVM`大致模式图 :

![](http://upload-images.jianshu.io/upload_images/2069062-ccfb40c35f764c5e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

相当于在`View`、`ViewController`和`Model`之间多了一层`ViewModel`。那么多出这层起到了什么作用呢？好处又好在哪里呢？

简单说就是如果数据结构有变动，而`View`层没有变动的话，那么只要处理`ViewModel`中的业务逻辑就可以了。`ViewModel`的主要作用就是`处理数据`、`处理一些小的业务逻辑`等一些作用。

下面以一个新闻列表为例，展示结果如下图 :

![](http://upload-images.jianshu.io/upload_images/2069062-80af1478ea8cfbae.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

---

## 文件结构

```
- Main
    - AppDelegate.h
    - AppDelegate.m
    - main.m
- News
    - Controller
        - QQNewsViewController.h
        - QQNewsViewController.m
    - ViewModel
        - QQNewsListViewModel.h
        - QQNewsListViewModel.m
        - QQNewsViewModel.h
        - QQNewsViewModel.m
    - View
        - QQNewsCell.h
        - QQNewsCell.m
    - Model
        - QQNews.h
        - QQNews.m
- Tool
    - NetWork
        - QQNetworkManager.h
        - QQNetworkManager.m
        - QQNetworkManager+QQNews.h
        - QQNetworkManager+QQNews.m
```

文件结构说明

- `QQNewsViewModel` 单条新闻视图模型`(处理业务逻辑)`
- `QQNewsListViewModel` 新闻列表视图模型`(获取数据、加工数据)`
- `QQNetworkManager`网络请求工具类
- `QQNetworkManager+QQNews`网络请求工具类的分类`(专门用于获取新闻列表数据)`

---

## 获取数据

在`QQNetworkManager`的分类`QQNetworkManager+QQNews`中定义一个加载新闻数据的方法，供外界调用。

拿到的数据后，简单处理一下，回调到`QQNewsListViewModel`中。

```
#import "QQNetworkManager.h"

@interface QQNetworkManager (QQNews)

- (void)loadNewsDataCompletion:(void (^)(NSArray *dataArray))completion;

@end
```

```
#import "QQNetworkManager+QQNews.h"

static NSString *const newsURLString = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-10.html";

@implementation QQNetworkManager (QQNews)

- (void)loadNewsDataCompletion:(void (^)(NSArray *))completion {
    
    [[QQNetworkManager sharedManager] qq_request:GET urlString:newsURLString parameters:nil finished:^(id result, NSError *error) {
        if (error) {
            NSLog(@"%s %@", __FUNCTION__, error);
        }
        NSLog(@"%s %@", __FUNCTION__, result);
        
        /**
         * 简单处理数据,只把需要的回调到`QQNewsListViewModel`中
         */
        completion(result[@"T1348647853363"]);
    }];
}

@end
```

在`QQNewsListViewModel.h`中定义新闻`视图模型`数组，用来控制`QQNewsViewController`中`TableView`显示的`Cell`行数及`Cell`的显示内容。

```
QQNewsListViewModel.h

@class QQNewsViewModel;

@interface QQNewsListViewModel : NSObject

/// 新闻`视图模型`数组
@property (nonatomic, strong) NSMutableArray *newsList;

/**
 加载新闻数据

 @param completion completion
 */
- (void)loadNewsDataCompletion:(void (^)(BOOL isSuccessed))completion;

@end
```

在`QQNewsListViewModel.m`中进行数据加工，将拿到的`字典`数组转化为`视图模型`数组

```
QQNewsListViewModel.m

- (void)loadNewsDataCompletion:(void (^)(BOOL))completion {
    
    // 调用`QQNetworkManager+QQNews`中的获取新闻数据的方法
    [[QQNetworkManager sharedManager] loadNewsDataCompletion:^(NSArray *dataArray) {
        
        NSLog(@"%s %@", __FUNCTION__, dataArray);
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:dataArray.count];
        
        for (NSDictionary *dict in dataArray) {
            
            QQNews *news = [QQNews mj_objectWithKeyValues:dict];
            [arrayM addObject:[QQNewsViewModel viewModelWithNews:news]];
        }
        
        [self.newsList addObjectsFromArray:arrayM];
        
        // 将结果回调给`QQNewsViewController`,使其进行刷新界面等操作
        completion(YES);
    }];
}
```

接下来`QQNewsViewController`中就只持有`QQNewsListViewModel`，基本主要方法就剩下了`TableView`的`DataSource`和`Delegate`方法了。

```
@interface QQNewsViewController ()<UITableViewDataSource, UITableViewDelegate>

/// TableView
@property (nonatomic, strong) UITableView *tableView;
/// 新闻视图模型数组
@property (nonatomic, strong) QQNewsListViewModel *newsListViewModel;

@end

@implementation QQNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
}

#pragma mark - Load Data
- (void)loadData {
    
    [self.newsListViewModel loadNewsDataCompletion:^(BOOL isSuccessed) {
        
        if (!isSuccessed) {
            NSLog(@"%s 没有请求到数据", __FUNCTION__);
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.navigationItem.title = @"新闻列表";
    [self tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsListViewModel.newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQNewsCell *cell = [QQNewsCell newsCellWithTableView:tableView];
    cell.viewModel = self.newsListViewModel.newsList[indexPath.row];
    return cell;
}
```

`QQNewsCell`里赋值的方法就可以简化成如下 :

```
- (void)setViewModel:(QQNewsViewModel *)viewModel {
    _viewModel = viewModel;
    
    [self.newsImageView sd_setImageWithURL:viewModel.imgsrc_url];
    self.newsTitleLabel.text = viewModel.news.title;
    self.newsSubTitleLabel.text = viewModel.news.digest;
    self.replyCountLabel.text = viewModel.replyCount_string;
}
```

`imgsrc_url`和`replyCount_string`都是根据拿到的数据在`QQNewsViewModel`里面加工处理过的。`QQNewsCell`不需要关心返回数据需要经过再次处理的事情，安心展示界面就`OK`了。

接下来`QQNewsViewModel`就来处理各种业务逻辑了，比如`时间`、`跟帖数`等等一切不能直接把数据直接显示，需要再加工的事情。

```
QQNewsViewModel.h

/// 新闻数据模型
@property (nonatomic, strong) QQNews *news;
/// 新闻图片URL
@property (nonatomic, strong) NSURL *imgsrc_url;
/// 跟帖数(在此处理)
@property (nonatomic, copy) NSString *replyCount_string;

+ (instancetype)viewModelWithNews:(QQNews *)news;
```

处理业展示的数据，并可以直接对一些情况方便的进行测试，比如查看跟帖数大于1万人时的显示等等...

```
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
```

如果没有`ViewModel`层的话，这些事情基本都是要放在`Cell`的`setModel`方法里面去做。如果`Cell`界面够复杂的话，`Cell`内的代码就会超级多。也不是不行，只是不太便于我们进行修改测试等。

本文这种情况用这种`MVVM`模式无疑是有点用力过猛了。但是我觉得实际开发中，很少能碰到这么简单的业务逻辑的，如果业务逻辑多起来了。这种模式就会突显出它的好处了。

**原文地址 : [iOS-MVVM 模式简单演练](http://www.jianshu.com/p/97a488b9cbde)**