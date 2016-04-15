//
//  DetailWebViewController.h
//  WeStudy
//
//  Created by Arlenly on 16/3/6.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailWebViewController : UIViewController

// 定义属性变量用于接收参数,这里只需要一个url ---- 此接口在详细页还要进行解析，这里被提取成了网页版
@property (nonatomic,strong) NSString *strURL;

@end
