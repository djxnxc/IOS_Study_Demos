//
//  UIViewControllerFactory.m
//  MyVegetable
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "UIViewControllerFactory.h"

@implementation UIViewControllerFactory
+(id)getViewController:(NSString *)ident
{
    if ([ident isEqualToString:ACCOUNT_UI_TIXIAN]) {//用户信息填写
        UIStoryboard* story=[UIStoryboard storyboardWithName:@"customBoard" bundle:nil];
        return [story instantiateViewControllerWithIdentifier:ACCOUNT_UI_TIXIAN];
    }
    if ([ident isEqualToString:HTML5_WebView]) {
        UIStoryboard* story=[UIStoryboard storyboardWithName:@"customBoard" bundle:nil];
        return [story instantiateViewControllerWithIdentifier:HTML5_WebView];
    }
    if ([ident isEqualToString:Trad_Password]) {
        UIStoryboard* story=[UIStoryboard storyboardWithName:@"customBoard" bundle:nil];
        return [story instantiateViewControllerWithIdentifier:Trad_Password];
    }
    if ([ident isEqualToString:P6_HomePage]) {
        UIStoryboard* story=[UIStoryboard storyboardWithName:@"customBoard" bundle:nil];
        return [story instantiateViewControllerWithIdentifier:P6_HomePage];
    }
    return nil;
}
@end
