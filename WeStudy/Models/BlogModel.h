//
//  BlogModel.h
//  WeStudy
//
//  Created by Arlenly on 16/3/5.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogModel : NSObject

@property (nonatomic,assign) NSInteger id_detail;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *body;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *pubDate;
@property (nonatomic,strong) NSString *authorname;
@property (nonatomic,strong) NSString *commentCount;

@end
