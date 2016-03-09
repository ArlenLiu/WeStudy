//
//  NoticeViewController.m
//  WeStudy
//
//  Created by Arlenly on 16/3/2.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import "NoticeViewController.h"

@interface NoticeViewController ()

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 导航条返回键文字颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // 设置背景色
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:243/255.0 alpha:1.0];
    // 右侧按钮标题
    self.navigationItem.title = @"通知";
    
    UILabel *lbPrompt = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    lbPrompt.text = @"没有通知";
    lbPrompt.textAlignment = NSTextAlignmentCenter;
    lbPrompt.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2-64);
    lbPrompt.textColor = [UIColor grayColor];
    [self.view addSubview:lbPrompt];
    
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
