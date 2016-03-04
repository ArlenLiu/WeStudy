//
//  IndustryCollectionViewCell.m
//  WeStudy
//
//  Created by Arlenly on 16/3/4.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import "IndustryCollectionViewCell.h"

@implementation IndustryCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    // industryVC 中的 cell 为当前文件，每一个 cell 又复用 contentVC
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _contentVC = [story instantiateViewControllerWithIdentifier:@"content"];
    [self.contentView addSubview:_contentVC.view];
    
    return self;
}

@end
