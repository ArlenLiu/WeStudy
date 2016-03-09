//
//  IndoorDataManger.h
//  indoorMapDemo
//
//  Created by liujun on 15/9/21.
//  Copyright (c) 2015年 autonavi. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  Building信息
 */
@interface IndoorBuilding:NSObject

/*!
 *  Building的楼层id
 */
@property (nonatomic,strong)NSString *buildid;

/*!
 *  Building路径
 */
@property (nonatomic,strong)NSString *path;

/*!
 *  Building的版本号
 */
@property (nonatomic,assign)int version;

@end


@protocol IndoorDataMangerProtocol <NSObject>

/*!
 *  下载地图数据成功
 *
 */
- (void)downloadMapDataSuccess:(IndoorBuilding *)indoorBuilding;

/*!
 *  下载地图数据失败
 *
 */
- (void)downloadMapDataFailed:(NSString *)buildid
                        error:(NSError *)error;

@end


@interface IndoorDataManger : NSObject

+(IndoorDataManger *)getInstance;
+(void)releaseInstance;


@property (nonatomic, assign) id <IndoorDataMangerProtocol> delegate;

/*!
 *  下载室内地图数据
 *
 *  @param  key  在访问请求之前需要先绑定key.
 */
- (void)downloadMapData:(NSString *)key
                buildid:(NSString *)buildid
           checkNewData:(BOOL)checkNewData;

/*!
 *  清除指定poiid数据
 *
 *  @param poiid
 */
- (void)clearDataCache:(NSString *)buildid;


@end
