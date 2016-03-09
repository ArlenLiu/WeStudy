//
//  FEProvider.h
//
//  Modify  by liu jun on 15-8-17
//  Copyright (c) 2015年 Autonavi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>


typedef enum {
    SCALE_NORMAL = 0,
    SCALE_REACHMAX,
    SCALE_REACHMIN,
} kFEGLScaleState;

typedef struct FEPoint3f
{
    float x, y, z;
} Point3f;

@class  IndoorRouteResponse;

/*!
 *  Poi信息集合类
 */
@interface IndoorPoiInfo:NSObject

/*!
 *  poi 的唯一标示
 */
@property (nonatomic, strong) NSString *poiID;
/*!
 *  poi的type (对应高德室内数据服务编码表)
 */
@property (nonatomic, assign) int type;

/*!
 *  poi的中心x
 */
@property (nonatomic, assign) float x;

/*!
 *  poi的中心y
 */
@property (nonatomic, assign) float y;

/*!
 *  poi的楼层号
 */
@property (nonatomic, assign) float floorNum;

/*!
 *  poi的名称(有中文优先中文,无中文则英文)
 */
@property (nonatomic, strong) NSString *name;

@end

@class IndoorMarkerView;


/*!
 *  Marker对象类
 */
@interface IndoorMarkerView : UIImageView

@property (nonatomic, assign) int handle;
@property (assign) float xCood;
@property (assign) float yCood;
@property (assign) int   floorNum;
@property (nonatomic, strong) IndoorPoiInfo *info;

@end

/*!
 *  楼层信息
 */
@interface IndoorFloorInfo:NSObject

/*!
 *  poi的楼层名称
 */
@property (nonatomic,strong)NSString *namecode;

/*!
 *  poi的楼层号
 */

@property (nonatomic,strong)NSString *sourceid;

/*!
 *  poi的楼层索引
 */
@property (nonatomic,assign)int floorIndex;
@end



/*!
 *  地图代理
 */
@protocol IndoorMapViewDelegate  <NSObject>
@optional
/*!
 *  获取当前点击位置的Poi信息数组。
 *
 *  @param point 点击位置
 *  @param num   楼层号
 *  @param array Poi信息数组
 */
- (void)didTapPoint:(CGPoint)point withFloorNum:(int)num withPoiArray:(NSArray *)array;

/*!
 *  获取当前长按位置的Poi信息数组。
 *
 *  @param point 点击位置
 *  @param num   楼层号
 *  @param array Poi信息数组
 */
- (void)didLongPressPoint:(CGPoint)point withFloorNum:(int)num withPoiArray:(NSArray *)array;

/*!
 *  获取长按后移动到的位置
 *
 *  @param point 移动点位置
 */
- (void)didLongPressMoved:(CGPoint)point;



/*!
 *  scale变化
 *
 *  @param scale 当前scale值
 */
- (void)didScaleChanged:(float)scale withScaleState:(kFEGLScaleState)state;

/*!
 *  回调当前屏幕中心点的经纬度
 *
 *  @param x x经纬度
 *  @param y y经纬度
 */
- (void)currentViewPortLocationX:(float)x withY:(float)y;



/*!
 *  获取Poi点击事件
 *
 *  @param idoorMView Marker对象类
 */
- (void)didTapClick:(IndoorMarkerView *)idoorMView;

@end

/*!
 *  地图对象类
 */
@interface IndoorMapView:UIView

/*!
 *  地图View初始化
 *
 *  @param frame 地图frame
 *
 *  @return 地图对象
 */
- (id)initWithFrame:(CGRect) frame;



/*!
 *  加载室内地图数据
 *
 *  @param strPath 地图数据路径
 *
 *  @return 0成功 -1失败
 */
- (void)LoadDataFile:(NSString *)strPath;



/*!
 *  加载楼层数据(内部自带缓存机制)
 *
 *  @param index    该地图对应的楼层索引(-1,1,2)
 *
 *  @return 0成功 -1失败
 */
