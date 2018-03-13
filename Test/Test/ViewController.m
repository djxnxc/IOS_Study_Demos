//
//  ViewController.m
//  Test
//
//  Created by 12 on 2018/3/13.
//  Copyright © 2018年 DJX. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"a1");
        
    });
    NSLog(@"a2");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"a3");
        
    });
    
    NSMutableArray *titleArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"3",@"12",@"12",@"1",@"2",@"3",@"4",@"3",@"12",@"12",@"1",@"2",@"3",@"4",@"3",@"12",@"12",@"1",@"2",@"3",@"4",@"3",@"12",@"12",@"1",@"2",@"3",@"4",@"3",@"12",@"12", nil];
    for (int i = 0; i<titleArray.count-1; i++) {
        for (int j=i+1; j<titleArray.count; j++) {
            if ([titleArray[i] isEqualToString:titleArray[j]]) {
                [titleArray removeObjectAtIndex:j];
                j--;
            }
        }
    }
    NSLog(@"%@",titleArray);
//    [self sort:[NSMutableString stringWithFormat:@"aabcad"]];
//    [self removeRepeat:@"abaabbcd"];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)sort:(NSMutableString *)str{
    NSMutableString * str1 = [[NSMutableString alloc] initWithFormat:@"aabcad"];
    for (int i = 0; i < str1.length - 1; i++) {
        for (int j = i + 1; j < str1.length ; j++) {
            unsigned char a = [str1 characterAtIndex:i];
            unsigned char b = [str1 characterAtIndex:j];
            if (a == b) {
                if (j - i > 1) {
                    [str1 deleteCharactersInRange:NSMakeRange(j, 1)];
                    j--;
                }
            }
        }
    }
    NSLog(@"------%@-------", str1);
}
-(void) removeRepeat:(NSString *)aNum

{
    
    NSMutableArray *mArr = [[NSMutableArray alloc]initWithCapacity:10];
    
    for(int i = 0; i<aNum.length; i++)
        
    {
        
        [mArr addObject:[aNum substringWithRange:NSMakeRange(i,1)]];
        
    }
    
//    NSLog(@"%@",mArr);
    
    [self compareNum:mArr];
    
//    NSLog(@"%@",mArr);
    
}

//  比较是否相等

-(NSMutableArray *)compareNum:(NSMutableArray *)mArr

{
    
    int count  = mArr.count; // 重新定义了count不会减1
    
    for(int j = 0; j< count - 1 ;j++)
        
    {
        
        for(int i = j;i < count -1-1-1;i++)
            
        {
            
            NSLog(@"%@  %@",[mArr objectAtIndex:j],[mArr objectAtIndex:i + 2]);
            
            NSString *a = [mArr objectAtIndex:j];
            
            NSString *b = [mArr objectAtIndex:i+2];
            
            if([a isEqualToString:b])
                
            {
                
                [mArr replaceObjectAtIndex:i + 2 withObject:@" "];
                
            }
            
        }
        
    }
    
    return mArr;
    
}
/**
    UMSDK、ShareSDK、PgySDK、MJRefresh、百度地图SDK、SDWebImage、AFNetworking、MBProgressHUD、EasyNavigation
 **/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
