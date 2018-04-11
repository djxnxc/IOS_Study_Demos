//
//  helpModel.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/16.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "helpModel.h"

@implementation helpModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
- (void)initWithDic:(NSDictionary *)dic {
    self.image = dic[@"image"];
    self.title = dic[@"title"];
    self.imageNext = dic[@"imageNext"];

}

@end