- (int)loadFloorWithIndex:(NSString *)index;


/*!
 *  获取楼层信息
 *
 *  @return NSArray 返回楼层数组
 *
 */
- (NSArray *)getFloorInfos;



/*!
 *  关闭引擎
 *
 *  @return 0成功 -1失败
 */
- (int)close;



/*!
 *  设置是否接受触摸信息
 *
 *  @param enable YES接收 NO 拒绝
 */
- (void)setTouchEnable:(BOOL)enable;

/*!
 *  转换pixel到米
 *
 *  @param pixels 像素距离
 *
 *  @return 米
 */
- (float)convertPixelsToMeters:(int)pixels;

/*!
 *  设置经纬度在地图上显示
 *
 *  @param x x坐标(经纬度)
 *  @param y y坐标(经纬度)
 *
 *  @return 0成功 -1失败
 */
- (int)setViewPortToLocationX:(float)x withY:(float)y;



/*!
 *  设置路径数据
 *
 *  @param pathArray 多路径数据
 */
- (void)setPathsData:(IndoorRouteResponse *)indoorRouRes;


/*!
 *  清除路径数据
 *
 *  @param indoorRouteResponse  路径响应返回数据
 */
- (void)removePathsData:(IndoorRouteResponse *)indoorRouteResponse;


/*!
 *  更新地图旋转角度(地图水平旋转)
 *
 *  @param radian 相对当前角度的旋转角
 *
 *  @return 0成功 -1失败
 */
- (int)updateRotationZ:(float) radian;

/*!
 *  地图放大
 *
 */
- (void)zoomIn;

/*!
 *  地图缩小
 *
 */
- (void)zoomOut;

/*!
 *  更新地图缩放值
 *
 *  @param scale 相对当前缩放值的新缩放值
 *
 *  @return 0成功 -1失败
 */
- (int)updateScale:(float) scale;

/*!
 *  更新用户所在位置
 *
 *  @param point 经纬度
 *  @param floorNum 楼层
 *
 *  @return 0成功 -1失败
 */
- (int)updateUserLoc:(CGPoint)point withFloorNum:(int)floorNum;



/*!
 *  显示定位图标
 *
 *  @param enable yes or no
 */
- (int)setUserEnable:(bool) enable;

/*!
 *  获取当前缩放值
 *
 *  @return 当前缩放值
 */
- (float)getScale;

/*!
 *  添加标志点
 *
 *  @param point 该点的的经纬度坐标
 *  @param info  poi的信息
 *  @param name  图片名字
 *
 *  @return marker对象
 */
- (IndoorMarkerView *)addMarker:(CGPoint)point withFloorNum:(int)num withPoiInfo:(IndoorPoiInfo *)info withImageName:(NSString *)name;

/*!
 *  移动标志点
 *
 *  @param marker marker对象
 *  @param x  移动到的经度坐标
 *  @param y  移动到的维度坐标
 *
 *  @return 0成功 -1失败
 */
- (int)moveMarker:(IndoorMarkerView *)marker toXCoord:(float)x yCoord:(float)y;

/*!
 *  移除指定标志点
 *
 *  @param marker 要移除的marker
 *
 *  @return 0成功 -1失败
 */
- (int)removeMarker:(IndoorMarkerView *)marker;


/*!
 *  移除地图标志点数组
 *
 *  @param marker 要移除的marker
 *
 *  @return 0成功 -1失败
 */

- (int)removeMarkers;


/*!
 *  获取室内地图版本
 *
 */
- (NSString *)getIndoorMapDataVersion;

/*!
 *  根据文字生成气泡
 *
 */

- (UIImageView*)generatePromptBubble:(NSString*)pstrText;

//是否显示比例尺
@property (nonatomic, assign)BOOL isPlottingScale;

//是否显示罗盘
@property (nonatomic, assign)BOOL iscompassView;

@property (nonatomic, assign) id <IndoorMapViewDelegate>   delegate;


@end