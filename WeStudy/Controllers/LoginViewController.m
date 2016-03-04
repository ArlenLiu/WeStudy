//
//  LoginViewController.m
//  WeStudy
//
//  Created by Arlenly on 16/2/29.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import "LoginViewController.h"
#import "Contants.h"
#import "UtilMethod.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *loginView;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UITextField *tfUser;

@property (weak, nonatomic) IBOutlet UITextField *tfPwd;

// 保存登录信息，自动登录 -- 这里是写入，需要初始化
@property (nonatomic,strong) NSUserDefaults *loginUserDefaults;

// 缓存头像
@property (nonatomic,strong) UIImage *imgPortait;

// 缓存头像路径
@property (nonatomic,strong) NSString *pathCachePortrait;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化
    self.loginUserDefaults = [NSUserDefaults standardUserDefaults];
    
    // 登陆输入框样式设置
    self.loginView.layer.cornerRadius = LOGIN_CORNER;
    self.loginView.clipsToBounds = YES;
    self.loginBtn.layer.cornerRadius = LOGIN_CORNER;
    self.tfUser.layer.cornerRadius = LOGIN_CORNER;
    self.tfPwd.layer.cornerRadius = LOGIN_CORNER;
    // 登录 tf 为第一响应者
    [self.tfUser becomeFirstResponder];
    
    // UITextField 代理
    self.tfUser.delegate = self;
    self.tfPwd.delegate = self;
    self.tfUser.tag = 111;
    self.tfPwd.tag = 112;
    
    // 设置输入框的左侧，用 label 撑出空白
    [self setLoginLeft];
    
    // 得到缓存路径，用来存放缓存头像
    self.pathCachePortrait = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
}

// 设置状态栏前景色为白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

// 登录点击事件
- (IBAction)loginBtnClick:(id)sender {
    // 登录
    [self loginEvent];
}

// 登录事件
- (void)loginEvent {
    // 向服务端传递请求的参数
    NSString *user_name_ios = @"usernameios";
    NSString *user_pwd_ios = @"userpwdios";
    
    NSDictionary *dicParams = [NSDictionary dictionaryWithObjectsAndKeys:_tfUser.text,user_name_ios,_tfPwd.text,user_pwd_ios, nil];
    
    // AFNetWorking
    AFHTTPSessionManager *manager = [UtilMethod managerHTTP];
    
    // URL_LOGIN_LOCAL    URL_LOGIN_LGJ
    [manager POST:URL_LOGIN_LGJ parameters:dicParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 服务器登录返回状态值
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        // NSLog(@"%@",dic);
        
        // 登录成功
        if ([[dic objectForKey:@"code"] isEqualToString:@"OK"]) {
            // 信息写到 NSUserDefaults 中，实现自动登录
            [_loginUserDefaults setObject:[dic objectForKey:@"code"] forKey:@"loginok"];    // 登录成功标识
            [_loginUserDefaults setObject:[dic objectForKey:@"message"] forKey:@"username"];    // 用户名
            [_loginUserDefaults setObject:[dic objectForKey:@"studydata"] forKey:@"studydata"]; // 学习数据
            [_loginUserDefaults setObject:[dic objectForKey:@"pidportrait"] forKey:@"urlOfPortrait"]; // 头像 URL 路径
            
            // personal 中已经登陆过不能再请求图片，从图片缓存读取
            // 头像图片缓存，正在登陆中加载
            // 用服务器端的 data 关键字为 pid 组合成图片缓存路径
            NSString *filePathCachePortrait = [self.pathCachePortrait stringByAppendingString:[NSString stringWithFormat:@"/%@.png",[dic objectForKey:@"data"]]];
            
            // 请求 NSData 图片数据
            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[dic objectForKey:@"pidportrait"]]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *err) {
                // 将图片写入缓存
                [data writeToFile:filePathCachePortrait atomically:YES];
            }];
            
            // 将缓存的头像图片完整路径存入 NSUserDefaults
            [_loginUserDefaults setObject:filePathCachePortrait forKey:@"pathOfPortrait"]; // 头像缓存路径
            
            // 同步写入，如果没有调用synchronize方法，系统会根据I/O情况不定时刻地保存到文件中。所以如果需要立即写入文件的就必须调用synchronize方法。
            [_loginUserDefaults synchronize];
            
            // 这里返回去后会在 viewWillAppear 方法中刷新界面
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else {
            NSString *message = [dic objectForKey:@"message"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
            [alert show];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ///////////// 在这里可做网络判断
        NSLog(@"request error: %@",error);
    }];
}

// 登录界面返回按钮
- (IBAction)backPersonal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 设置输入框的左侧，用 label 撑出空白
- (void)setLoginLeft {
    // 用户名
    UIView *leftUser = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, self.tfUser.frame.size.height)];
    leftUser.backgroundColor = [UIColor whiteColor];
    _tfUser.leftView = leftUser;
    _tfUser.leftViewMode = UITextFieldViewModeAlways;
    // 密码
    UIView *leftPwd = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, self.tfPwd.bounds.size.height)];
    leftPwd.backgroundColor = [UIColor whiteColor];
    _tfPwd.leftView = leftPwd;
    _tfPwd.leftViewMode = UITextFieldViewModeAlways;
}

// 触摸屏幕空白释放键盘当前响应者
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([_tfUser isFirstResponder]) {
        [_tfUser resignFirstResponder];
    }
    if ([_tfPwd isFirstResponder]) {
        [_tfPwd resignFirstResponder];
    }
}

// 键盘 return 键响应事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (textField.tag == 111) {
        // 第一个 textfield 输入完后点击 返回键 跳转到第二个 textfield
        UITextField *tf = (UITextField *)[self.view viewWithTag:112];
        [tf becomeFirstResponder];
    }
    else if (textField.tag == 112) {
        // 密码输完后点击 return 键 - 登录
        [self loginEvent];
    }
    return YES;
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
