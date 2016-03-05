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

#define BTN_START_TAG 888

@interface IndustryViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    // 顶部栏目数据源
    NSArray *arrColumnDataSource;
    // 当前页
    NSUInteger currentPage;
    // 导航栏分栏字体大小
    UIFont *font_big;
    UIFont *font_small;
    // 顶部分栏数量
    NSInteger numOfTopColumn;
}

// collection
@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@end

@implementation IndustryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"行业";
    
    font_big = [UIFont systemFontOfSize:17];
    font_small = [UIFont systemFontOfSize:14];;
    
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
}

- (void)initData {
    arrColumnDataSource = @[@"资讯",@"热点",@"博客",@"推荐"];
    // 顶部分栏数量
    numOfTopColumn = arrColumnDataSource.count;
}

- (void)showColumn {
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, H_TOP_INDUSTRY)];
    [self.view addSubview:uv];
    uv.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0];
    for (int i = 0; i < numOfTopColumn; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * WIDTH / 4 + i*5, 0, WIDTH / 4 - 4*5, H_TOP_INDUSTRY)];
        [btn setTitle:arrColumnDataSource[i] forState:UIControlStateNormal];
        if (i == 0) {
            [btn setTitleColor:BlueDefault forState:UIControlStateNormal];
            btn.titleLabel.font = font_big;
        }else {
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn.titleLabel.font = font_small;
        }
        btn.tag = BTN_START_TAG + i;
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)btnClick:(UIButton *)btn {
    // 被点击的按钮上的文字变成蓝色，其他文字为灰色
    btn.titleLabel.font = font_big;
    [btn setTitleColor:BlueDefault forState:UIControlStateNormal];
    
    for (int i = BTN_START_TAG; i < BTN_START_TAG + numOfTopColumn; i ++) {
        if (btn.tag != i) {
            UIButton *b = [self.view viewWithTag:i];
            [b setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            b.titleLabel.font = font_small;
        }
    }
    
    // 点击导航条跳转到指定页面
    currentPage = btn.tag - BTN_START_TAG;
    [_collection setContentOffset:CGPointMake(currentPage * WIDTH, 0) animated:YES];
}

#pragma mark - scrollview 缓冲停下时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 当前页
    CGPoint pt = scrollView.contentOffset;
    currentPage = pt.x / self.view.frame.size.width;
    
    // 设置第 currentPage 个 button 为选中状态，颜色为蓝色，其余为灰色
    UIButton *btn = [self.view viewWithTag:currentPage + BTN_START_TAG];
    [btn setTitleColor:BlueDefault forState:UIControlStateNormal];
    btn.titleLabel.font = font_big;
    for (int i = BTN_START_TAG; i < BTN_START_TAG + numOfTopColumn; i ++) {
        UIButton *btn = [self.view viewWithTag:i];
        if (btn.tag != currentPage + BTN_START_TAG) {
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn.titleLabel.font = font_small;
        }
    }
}

// 开源中国接口 ZH_INFO -- 综合 - 资讯
- (void)dataFromWeb {
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
    // 文档根节点元素
    GDataXMLElement *rootElement = xmlDoc.rootElement;
//    NSLog(@"%@",rootElement);
    
    
    
}

#pragma mark - 代理协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return numOfTopColumn;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IndustryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"content" forIndexPath:indexPath];
//    cell.contentVC
    
    
    return cell;
}

// tableview 初始顶部位置
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
