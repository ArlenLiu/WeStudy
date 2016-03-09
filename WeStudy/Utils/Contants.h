//
//  Contants.h
//  WeStudy
//
//  Created by Arlenly on 16/2/26.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 登陆界面 输入框 view 边框圆角直径
#define LOGIN_CORNER 3

#define H_TOP_INDUSTRY 40

// bounds 宽、高
#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height

// 抽屉宽度
#define WIDTH_DRAWER 200

// APP 默认 蓝色值
#define BlueDefault [UIColor colorWithRed:77/255.0 green:132/255.0 blue:241/255.0 alpha:1.0]
// APP 背景 蓝色值
#define BlueDefaultBackground [UIColor colorWithRed:62/255.0 green:107/255.0 blue:187/255.0 alpha:1.0]

// UITabBar 高度
#define HEIGHT_TABBAR self.tabBarController.tabBar.frame.size.height

// 极光推送 key
extern NSString * const JPUSH_KEY;

// 高德室内地图 KEY 支持 iOS 6.0 及以上系统。
extern NSString * const AMAP_KEY_LY;
extern NSString * const AMAP_KEY;

// 本地登录接口
extern NSString * const URL_LOGIN_LOCAL;
// 互联网登录接口
extern NSString * const URL_LOGIN_LGJ;

// OSChina开源中国接口：
// HTML
extern NSString * const NEWS_HTML;
// 综合 news_list 详细页接口
extern NSString * const NEWS_DETAIL;

// 综合 blog_list 根接口
extern NSString * const BLOG_DETAIL;

// 综合——资讯接口：
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
