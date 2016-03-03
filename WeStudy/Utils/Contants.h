//
//  Contants.h
//  WeStudy
//
//  Created by Arlenly on 16/2/26.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import <Foundation/Foundation.h>

// 常量在这里定义

// 登陆界面边框圆角直径
#define LOGIN_CORNER 3

// bounds 宽、高
#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height

// UITabBar 高度
#define HEIGHT_TABBAR self.tabBarController.tabBar.frame.size.height


// 本地网络请求 -- 登录接口
//#define URL_LOCALAPI_LOGIN @"http://localhost/westudy/Api_user/user.json"
// 互联网请求 -- 网页登录接口 -- 执行 http://www.liugangjian.com/login.php 刷新数据
//#define URL_LGJAPI_LOGIN @"http://www.liugangjian.com/Api_user/user.json"


// 本地登录接口
#define URL_LOGIN_LOCAL @"http://localhost/westudy/loginios.php"

// 互联网登录接口
#define URL_LOGIN_LGJ @"http://www.liugangjian.com/loginios.php"


// 高德地图 KEY
#define AMAP_KEY @"fd144f4d4f1f16445db2cd8c38aa661f"



@interface Contants : NSObject

@end
