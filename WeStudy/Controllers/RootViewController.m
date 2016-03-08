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
#import "ShareViewController.h"
#import "PersonalViewController.h"
//#import "LeftDrawerViewController.h"
//#import "PopMenu.h"

@interface RootViewController ()
{
    // 左侧抽屉是否显示，显示为 YES
    BOOL leftDrawerBool;
    
}

/** 弹出菜单栏*/
//@property (nonatomic, strong) PopMenu *popMenu;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置第一次进入时显示的分栏项 -- 0行业，1动态，2中间button，3学友，4个人中心
    self.tabBarController.selectedIndex = 4;
    
    [self customTabBar];
    [self leftNavi];
    
    leftDrawerBool = NO;
    
}

- (void)customTabBar {
    self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.translucent = NO;
    self.tabBarController.tabBar.barTintColor = BlueDefault;
    
    // 分栏正中间按钮
    UIButton *centerBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH / 2 - HEIGHT_TABBAR / 2, 0, HEIGHT_TABBAR, HEIGHT_TABBAR)];
    [centerBtn setBackgroundImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    [self.tabBarController.tabBar addSubview:centerBtn];
    [centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //创建可变数组接收菜单按钮
//    NSMutableArray *items = [[NSMutableArray alloc] init];
//    
//    //创建菜单按钮
//    MenuItem *menuItem = [MenuItem itemWithTitle:@"Flickr" iconName:@"music"];
//    [items addObject:menuItem];
//    
//    menuItem = [MenuItem itemWithTitle:@"Google+" iconName:@"post_type_bubble_googleplus" glowColor:[UIColor colorWithRed:0.840 green:0.264 blue:0.208 alpha:0.800]];
//    [items addObject:menuItem];
//    
//    menuItem = [MenuItem itemWithTitle:@"Instagram" iconName:@"post_type_bubble_instagram" glowColor:[UIColor colorWithRed:0.232 green:0.442 blue:0.687 alpha:0.800]];
//    [items addObject:menuItem];
//    
//    menuItem = [MenuItem itemWithTitle:@"Twitter" iconName:@"post_type_bubble_twitter" glowColor:[UIColor colorWithRed:0.000 green:0.509 blue:0.687 alpha:0.800]];
//    [items addObject:menuItem];
//    
//    menuItem = [MenuItem itemWithTitle:@"Youtube" iconName:@"post_type_bubble_youtube" glowColor:[UIColor colorWithRed:0.687 green:0.164 blue:0.246 alpha:0.800]];
//    [items addObject:menuItem];
//    
//    menuItem = [MenuItem itemWithTitle:@"Facebook" iconName:@"post_type_bubble_facebook" glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.800]];
//    [items addObject:menuItem];
//    
//    //加载popMenu
//    if (!_popMenu) {
//        _popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
//        _popMenu.menuAnimationType = kPopMenuAnimationTypeSina;
//    }
//    
//    if (_popMenu.isShowed) {
//        return;
//    }
//    
//#pragma mark - 点击图标选择操作
//    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
//        
//        //进行点击图片相关操作
//        NSLog(@"%@",selectedItem.title);
//        
//    };
//    
//    //显示到界面
//    [_popMenu showMenuAtView:self.view];
}
/*
UIModalPresentationFullScreen = 0,
UIModalPresentationPageSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
UIModalPresentationFormSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
UIModalPresentationCurrentContext NS_ENUM_AVAILABLE_IOS(3_2),
UIModalPresentationCustom NS_ENUM_AVAILABLE_IOS(7_0),
UIModalPresentationOverFullScreen NS_ENUM_AVAILABLE_IOS(8_0),
UIModalPresentationOverCurrentContext NS_ENUM_AVAILABLE_IOS(8_0),
UIModalPresentationPopover NS_ENUM_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED,
UIModalPresentationNone NS_ENUM_AVAILABLE_IOS(7_0) = -1,
*/

- (void)centerBtnClick:(UIButton *)btn {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ShareViewController *share = [story instantiateViewControllerWithIdentifier:@"course"];
    self.modalPresentationStyle = UIModalPresentationPopover;
    [self.tabBarController presentViewController:share animated:YES completion:nil];
    
}

- (void)leftNavi {
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    // 导航条背景色
    self.navigationController.navigationBar.barTintColor = BlueDefault;
    
    // 抽屉按钮
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(leftClick)];
    leftBarItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
}

// 左侧书签按钮点击事件 -- 抽屉效果
- (void)leftClick {
    if (leftDrawerBool == NO) {
        [UIView animateWithDuration:0.5 animations:^{
            CGPoint pt = self.tabBarController.view.center;
            pt.x += WIDTH_DRAWER;
            self.tabBarController.view.center = pt;
            leftDrawerBool = YES;
        }];
    }
    else {
        [UIView animateWithDuration:0.5 animations:^{
            CGPoint pt = self.tabBarController.view.center;
            pt.x -= WIDTH_DRAWER;
            self.tabBarController.view.center = pt;
            leftDrawerBool = NO;
        }];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 获取添加到 window 上的抽屉
    UIView *uvLeft = [self.view.window viewWithTag:1000];
    if (uvLeft == nil) {
        // 还没有添加过抽屉视图才添加
        UIView *uvAdd = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_DRAWER, HEIGHT + 64 + 49)];
        uvAdd.backgroundColor = BlueDefaultBackground;
        uvAdd.tag = 1000;
        [self.view.window insertSubview:uvAdd atIndex:0];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, WIDTH_DRAWER, 50)];
        [btn setTitle:@"学吧" forState:UIControlStateNormal];
        [btn setBackgroundColor:BlueDefault];
        [uvAdd addSubview:btn];
        [btn addTarget:self action:@selector(btnInDrawerClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)btnInDrawerClick:(UIButton *)btn {
    NSLog(@"Left Drawer Clicking");
}

// 点击屏幕 抽屉收回 -- bug ?!
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (leftDrawerBool == YES) {
        [UIView animateWithDuration:0.5 animations:^{
            CGPoint pt = self.tabBarController.view.center;
            pt.x -= WIDTH_DRAWER;
            self.tabBarController.view.center = pt;
            leftDrawerBool = NO;
        }];
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
