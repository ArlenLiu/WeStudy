//
//  SettingsViewController.m
//  WeStudy
//
//  Created by Arlenly on 16/3/1.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

// 保存登录信息，自动登录 -- 这里是注销登录，重设 NSUserDefaults
@property (nonatomic,strong) NSUserDefaults *loginUserDefaults;


@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 导航条返回键文字颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // 设置背景色
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:243/255.0 alpha:1.0];
    // 右侧按钮标题
    self.navigationItem.title = @"设置";
    
    // 初始化 NSUserDefaults，这里用来退出账户
    self.loginUserDefaults = [NSUserDefaults standardUserDefaults];
    
    
}

// 退出登录 -- 注销？
- (IBAction)logout:(id)sender {
    // 类方法 resetStandardUserDefaults 清除 NSUserDefaults ？切换账号？注销？
//    [NSUserDefaults resetStandardUserDefaults];   // 没用？
    
    // 删除 NSUserDefaults 文件 -- 没用？
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *pathUserDefaults = [NSString stringWithFormat:@"%@/Preferences/",libraryPath];
    NSString *identifier  = [[NSBundle mainBundle] bundleIdentifier];
    NSString *filePath = [pathUserDefaults stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",identifier]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        // 存在 NSUserDefaults 文件，删除之，退出登录
        [fileManager removeItemAtPath:filePath error:nil];
    }
    
    // 发送当前页的通知 -- 注销账号
    NSNotification *notice = [NSNotification notificationWithName:@"logout" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    
    // ?
    [self.navigationController popViewControllerAnimated:YES];
    
    ///////////////// 待完成，注销之后界面变化或退出程序？ ////////////////////
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
