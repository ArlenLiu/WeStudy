//
//  LeftDrawerViewController.m
//  WeStudy
//
//  Created by Arlenly on 16/3/1.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import "LeftDrawerViewController.h"

@interface LeftDrawerViewController ()

@end

@implementation LeftDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 导航条返回键文字颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // 设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    // 右侧按钮标题
    self.navigationItem.title = @"抽屉";
    
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 150, 100)];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [back setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:back];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
}

// back 点击事件
- (void)back:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
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
