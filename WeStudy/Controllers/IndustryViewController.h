//
//  IndustryViewController.h
//  WeStudy
//
//  Created by qianfeng on 16/2/19.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import "RootViewController.h"

@interface IndustryViewController : RootViewController

// block 接收传输过来的页面 indexPath.row
- (void)receiveBlock:(void(^)(NSUInteger url))block;

@end
