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
#import "UtilMethod.h"
#import "NewsModel.h"
#import "BlogModel.h"
#import "MJRefresh.h"
#import "DetailWebViewController.h"

@interface ContentViewController () <UITableViewDataSource,UITableViewDelegate>
{
    // 数据源
    NSMutableArray *arrDataSource;
    // URL 源
    NSArray *arrURL;
    // 当前栏目标识，若栏目已经过滑动换成其他栏目，则数据源需清空
    NSUInteger currentPage;
    // 当前的页码 -- 刷新的页码
    int pageRefresh;
}
// collection 的 cell 为当前文件，上面又有一个 tbv
@property (weak, nonatomic) IBOutlet UITableView *tbv;
@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 初始化
    [self initData];
    
    // 下拉刷新、上拉加载 -- 获取通知中心单例对象
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // 添加当前类对象为一个观察者，name 和 object 设置为 nil 表示接收一切通知
    [center addObserver:self selector:@selector(configTable:) name:@"currentPage" object:nil];
    
}

- (void)initData {
    // 初始化数据源
    arrDataSource = [[NSMutableArray alloc] init];
    arrURL = @[ZH_INFO,ZH_HOT,ZH_BLOG,ZH_RECOMMEND];
    // 刷新页码初始化
    pageRefresh = 1;
    _manager = [UtilMethod managerHTTP];
}

// 下拉刷新、上拉加载
- (void)configTable:(NSNotification *)noice {
    NSInteger pageIndex = [[noice.userInfo objectForKey:@"pageIndex"] intValue];
    
    // 配置 header
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 下拉刷新的方法
        pageRefresh = 1;
        // 重写读取数据显示
        [arrDataSource removeAllObjects];
        [self showPageIndex:pageIndex];
        
    }];
    [refreshHeader setTitle:@"下拉刷新" forState:MJRefreshStatePulling];
    self.tbv.mj_header = refreshHeader; // 先把 header 配置好了，再赋值给 tbv 的 header
    
    self.tbv.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 上拉加载更多
        pageRefresh ++;
        [self showPageIndex:pageIndex];
    }];
}

// 得到页码，网络获取相应页码的接口，解析之 -- 开源中国接口解析
- (void)showPageIndex:(NSUInteger)pageIndex {
    // 获取新的栏目时，数组应清空，实际开发时，还要考虑当前是否是第一页
    if (currentPage != pageIndex) {
        [arrDataSource removeAllObjects];
    }
    //更新当前栏目
    currentPage = pageIndex;
    
    // 发送当前页的通知，更新 currentPage ，用来做下拉刷新、上拉加载，创建消息对象发送消息
    NSNotification *notice = [NSNotification notificationWithName:@"currentPage" object:nil userInfo:@{@"pageIndex":[NSString stringWithFormat:@"%lu",(unsigned long)pageIndex]}];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    
    // pageIndex 为 0、1 的接口跟 2、3 的不太一样
    // 资讯、热点
    if (pageIndex == 0 || pageIndex == 1) {
        [self requestNews:pageIndex];
    }
    // 博客、推荐
    else {
        [self requestBlog:pageIndex];
    }
}

