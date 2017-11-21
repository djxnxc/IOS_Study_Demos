//
//  MeModel.h
//  MMPay
//
//  Created by 12 on 2017/11/16.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeModel : NSObject
@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,copy)NSString *titleName;

-(void)fillDataWithArray:(NSArray *)array;
@end
