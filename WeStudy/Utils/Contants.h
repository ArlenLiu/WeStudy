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

// OSChina开源中国接口：
// 综合——资讯接口：http:
#define ZH_INFO @"www.oschina.net/action/api/news_list?catalog=1&pageIndex=0&pageSize=20"

// 综合——热点接口：
#define ZH_HOT @"http://www.oschina.net/action/api/news_list?show=week"

// 综合——博客接口：
#define ZH_BLOG @"http://www.oschina.net/action/api/blog_list?type=latest&pageIndex=0&pageSize=20"

// 综合——推荐接口：
#define ZH_RECOMMEND @"http://www.oschina.net/action/api/blog_list?type=recommend&pageIndex=0&pageSize=20"


// 动弹——最新动弹接口：
#define DT_NEW @"http://www.oschina.net/action/api/tweet_list?uid=0&pageIndex=0&pageSize=20&clientType=android"

// 动弹——热门动弹接口：
#define DT_HOT @"http://www.oschina.net/action/api/tweet_list?uid=-1&pageIndex=0&pageSize=20&clientType=android"

// 动弹——我的动弹接口（？？？已登录状态下）：
#define DT_MY @"http://www.oschina.net/action/api/tweet_list?uid=1390647&pageIndex=0&pageSize=20&clientType=android"




@interface Contants : NSObject

@end