- (void)requestNews:(NSUInteger)pageIndex {
    [_manager POST:arrURL[pageIndex] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _xmlDoc = [[GDataXMLDocument alloc] initWithData:responseObject encoding:NSUTF8StringEncoding error:nil];
        // 文档根节点元素
        _rootElement = _xmlDoc.rootElement;
        _arrForNewsList = [_rootElement elementsForName:@"newslist"];   // news -- 20 个元素
        _newsEle = _arrForNewsList[0];
        _arrForNews = [_newsEle elementsForName:@"news"];
        for (int i = 0; i < _arrForNews.count; i ++) {
            _news = _arrForNews[i];
            _arrTitle = [_news elementsForName:@"title"];    // title 中只有一个 node 节点元素
            _nodeTitle = _arrTitle[0];
            _arrBody = [_news elementsForName:@"body"];
            _nodeBody = _arrBody[0];
            _arrAuthor = [_news elementsForName:@"author"];
            _nodeAuthor = _arrAuthor[0];
            _arrPubDate = [_news elementsForName:@"pubDate"];
            _nodePubDate = _arrPubDate[0];
            _arrID = [_news elementsForName:@"id"];
            _nodeID = _arrID[0];
            
            NewsModel *newsModel = [[NewsModel alloc] init];
            newsModel.title = _nodeTitle.stringValue;
            newsModel.body = _nodeBody.stringValue;
            newsModel.author = _nodeAuthor.stringValue;
            newsModel.pubDate = _nodePubDate.stringValue;
            newsModel.id_detail = _nodeID.stringValue.intValue;
            // 加入到数据源中
            [arrDataSource addObject:newsModel];
        }
        // 刷新 tableview，表格加载完毕，结束刷新
         [self reloadAndRefresh];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
}

- (void)requestBlog:(NSUInteger)pageIndex {
    [_manager POST:arrURL[pageIndex] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _xmlDoc = [[GDataXMLDocument alloc] initWithData:responseObject encoding:NSUTF8StringEncoding error:nil];
        // 文档根节点元素
        _rootElement = _xmlDoc.rootElement;
        _arrForNewsList = [_rootElement elementsForName:@"blogs"];  // blog -- 20
        _newsEle = _arrForNewsList[0];
        _arrForNews = [_newsEle elementsForName:@"blog"];
        for (int i = 0; i < _arrForNews.count; i ++) {
            _news = _arrForNews[i];
            _arrTitle = [_news elementsForName:@"title"];
            _nodeTitle = _arrTitle[0];
            _arrBody = [_news elementsForName:@"body"];
            _nodeBody = _arrBody[0];
            _arrAuthor = [_news elementsForName:@"authorname"];  // authorname
            _nodeAuthor = _arrAuthor[0];
            _arrPubDate = [_news elementsForName:@"pubDate"];
            _nodePubDate = _arrPubDate[0];
            _arrID = [_news elementsForName:@"id"];
            _nodeID = _arrID[0];
            _arrURLDetail = [_news elementsForName:@"url"];
            _nodeURL = _arrURLDetail[0];
            
            BlogModel *blogModel = [[BlogModel alloc] init];
            blogModel.title = _nodeTitle.stringValue;
            blogModel.body = _nodeBody.stringValue;
            blogModel.authorname = _nodeAuthor.stringValue;
            blogModel.pubDate = _nodePubDate.stringValue;
            blogModel.id_detail = _nodeID.stringValue.intValue;
            blogModel.url = _nodeURL.stringValue;
            // 加入到数据源中
            [arrDataSource addObject:blogModel];
        }
        // 刷新 tableview，表格加载完毕，结束刷新
        [self reloadAndRefresh];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
}

- (void)reloadAndRefresh {
    [self.tbv reloadData];
    [self.tbv.mj_header endRefreshing];
    [self.tbv.mj_footer endRefreshing];
}

#pragma mark - 代理协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrDataSource.count;
}

// 添加数据，判断 数据源 是 news_list 还是 blog_list 的子类，即判断是来自哪个模型（0、1，2、3）
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentTable" forIndexPath:indexPath];
    if (arrDataSource.count > 0) {
        if ([arrDataSource[0] isMemberOfClass:[NewsModel class]]) {
            NewsModel *newsModel = arrDataSource[indexPath.row];
            cell.title.text = newsModel.title;
            cell.body.text = newsModel.body;
            cell.author.text = [NSString stringWithFormat:@"%@  %@",newsModel.author,newsModel.pubDate];
        }
        if ([arrDataSource[0] isMemberOfClass:[BlogModel class]]) {
            BlogModel *blogModel = arrDataSource[indexPath.row];
            cell.title.text = blogModel.title;
            cell.body.text = blogModel.body;
            cell.author.text = [NSString stringWithFormat:@"%@  %@",blogModel.authorname,blogModel.pubDate];
        }
    }
    return cell;
}

// 行点击跳转到详细页，通过 id_detail 传过去网页的 URL
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailWebViewController *detailWeb = [story instantiateViewControllerWithIdentifier:@"detailContent"];
    
    ///////////// 这里的接口不是 HTML ！！！改，传过去接口继续解析
    
    if (arrDataSource.count > 0) {
        if ([arrDataSource[0] isMemberOfClass:[NewsModel class]]) {
            NewsModel *newsModel = arrDataSource[indexPath.row];
//            NSString *strURL = [NSString stringWithFormat:@"%@?id=%ld",NEWS_DETAIL,(long)newsModel.id_detail];    // 原接口在详细页还要进行解析，这里提取成了网页版
            NSString *strURL = [NSString stringWithFormat:@"%@%ld",NEWS_HTML,(long)newsModel.id_detail];
            // 传值可用 kvc，传 URL 到详细页
            [detailWeb setValue:strURL forKey:@"strURL"];
            // 方式一跳转，直接获取其框架视图控制器对象
            [self.myViewController.navigationController pushViewController:detailWeb animated:YES];
        }
        if ([arrDataSource[0] isMemberOfClass:[BlogModel class]]) {
            BlogModel *blogModel = arrDataSource[indexPath.row];
            NSString *strURL = [NSString stringWithFormat:@"%@",blogModel.url];     // 网页
            [self.myViewController.navigationController pushViewController:detailWeb animated:YES];
            [detailWeb setValue:strURL forKey:@"strURL"];
        }
    }
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
