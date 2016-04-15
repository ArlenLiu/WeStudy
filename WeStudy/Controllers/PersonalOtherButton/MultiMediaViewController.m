//
//  MultiMediaViewController.m
//  WeStudy
//
//  Created by Arlenly on 16/3/2.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import "MultiMediaViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MusicListModel.h"

@interface MultiMediaViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arrDataSource;
}

@end

@implementation MultiMediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 导航条返回键文字颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // 设置背景色
    self.view.backgroundColor = TabBarBG;
    // 右侧按钮标题
    self.navigationItem.title = @"多媒体";
    
    //
    arrDataSource = [[NSMutableArray alloc] init];
    
    // 扫描本地音乐
    [self queryAllMusic];
    
    // tableview
    UITableView *tbv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    [self.view addSubview:tbv];
    tbv.separatorColor = [UIColor redColor];
    tbv.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tbv.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tbv.dataSource = self;
    tbv.delegate = self;
    [tbv registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

// 扫描本地音乐
- (void)queryAllMusic {
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    NSArray *itemsFromGenericQuery = [everything items];
    
    for (MPMediaItem *song in itemsFromGenericQuery) {
        NSString *songTitle = [song valueForProperty: MPMediaItemPropertyTitle];
        NSString *songArtist = [song valueForProperty:MPMediaItemPropertyArtist];
        
        MusicListModel *music = [[MusicListModel alloc] init];
        music.title = songTitle;
        music.artist = songArtist;
        [arrDataSource addObject:music];
    }
}

#pragma mark uitableviewdatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    MusicListModel *music = arrDataSource[indexPath.row];
    cell.textLabel.text = music.title;
    cell.detailTextLabel.text = music.artist;;  // 不显示？
    cell.imageView.image = [UIImage imageNamed:@"music"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
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
