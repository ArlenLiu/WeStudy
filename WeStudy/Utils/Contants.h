//
//  Contants.h
//  WeStudy
//
//  Created by Arlenly on 16/2/26.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import <Foundation/Foundation.h>

// 登陆界面 输入框 view 边框圆角直径
#define LOGIN_CORNER 3

#define H_TOP_INDUSTRY 40

// bounds 宽、高
#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height

// UITabBar 高度
#define HEIGHT_TABBAR self.tabBarController.tabBar.frame.size.height

// 高德地图 KEY
extern NSString *const AMAP_KEY;

// 本地登录接口
extern NSString *const URL_LOGIN_LOCAL;
// 互联网登录接口
extern NSString *const URL_LOGIN_LGJ;

// OSChina开源中国接口：
// 综合——资讯接口：http:
extern NSString * const ZH_INFO;

// 综合——热点接口：
extern NSString * const ZH_HOT;

// 综合——博客接口：
extern NSString * const ZH_BLOG;

// 综合——推荐接口：
extern NSString * const ZH_RECOMMEND;

// 动弹——最新动弹接口：
extern NSString * const DT_NEW;

// 动弹——热门动弹接口：
extern NSString * const DT_HOT;

// 动弹——我的动弹接口（？？？已登录状态下）：
extern NSString * const DT_MY;

// 登录状态 成功与否
typedef NS_ENUM(NSInteger,LogStatus){
    LogoutStatu = 0,
    LoginStatu
};


@interface Contants : NSObject

@end
