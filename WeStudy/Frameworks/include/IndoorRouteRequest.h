//
//  IndoorRouteRequest.h
//  IndoorMapLib
//
//  Created by liujun on 15/9/1.
//  Copyright (c) 2015年 autonavi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointD : NSObject
@property(nonatomic,strong)NSString *lon;
@property(nonatomic,strong)NSString *lat;
@end


@interface IndoorRouteRequest : NSObject
@property(nonatomic,strong)NSString *buildID;
@property(nonatomic,strong)PointD   *startPointD;
@property(nonatomic,strong)PointD   *endPointD;
@property(nonatomic,strong)NSString *startFloorNo;
@property(nonatomic,strong)NSString *endFloorNo;
@end


@interface IndoorFullPath : NSObject
//  楼层号
@property(nonatomic,strong)NSString *floorNumber;

//  楼层名字
@property(nonatomic,strong)NSString *floorName;

//  规划行为    如走电梯还是楼梯
@property(nonatomic,strong)NSString *sAction;
@property(nonatomic,strong)NSString *eAction;

//  建筑 ID
@property(nonatomic,strong)NSString *buildID;

//  本楼层规划距离
@property(nonatomic,assign)int segDistance;

//  路径经纬度 //存储PointD
@property(nonatomic,strong)NSArray *pathPointLst;

@end

@interface IndoorRouteResponse : NSObject

//  求路结果状态
@property(nonatomic,strong)NSString *responseStatus;

//  建筑名称
@property(nonatomic,strong)NSString *buildingName;

//  建筑ID
@property(nonatomic,strong)NSString *buildID;

//  规划路径总长度(单位: 米)
@property(nonatomic,assign)int  distance;

//  //存储IndoorFullPath
@property(nonatomic,strong)NSArray *fullPath;

@end


@protocol IndoorRouteRequestDelegate <NSObject>


// 0	 成功
// 3	 请求起点不合法
// 4	 请求终点不合法
// 6	 请求不合法，起终点不在同一建筑物
// 7	 服务器错误（数据错误或者是权限问题）
// 8	 起点和终点相同
// 9	 参数传入不合法
// 10 没有找到空间索引文件
// 11 路网数据读取出现问题
// -1 失败
// -2 请检查网络后重试

@optional
/*!
 当请求发生错误时，会调用代理的此方法.
 @param request 发生错误的请求.
 @param error   返回的错误.
 */
- (void)searchRequest:(id)request didFailWithError:(NSError *)error;

/*!
 @brief 路算回调函数
 @param request 发起查询的查询选项
 @param response 查询结果
 */
- (void)onRouteRequestDone:(IndoorRouteRequest *)request response:(IndoorRouteResponse *)response;

@end

@interface IndoorRouteCalc : NSObject

@property(nonatomic,weak)id<IndoorRouteRequestDelegate> deleteRoute;


/*
 *  在访问请求之前需要先绑定key.
 */
- (void)IndoorRouteRequest:(IndoorRouteRequest *)request
                       key:(NSString *)key;

@end



