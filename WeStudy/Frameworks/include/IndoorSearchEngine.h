//
//  IndoorSearchEngine.h
//  IndoorMapLib
//
//  Created by liujun on 15/8/31.
//  Copyright (c) 2015年 autonavi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndoorEn:NSObject

@property(nonatomic,assign)int typeCode; //AABBCC: AA大类别，BB:中类, CC: 子类别定义
@property(nonatomic,assign)int shopType;
@property(nonatomic,assign)int floorIndex;//楼层 Index

//中心点坐标
@property(nonatomic,assign)double centerX;
@property(nonatomic,assign)double CenterY;
//名称
@property(nonatomic,strong)NSString  *name_dp;
//唯一标示
@property(nonatomic,strong)NSString  *sid;
//高德POI id
@property(nonatomic,strong)NSString  *pid;
@end


@class IndoorBuilding;

@interface IndoorSearchEngine : NSObject

/*!
 *  初始化引擎
 */
- (void)InitSearchEngine:(NSString *)indoorPath;

/*!
 *  释放引擎
 */
- (void)FreeSearchEngine;

/*!
 *  获取引擎版本
 */
- (NSString *)getEngineVersion;

/*!
 *   按照关键字搜索
 *
 *  @param key         关键字
 *  @param floorID     楼层ID 默认0：遍历全部数据
 *  @param fx (可选)    经度
 *  @param fx (可选)    纬度
 *  @param nlimit(可选) 返回最多结果数量
 *  返回结果:数组
 */
- (NSArray *)searchByKey:(NSString *)key
                 floorID:(int)floorID
                      fx:(float)fx
                      fy:(float)fy
                  nlimit:(int)nlimit;


/*!
 *   按照类型搜索
 *
 *  @param type        需要搜索的类型
 *  @param floorID     楼层ID 默认0：遍历全部数据
 *  @param fx (可选)    经度
 *  @param fx (可选)    纬度
 *  @param nlimit(可选) 返回最多结果数量
 
 *  返回结果:数组
 */
- (NSArray *)searchByType:(int)type
                  floorID:(int)floorID
                       fx:(float)fx
                       fy:(float)fy
                   nlimit:(int)nlimit;


/*!
 *   获取室内类型列表
 *
 *  返回结果:数组     //NSNumber -->int
 */
- (NSArray *) getTypeList;


/*!
 *   通过ID获取室内类型名称
 *
 *   参数：返回名称
 */
- (NSString *) getNameByid:(int)idType;

@end
