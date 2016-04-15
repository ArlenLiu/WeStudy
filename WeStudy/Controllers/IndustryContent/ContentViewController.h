//
//  ContentViewController.h
//  WeStudy
//
//  Created by Arlenly on 16/3/4.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataXMLNode.h"

@interface ContentViewController : UIViewController

// XML 解析
@property (nonatomic,strong) GDataXMLDocument *xmlDoc;
@property (nonatomic,strong) GDataXMLElement *rootElement;
@property (nonatomic,strong) NSArray *arrForNewsList;
@property (nonatomic,strong) GDataXMLElement *newsEle;
@property (nonatomic,strong) NSArray *arrForNews;
@property (nonatomic,strong) GDataXMLElement *news;
@property (nonatomic,strong) NSArray *arrTitle;
@property (nonatomic,strong) GDataXMLNode *nodeTitle;
@property (nonatomic,strong) NSArray *arrBody;
@property (nonatomic,strong) GDataXMLNode *nodeBody;
@property (nonatomic,strong) NSArray *arrAuthor;
@property (nonatomic,strong) GDataXMLNode *nodeAuthor;
@property (nonatomic,strong) NSArray *arrPubDate;
@property (nonatomic,strong) GDataXMLNode *nodePubDate;
@property (nonatomic,strong) NSArray *arrID;
@property (nonatomic,strong) GDataXMLNode *nodeID;
@property (nonatomic,strong) NSArray *arrURLDetail;
@property (nonatomic,strong) GDataXMLNode *nodeURL;

// 在此页面要执行跳转到详细页面时，直接 self.navigationcontroller push...是不行的，因为该页面不是直接在navigationcontroller下，所以要获取到该页面所在的框架视图控制器，由它进行跳转。
// **有三种方式：直接定义属性变量指向框架视图控制器；使用代理协议；使用block; */
// 方式一：直接定义属性变量指向其所在的框架视图控制器，需要对该页面所在的cell进行修改
@property (nonatomic,strong) UIViewController *myViewController;

// collection 传过来的页码
- (void)showPageIndex:(NSUInteger)pageIndex;


@end
