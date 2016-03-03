//
//  RootViewController.m
//  WeStudy
//
//  Created by qianfeng on 16/2/19.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import "RootViewController.h"
#import "Contants.h"
#import "IndustryViewController.h"
#import "TrendsViewController.h"
#import "FrendsViewController.h"
#import "CourseViewController.h"
#import "PersonalViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置第一次进入时显示的分栏项
    self.tabBarController.selectedIndex = 4;
    
    // 自定义 tabbar 分栏
    [self customTabBar];
    
    // 导航条左侧按钮
    [self leftNavi];
    
}

// 自定义 tabbar 分栏
- (void)customTabBar {
    // 分栏条前景色，选中状态
//    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:13/255.0 green:178/255.0 blue:46/255.0 alpha:1.0];
    self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.translucent = NO;
    
//    [self.tabBarController.tabBar.selectedImageTintColor = [UIColor orangeColor];
    
    
    // 分栏条背景色
//    self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:77/255.0 green:132/255.0 blue:241/255.0 alpha:1.0];
    
    // Trends 动态 -- 分栏正中间按钮
    UIButton *centerBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH / 2 - HEIGHT_TABBAR / 2, 0, HEIGHT_TABBAR, HEIGHT_TABBAR)];
    [centerBtn setBackgroundImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    centerBtn.userInteractionEnabled = YES;
    [self.tabBarController.tabBar addSubview:centerBtn];
}

// 导航条左侧按钮
- (void)leftNavi {
    // 设置状态栏和navigatiionbar前景色为白色（透明度取消），即文字为白色
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    // 导航条背景色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:77/255.0 green:132/255.0 blue:241/255.0 alpha:1.0];
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(leftClick)];
    leftBarItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
}

// 左侧按钮点击事件 -- 抽屉效果
- (void)leftClick {
    
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
