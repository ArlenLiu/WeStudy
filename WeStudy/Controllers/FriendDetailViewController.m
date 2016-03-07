
//
//  FriendDetailViewController.m
//  WeStudy
//
//  Created by Arlenly on 16/3/7.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import "FriendDetailViewController.h"
#import "Contants.h"

@interface FriendDetailViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arrDataSource;
}

@property (weak, nonatomic) IBOutlet UITableView *tbvPhone;

@end

@implementation FriendDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 导航条返回键文字颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // 设置背景色
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:243/255.0 alpha:1.0];
    // 右侧按钮标题
    self.navigationItem.title = @"电话号码";
    
    self.tbvPhone.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:243/255.0 alpha:1.0];
    
    // 初始胡数据源
    arrDataSource = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _phone.count; i ++) {
        [arrDataSource addObject:_phone[i]];
    }
    
    _tbvPhone.dataSource = self;
    _tbvPhone.delegate = self;
    [_tbvPhone registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = arrDataSource[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"contactdetail"];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"邀请好友";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    [self.tbvPhone reloadData];
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
