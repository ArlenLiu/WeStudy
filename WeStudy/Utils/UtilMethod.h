//
//  UtilMethod.h
//  WeStudy
//
//  Created by Arlenly on 16/3/4.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface UtilMethod : NSObject

@property (nonatomic,strong) AFHTTPSessionManager *manager;

// AFNetworking 请求会话管理器
+ (AFHTTPSessionManager *)managerHTTP;


@end
