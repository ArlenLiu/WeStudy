//
//  ContentViewController.m
//  WeStudy
//
//  Created by Arlenly on 16/3/4.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import "ContentViewController.h"
#import "ContentTableViewCell.h"
#import "Contants.h"
#import "GDataXMLNode.h"
#import "UtilMethod.h"
#import "NewsModel.h"
#import "BlogModel.h"

@interface ContentViewController () <UITableViewDataSource,UITableViewDelegate>
{
    // 数据源
    NSMutableArray *arrDataSource;
    // URL 源
    NSArray *arrURL;
    // 当前栏目标识，若栏目已经过滑动换成其他栏目，则数据源需清空
    NSUInteger currentPage;
}

// collection 的 cell 为当前文件，上面又有一个 tbv
@property (weak, nonatomic) IBOutlet UITableView *tbv;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化数据源
    arrDataSource = [[NSMutableArray alloc] init];
    arrURL = @[ZH_INFO,ZH_HOT,ZH_BLOG,ZH_RECOMMEND];
    
}

// 得到页码，网络获取相应页码的接口，解析之 -- 开源中国接口解析
- (void)showPageIndex:(NSUInteger)pageIndex {
    // 获取新的栏目时，数组应清空，实际开发时，还要考虑当前是否是第一页
    if (currentPage != pageIndex) {
        [arrDataSource removeAllObjects];
    }
    //更新当前栏目
    currentPage = pageIndex;
    
    // pageIndex 为 0、1 的接口跟 2、3 的不太一样
    AFHTTPSessionManager *manager = [UtilMethod managerHTTP];
    
    // 资讯、热点
    if (pageIndex == 0 || pageIndex == 1) {
        [manager POST:arrURL[pageIndex] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithData:responseObject encoding:NSUTF8StringEncoding error:nil];
            // 文档根节点元素
            GDataXMLElement *rootElement = xmlDoc.rootElement;
            NSArray *arrForNewsList = [rootElement elementsForName:@"newslist"];
            GDataXMLElement *newsEle = arrForNewsList[0];
            NSArray *arrForNews = [newsEle elementsForName:@"news"];
            
            // news 中有 20 个元素
            for (int i = 0; i < arrForNews.count; i ++) {
                GDataXMLElement *news = arrForNews[i];
                // title 中只有一个 node 节点元素
                NSArray *arrTitle = [news elementsForName:@"title"];
                GDataXMLNode *nodeTitle = arrTitle[0];
                // body
                NSArray *arrBody = [news elementsForName:@"body"];
                GDataXMLNode *nodeBody = arrBody[0];
                // author
                NSArray *arrAuthor = [news elementsForName:@"author"];
                GDataXMLNode *nodeAuthor = arrAuthor[0];
                
                NewsModel *newsModel = [[NewsModel alloc] init];
                newsModel.title = nodeTitle.stringValue;
                newsModel.body = nodeBody.stringValue;
                newsModel.author = nodeAuthor.stringValue;
                // 加入到数据源中
                [arrDataSource addObject:newsModel];
            }
            // **** 刷新 tableview，不然没有数据
            [self.tbv reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error:%@",error);
        }];
    }
    // 博客、推荐
    else {
        [manager POST:arrURL[pageIndex] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithData:responseObject encoding:NSUTF8StringEncoding error:nil];
            // 文档根节点元素
            GDataXMLElement *rootElement = xmlDoc.rootElement;
            NSArray *arrForNewsList = [rootElement elementsForName:@"blogs"];
            GDataXMLElement *newsEle = arrForNewsList[0];
            NSArray *arrForNews = [newsEle elementsForName:@"blog"];
            
            // blog
            for (int i = 0; i < arrForNews.count; i ++) {
                GDataXMLElement *news = arrForNews[i];
                // title 中只有一个 node 节点元素
                NSArray *arrTitle = [news elementsForName:@"title"];
                GDataXMLNode *nodeTitle = arrTitle[0];
                // body
                NSArray *arrBody = [news elementsForName:@"body"];
                GDataXMLNode *nodeBody = arrBody[0];
                // author
                NSArray *arrAuthor = [news elementsForName:@"authorname"];
                GDataXMLNode *nodeAuthorName = arrAuthor[0];
                
                BlogModel *blogModel = [[BlogModel alloc] init];
                blogModel.title = nodeTitle.stringValue;
                blogModel.body = nodeBody.stringValue;
                blogModel.authorname = nodeAuthorName.stringValue;
                // 加入到数据源中
                [arrDataSource addObject:blogModel];
            }
            // 刷新 tableview
            [self.tbv reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error:%@",error);
        }];
    }
}

#pragma mark - 代理协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentTable" forIndexPath:indexPath];
    // 添加数据，判断 数据源 是 news_list 还是 blog_list 的子类，即判断是来自哪个模型（0、1，2、3）
    if ([arrDataSource[0] isMemberOfClass:[NewsModel class]]) {
        NewsModel *newsModel = arrDataSource[indexPath.row];
        cell.lbTitle.text = newsModel.title;
        cell.lbSubTitle.text = newsModel.body;
        cell.lbDescrible.text = newsModel.author;
    }
    if ([arrDataSource[0] isMemberOfClass:[BlogModel class]]) {
        BlogModel *blogModel = arrDataSource[indexPath.row];
        cell.lbTitle.text = blogModel.title;
        cell.lbSubTitle.text = blogModel.body;
        cell.lbDescrible.text = blogModel.authorname;
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
