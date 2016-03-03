//
//  PersonalViewController.m
//  WeStudy
//
//  Created by qianfeng on 16/2/19.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import "PersonalViewController.h"
#import "Contants.h"
#import "LoginViewController.h"
#import "SettingsViewController.h"
#import "FollowMajorViewController.h"
#import "NoticeViewController.h"
#import "StarsViewController.h"
#import "LocationInnerViewController.h"
#import "MultiMediaViewController.h"
#import "MaterialStoreViewController.h"

@interface PersonalViewController () <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *portraitView;

@property (weak, nonatomic) IBOutlet UIButton *userName;

@property (weak, nonatomic) IBOutlet UIButton *studyData;

// 保存登录信息，自动登录
@property (nonatomic,strong) NSUserDefaults *loginUserDefaults;

// storyboard
@property (nonatomic,strong) UIStoryboard *storyMain;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置圆圆的头像，默认头像从本地读取 portrait0.png
    self.portraitView.layer.cornerRadius = self.portraitView.frame.size.width / 2;
    self.portraitView.clipsToBounds = YES;
    
    // 初始化 NSUserDefaults，自动登录
    self.loginUserDefaults = [NSUserDefaults standardUserDefaults];
    
    // storyboard 初始化
    self.storyMain = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    // 注销功能、账号切换功能
    
    
}

// 登录成功后，刷新数据（由于从登录页面成功后到此页面是 dismiss 的，数据在那边刷新不了，在这里做）
// 如果已经登录（NsUserDefaults 中有登录账户），直接进入显示登录
- (void)viewWillAppear:(BOOL)animated {
    // 账户信息，来自 NSUserDefaults
    NSString *loginok = [self.loginUserDefaults stringForKey:@"loginok"];
    
    // 登录成功，刷新用户名、学习数据、头像，自动登录
    if (loginok != nil) {
        NSString *name = [self.loginUserDefaults stringForKey:@"username"]; // 用户名
        NSString *studyata  =[self.loginUserDefaults stringForKey:@"studydata"];    // 学习数据
        NSString *domainOfPortrait  =[self.loginUserDefaults stringForKey:@"domainOfPortrait"]; // 头像
//        NSLog(@"%@",domainOfPortrait);
        [self.userName setTitle:[NSString stringWithFormat:@"欢迎您:%@",name] forState:UIControlStateNormal]; // 用户名
        [self.studyData setTitle:studyata forState:UIControlStateNormal];   // 学习数据
        self.portraitView.image = [UIImage imageNamed:domainOfPortrait];    // 头像
    }
    // 已经登陆过不能再请求图片，从图片缓存读取
    ///////////////// 待完成 ////////////////////
    
}

// 头像图片手势
- (IBAction)loginGesPic:(id)sender {
    // UITapGestureRecognizer
    NSString *str = [self.loginUserDefaults stringForKey:@"loginok"];
    
    // 未登录状态，模态方式弹出登录界面
    if (str == nil) {
        LoginViewController *login = [_storyMain instantiateViewControllerWithIdentifier:@"login"];
        [self presentViewController:login animated:YES completion:nil];
    }
    // 已经处于登录状态，点击头像可修改头像
    else {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
        [actionSheet showInView:self.view];
    }
}

// 修改头像的协议方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    ///////////////// 待完成 ////////////////////
}

// 左侧书签按钮 -- 抽屉
///////////////// 待完成 ////////////////////

// navigation 右侧设置按钮
- (IBAction)rightSettings:(UIBarButtonItem *)sender {
    // 从 storyboard 中取才有用
    SettingsViewController *settings = [_storyMain instantiateViewControllerWithIdentifier:@"settings"];
    // 推入新的 view 隐藏tabbar
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settings animated:YES];
    // 返回来的时候显示 tabbar
    self.hidesBottomBarWhenPushed = NO;
}

// 关注行业点击事件
- (IBAction)followMajor:(id)sender {
    FollowMajorViewController *followMajor = [[FollowMajorViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:followMajor animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

// 通知点击事件
- (IBAction)notice:(id)sender {
    NoticeViewController *notice = [[NoticeViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:notice animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

// 收藏点击事件
- (IBAction)stars:(id)sender {
    StarsViewController *stars = [[StarsViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:stars animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

// 室内定位点击事件
- (IBAction)locationInner:(id)sender {
    LocationInnerViewController *locationInner = [[LocationInnerViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:locationInner animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

// 多媒体点击事件
- (IBAction)multiMedia:(id)sender {
    MultiMediaViewController *multiMedia = [[MultiMediaViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:multiMedia animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

// 资料库点击事件
- (IBAction)materiaStore:(id)sender {
    MaterialStoreViewController *materiaStore = [[MaterialStoreViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:materiaStore animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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
