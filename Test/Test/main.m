//
//  main.m
//  Test
//
//  Created by 12 on 2018/3/13.
//  Copyright © 2018年 DJX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//void sort(int a[],int n)
//{
//
//    int i, j, index;
//
//    for(i = 0; i < n - 1; i++) {
//
//        index = i;
//
//        for(j = i + 1; j < n; j++) {
//
//            if(a[index] > a[j]) {
//
//                index = j;
//
//            }
//
//        }
//
//        if(index != i) {
//
//            int temp = a[i];
//
//            a[i] = a[index];
//
//            a[index] = temp;
//
//        }
//
//    }
//
//}

int main(int argc, char * argv[]) {
    @autoreleasepool {
//        //冒泡排序降序 方法一 从前往后比
//        int array[10] = {24, 17, 85, 13, 9, 54, 76, 45, 5, 63};
//        int num = 10;
//        int count = 0;
//        for(int i = 0;i<num-1;i++){
//            for (int j=0; j<num-1-i; j++) {
//                count++;
//
//                if (array[j]<array[j+1]) {
//                    int tmp = array[j];
//                    array[j] = array[j+1];
//                    array[j+1]= tmp;
//                }
//            }
//        }
//        printf("遍历次数%d\n",count);
//        for (int i = 0; i<num-1; i++) {
//            printf("%d",array[i]);
//            printf(" ");
//        }
//        //冒泡排序升序 方法二 从后往前比
//        int count1 = 0;
//        for (int i=0; i<num-1; i++) {
//
//            for (int j=num-2; j>=i; j--) {
//                count1++;
//                if (array[j]>array[j+1]) {
//                    int tmp = array[j];
//                    array[j] = array[j+1];
//                    array[j+1] = tmp;
//                }
//            }
//        }
//        printf("遍历次数%d\n",count1);
//
//        for (int i = 0; i<num; i++) {
//            printf("%d",array[i]);
//            printf(" ");
//        }
        
        
        
//        int numArr[10] = {86, 37, 56, 29, 92, 73, 15, 63, 30, 8};
//
//        sort(numArr, 10);
//
//        for (int i = 0; i < 10; i++) {
//
//            printf("%d, ", numArr[i]);
//
//        }
//
//        printf("\n");
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
 
}
