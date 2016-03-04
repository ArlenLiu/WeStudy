//
//  IndustryCollectionViewCell.h
//  WeStudy
//
//  Created by Arlenly on 16/3/4.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"

@interface IndustryCollectionViewCell : UICollectionViewCell

// 可供外部访问的内容视图控制器，在其所在的 cell 数据绑定时，设置其所在的框架试图控制器对象
@property (nonatomic,strong) ContentViewController *contentVC;




- (instancetype)initWithFrame:(CGRect)frame;

@end
