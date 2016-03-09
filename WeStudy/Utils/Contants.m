//
//  Contants.m
//  WeStudy
//
//  Created by Arlenly on 16/2/26.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import "Contants.h"

// 极光推送 key
NSString * const JPUSH_KEY = @"607a017e0a66ffbdf79e782e";

// 高德地图 KEY com.arlenly.WeStudy
NSString * const AMAP_KEY_LY = @"fd144f4d4f1f16445db2cd8c38aa661f";
// com.arlen.WeStudy
NSString * const AMAP_KEY = @"ef8db51df90f01e69130dad8cfe36649";

// 登录接口
NSString * const URL_LOGIN_LOCAL = @"http://localhost/westudy/loginios.php";
NSString * const URL_LOGIN_LGJ = @"http://www.liugangjian.com/loginios.php";

// OSChina开源中国接口：
// 综合 news_list 网页html
NSString * const NEWS_HTML = @"http://www.oschina.net/news/";
// 综合 news_list 根接口，具体文章在后面传参 id=
NSString * const NEWS_DETAIL = @"http://www.oschina.net/action/api/news_detail";

// 综合 blog_list 根接口，具体文章在后面传参 id=
NSString * const BLOG_DETAIL = @"http://www.oschina.net/action/api/blog_detail";

// 综合——资讯接口：
NSString * const ZH_INFO = @"http://www.oschina.net/action/api/news_list?catalog=1&pageIndex=0&pageSize=20";

// 综合——热点接口：
NSString * const ZH_HOT = @"http://www.oschina.net/action/api/news_list?show=week";

// 综合——博客接口：
NSString * const ZH_BLOG = @"http://www.oschina.net/action/api/blog_list?type=latest&pageIndex=0&pageSize=20";

// 综合——推荐接口：
NSString * const ZH_RECOMMEND = @"http://www.oschina.net/action/api/blog_list?type=recommend&pageIndex=0&pageSize=20";

// 动弹——最新动弹接口：
NSString * const DT_NEW = @"http://www.oschina.net/action/api/tweet_list?uid=0&pageIndex=0&pageSize=20&clientType=android";

// 动弹——热门动弹接口：
NSString * const DT_HOT = @"http://www.oschina.net/action/api/tweet_list?uid=-1&pageIndex=0&pageSize=20&clientType=android";

// 动弹——我的动弹接口（？？？已登录状态下）：
NSString * const DT_MY = @"http://www.oschina.net/action/api/tweet_list?uid=1390647&pageIndex=0&pageSize=20&clientType=android";



@implementation Contants

@end
