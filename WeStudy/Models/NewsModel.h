//
//  NewsModel.h
//  WeStudy
//
//  Created by Arlenly on 16/3/5.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *body;
@property (nonatomic,strong) NSString *commentCount;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *pubDate;

@end
