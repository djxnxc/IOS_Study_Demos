//
//  TransData.m
//  MyVegetable
//
//  Created by mythkiven on 15/12/14.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "TransData.h"

@implementation TransData
+ (NSInteger)transViewIndex:(UIView *)view arr:(NSMutableArray *)useData {
//    NSInteger index,sIndex;
    if (useData.count==0) {
        return 0;
    }
    if (useData.count>0&&useData.count<3) {
        return useData.count-1;
    }
    if (useData.count>=3) {
        NSInteger begin = -ceil(useData.count / 2.0f);
        NSInteger end = ceil(useData.count / 2.0f)- 1;
//        NSInteger begin = -ceil(6 / 2.0f);
//        NSInteger end = ceil(6 / 2.0f) - 1;
//        NSInteger begin1 = -ceil(7 / 2.0f);
//        NSInteger end2 = ceil(7 / 2.0f)-1;
        
        for (NSInteger i = begin; i <= end; i++) {
            if (view.tag == i) {
                return i+useData.count/2;
            }
        
        }}
    return 99;
//        return 99;
//    //4组数据
//    if (useData.count == 6) {//6： -3 -2 -1 0 1 2
//        switch (view.tag) {
//            case -3:{
//                index = 0;
//                sIndex = 99;
//                break;
//            }case -2:{
//                index = 1;
//                sIndex = 1;
//                break;
//            }case -1:{
//                index = 2;
//                sIndex = 2;
//                break;
//            }case 0:{
//                index = 3;
//                sIndex = 3;
//                break;
//            }case 1:{
//                index = 4;
//                sIndex = 4;
//                break;
//            }case 2:{
//                index = 5;
//                sIndex = 99;
//                break;
//            }
//            default:
//                break;
//        }
//    }
//    
//    
//    //7： -3 -2 -1 0 1 2 3

//    //8：-4 -3 -2 -1 0 1 2 3
//    //9：-4 -3 -2 -1 0 1 2 3 4
//    //10：-5 -4 -3 -2 -1 0 1 2 3 4
//    //11：-5 -4 -3 -2 -1 0 1 2 3 4 5
//    //12：-6 -5 -4 -3 -2 -1 0 1 2 3 4 5
//    
//    return index;
    
}
+ (NSInteger)transViewSindex:(UIView *)view arr:(NSMutableArray *)useData {
//    NSInteger index,sIndex;
    
    if (useData.count>=3) {
        NSInteger begin = -ceil(useData.count / 2.0f);
        NSInteger end = ceil(useData.count / 2.0f)- 1;
        //        NSInteger begin = -ceil(6 / 2.0f);
        //        NSInteger end = ceil(6 / 2.0f) - 1;
        //        NSInteger begin1 = -ceil(7 / 2.0f);
        //        NSInteger end2 = ceil(7 / 2.0f)-1;
        
        for (NSInteger i = begin; i <= end; i++) {
            if (view.tag == begin) {
                return 99;
            }else
            if (view.tag == end) {
                return 99;
            }else
            if (view.tag == i) {
//                int j =  i+useData.count/2;
                return i+useData.count/2;
                
            }
        }
    }
        return 99;
    
//    //4组数据
//    if (useData.count == 6) {//6 -3 -2 -1 0 1 2
//        switch (view.tag) {
//            case -3:{
//                index = 0;
//                sIndex = 99;
//                break;
//            }case -2:{
//                index = 1;
//                sIndex = 1;
//                break;
//            }case -1:{
//                index = 2;
//                sIndex = 2;
//                break;
//            }case 0:{
//                index = 3;
//                sIndex = 3;
//                break;
//            }case 1:{
//                index = 4;
//                sIndex = 4;
//                break;
//            }case 2:{
//                index = 5;
//                sIndex = 99;
//                break;
//            }
//            default:
//                break;
//        }
//    }
//    return sIndex;
    
}

@end
