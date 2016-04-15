//
//  FrendsViewController.m
//  WeStudy
//
//  Created by qianfeng on 16/2/19.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import "FrendsViewController.h"
#import <AddressBook/AddressBook.h>
#import "FriendDetailViewController.h"
//#import "AddressBookModel.h"
//#import <AddressBookUI/AddressBookUI.h>

@interface FrendsViewController () <UITableViewDataSource,UITableViewDelegate>
{
    // 数据源
    NSMutableArray *arrDataSource;
    NSMutableArray *arrPhone;
}

@property (weak, nonatomic) IBOutlet UITableView *tbvAB;


@end

@implementation FrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tbvAB.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:243/255.0 alpha:1.0];
    self.tbvAB.dataSource = self;
    self.tbvAB.delegate = self;
    
    [_tbvAB registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    // 初始化数据源
    arrDataSource = [[NSMutableArray alloc] init];
    arrPhone = [[NSMutableArray alloc] init];
    _tbvAB.separatorColor = BlueDefault;
    // 读取手机通讯录
    [self readAddressBook];
    
}

- (void)readAddressBook {
    // 根据权限生成通讯录
    ABAddressBookRef *addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
//    ABAddressBookRef *addressBook = ABAddressBookCreate();
    
    // 取得授权状态
    ABAuthorizationStatus *authStatus = ABAddressBookGetAuthorizationStatus();
    
    if (authStatus == kABAuthorizationStatusNotDetermined
        ) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            
            CFErrorRef *error1 = NULL;
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error1);
            [self copyAddressBook:addressBook];
        });
    }
    else if (authStatus == kABAuthorizationStatusAuthorized) {
        CFErrorRef *error = NULL;
        ABAddressBookRef *addressBook = ABAddressBookCreateWithOptions(NULL, error);
        [self copyAddressBook:addressBook];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面 ?
            // [hud turnToError:@"没有获取通讯录权限"];
        });
    }
}

// 循环获取每个联系人的信息
- (void)copyAddressBook:(ABAddressBookRef)addressBook {
    CFIndex numberOfPerple = ABAddressBookGetPersonCount(addressBook);
    
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    for (int i = 1; i < numberOfPerple; i ++) {
        ABRecordRef person = CFArrayGetValueAtIndex(people, i);
        
        // ARC下OC对象和CF对象之间的桥接(bridge)
        NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
        
        if (lastName != nil || firstName != nil) {
            if (lastName == nil) {
                [arrDataSource addObject:[NSString stringWithFormat:@"%@",firstName]];
            }
            else if (firstName == nil) {
                [arrDataSource addObject:[NSString stringWithFormat:@"%@",lastName]];
            }
            else {
                [arrDataSource addObject:[NSString stringWithFormat:@"%@%@",lastName,firstName]];
            }
        }
        
        // 读取 firstName 拼音音标 -- 右侧拼音首字母导航
//        NSString *firstNamePhonetic = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty);
        
        // 获取电话 多值
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        
        NSMutableArray *multiPhone = [[NSMutableArray alloc] init];
        
        for (int j = 0; j < ABMultiValueGetCount(phone); j ++) {
            // 获取电话 label - 号码类型？
//            NSString *personPhoneLabel = (__bridge NSString *)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, j));
            // 获取该 label 下的电话值
            NSString *personPhone = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, j);
            
            // 某些人有多个电话号码，用数组保存
            [multiPhone addObject:personPhone];
        }
        // 每个人的电话号码
        [arrPhone addObject:multiPhone];
    }
}


#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageView.layer.cornerRadius = cell.imageView.frame.size.height / 2;
    cell.imageView.image = [UIImage imageNamed:@"contact"];
    cell.imageView.clipsToBounds = YES;
    cell.textLabel.text = arrDataSource[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"邀请加入WeStudy";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    [self.tbvAB reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FriendDetailViewController *friend = [story instantiateViewControllerWithIdentifier:@"frienddetail"];
    [friend setValue:arrPhone[indexPath.row] forKey:@"phone"];
    // 跳转到联系人详情页
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:friend animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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
