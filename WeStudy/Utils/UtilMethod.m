//
//  UtilMethod.m
//  WeStudy
//
//  Created by Arlenly on 16/3/4.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import "UtilMethod.h"

@implementation UtilMethod

// AFNetworking 请求会话管理器
+ (AFHTTPSessionManager *)managerHTTP {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return manager;
}


@end
