//
//  LocationInnerViewController.m
//  WeStudy
//
//  Created by Arlenly on 16/3/2.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import "LocationInnerViewController.h"

// 需要找到相对路径
#import "../../Frameworks/include/IndoorDataManger.h"
#import "../../Frameworks/include/IndoorMapView.h"
#import "../../Frameworks/include/IndoorRouteRequest.h"
#import "../../Frameworks/include/IndoorSearchEngine.h"
#import "../../Frameworks/include/IndoorFloorHBar.h"

@interface LocationInnerViewController () <IndoorMapViewDelegate,IndoorDataMangerProtocol,IndoorFloorHBarDelegate>

@property (nonatomic,strong) IndoorMapView *mapView;

@end

@implementation LocationInnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 导航条返回键文字颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // 设置背景色
    self.view.backgroundColor = TabBarBG;
    // 右侧按钮标题
    self.navigationItem.title = @"室内定位";
    
    // 室内地图显示
    [self showIndoorMap];
    
    [[IndoorDataManger getInstance] downloadMapData:AMAP_KEY_LY buildid:self.spoiid checkNewData:YES];
    [IndoorDataManger getInstance].delegate = self;
}

// 室内地图显示
- (void)showIndoorMap {
    _mapView = [[IndoorMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_mapView];
    
    
}

//- (void)downloadMapdata
-(void)downloadMapData:(NSString *)key buildid:(NSString *)buildid
          checkNewData:( BOOL) checkNewData {
    
}


#pragma mark - IndoorDataMangerProtocol

- (void)downloadMapDataSuccess:(IndoorBuilding *)indoorBuilding {
    
}

- (void)setFloorIndex:(int)floorIndex {
    
}

- (void)downloadMapDataFailed:(NSString *)buildid error:(NSError *)error {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
