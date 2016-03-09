//
//  AddressBookModel.h
//  WeStudy
//
//  Created by Arlenly on 16/3/7.
//  Copyright © 2016年 Arlenly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBookModel : NSObject

@property (nonatomic,strong) NSString * name;   // firstname / lastname
@property (nonatomic,strong) NSArray * tel;
@property (nonatomic,strong) NSString * pic;

@end
