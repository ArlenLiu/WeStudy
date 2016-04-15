//  Created by auto on 15/8/31.
//  Copyright (c) 2015年 autonavi. All rights reserved.


#import <UIKit/UIKit.h>

@protocol IndoorFloorHBarDelegate <NSObject>

-(void)setFloorIndex:(int)floorIndex;

@end



@interface IndoorFloorHBar : UIView

@property( nonatomic, assign ) id<IndoorFloorHBarDelegate> delegate;

- (void)setData:(NSArray*)floorNames startIndex:(int)index;
- (void)gotoPageByIndex:(int)index;
- (void)gotoPageByName:(NSString*)floorName;

- (void)scrollUnEnable;

@end
