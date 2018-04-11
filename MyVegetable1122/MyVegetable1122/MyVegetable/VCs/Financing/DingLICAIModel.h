//
//  DingLICAIModel.h
//  MyVegetable
//
//  Created by mythkiven on 15/11/19.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BuyModel;
@interface DingLICAIModel : NSObject
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *smallTitle;
@property (nonatomic, assign) int ID;
@property (nonatomic, strong) BuyModel *model;
@end
