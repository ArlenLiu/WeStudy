//
//  IndustryViewController.m
//  WeStudy
//
//  Created by qianfeng on 16/2/19.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import "IndustryViewController.h"
#import "Contants.h"
#import "UtilMethod.h"
#import "GDataXMLNode.h"
#import "IndustryCollectionViewCell.h"

@interface IndustryViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    // 顶部栏目数据源
    NSArray *arrColumnDataSource;
    //
    NSUInteger currentPage;
}

//
@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@end

@implementation IndustryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"行业";
    
    // 初始化数据
    [self initData];
    
    // 网络读取数据
    [self dataFromWeb];
    
    // 注册 collection cell
    [self registerCells];
    
    // 顶部栏目
    [self showColumn];
}

- (void)registerCells {
    [_collection registerClass:[IndustryCollectionViewCell class] forCellWithReuseIdentifier:@"content"];
//    _collection.dataSource = self;
//    _collection.delegate = self;
}

- (void)initData {
    arrColumnDataSource = @[@"资讯",@"热点",@"博客",@"推荐"];
}

- (void)showColumn {
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, H_TOP_INDUSTRY)];
    [self.view addSubview:uv];
    uv.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0];
    for (int i = 0; i < 4; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * WIDTH / 4 + i * 5, 0, WIDTH / 4 - (4*5), H_TOP_INDUSTRY)];
        [btn setTitle:arrColumnDataSource[i] forState:UIControlStateNormal];
        if (i == 0) {
            [btn setTitleColor:[UIColor colorWithRed:77/255.0 green:132/255.0 blue:241/255.0 alpha:1.0] forState:UIControlStateNormal];
        }else {
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        btn.tag = 88 + i;
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)btnClick:(UIButton *)btn {
    // 被点击的按钮上的文字变成蓝色，其他文字为灰色
    for (int i = 88; i < 88 + 4; i ++) {
        if (btn.tag == i) {
            [btn setTitleColor:[UIColor colorWithRed:77/255.0 green:132/255.0 blue:241/255.0 alpha:1.0] forState:UIControlStateNormal];
        }else {
            // 除了被点击的按钮之外的按钮在这里设置
            UIButton *b = [self.view viewWithTag:i];
            [b setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
    
    // 点击导航条跳转到指定页面
    currentPage = btn.tag - 88;
    [_collection setContentOffset:CGPointMake(currentPage * WIDTH, 0) animated:YES];
}

#pragma mark - UIScrollView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint pt = scrollView.contentOffset;
    currentPage = pt.x / self.view.frame.size.width;
}

- (void)dataFromWeb {
    // 开源中国接口 ZH_INFO -- 综合 - 资讯
    AFHTTPSessionManager *manager = [UtilMethod managerHTTP];
    [manager POST:ZH_INFO parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // XML 解析 - 开源中国接口
        [self parseXML:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
}

// XML 解析 - 开源中国接口
- (void)parseXML:(NSData *)dataXML {
    GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithData:dataXML encoding:NSUTF8StringEncoding error:nil];
    // 获取文档根节点元素
    GDataXMLElement *rootElement = xmlDoc.rootElement;
//    NSLog(@"%@",rootElement);
    
    
    
}

#pragma mark - 代理协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IndustryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"content" forIndexPath:indexPath];
//    cell.contentVC
    
    
    return cell;
}

// 让 tableview 向下移动 80
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(WIDTH, HEIGHT - 44 - H_TOP_INDUSTRY);
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
