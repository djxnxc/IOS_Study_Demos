//
//  User.h
//  归档和解档
//
//  Created by 邓家祥 on 2018/6/26.
//  Copyright © 2018年 djx. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Lines;
@interface User :NSObject

@property (nonatomic, strong) NSArray<Lines *> *lines;

@end
@interface Lines :NSObject

@property (nonatomic, copy) NSString *lineCode;

@property (nonatomic, copy) NSString *lineName;

@end
