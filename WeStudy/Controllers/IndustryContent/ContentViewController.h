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

// collection 传过来的页码
- (void)showPageIndex:(NSUInteger)pageIndex;


@end
