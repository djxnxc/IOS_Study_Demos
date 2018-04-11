//
//  AccountDQModel.h
//  MyVegetable
//
//  Created by mythkiven on 15/11/24.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountJYModel : NSObject

@property (copy, nonatomic) NSString *type;

@property (copy, nonatomic) NSString *leftUp;
@property (copy, nonatomic) NSString *leftDOwn;

@property (copy, nonatomic) NSString *rightUp;
@property (copy, nonatomic) NSString *rightDown;
@property (nonatomic,assign) int status;

- (id)initWithDic:(NSDictionary *)dic;
@end
