//
//  ViewController.m
//  AlertController使用
//
//  Created by 12 on 2017/11/10.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
/**
 * alert效果
 */
- (IBAction)alertAction:(UIButton *)sender {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"alert" message:@"默认效果展示" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"-----好的");
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"-----取消");
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"-----删除");
    }];
    /**
     * 两个事件时左右排列
     * 超过两个纵向排列
     */
    [alertC addAction:sureAction];
    [alertC addAction:cancelAction];
    [alertC addAction:deleteAction];
    [self presentViewController:alertC animated:YES completion:^{
        
    }];
}
/**
 * actionSheet效果
 */
- (IBAction)actionSheetAction:(UIButton *)sender {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"actionSheet" message:@"默认效果展示" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"-----好的");
    }];
    /**
     * UIAlertActionStyleCancel样式会默认显示在底部分区，且该类型事件最多只能添加一个，否则程序会崩溃
     */
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"-----取消");
    }];
    UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"-----取消1");
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"-----删除");
    }];
    UIAlertAction *deleteAction1 = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"-----删除1");
    }];
    UIAlertAction *deleteAction2 = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"-----删除2");
    }];
    [alertC addAction:sureAction];
    [alertC addAction:cancelAction];
    /**
     * 打开注程序释会崩溃 UIAlertActionStyleCancel样式的事件最多只能添加一个
     */
//    [alertC addAction:cancelAction1];
    [alertC addAction:deleteAction];
    [alertC addAction:deleteAction1];
    [alertC addAction:deleteAction2];
    /**
     * 在iOS 8中我们不再需要小心翼翼地计算出弹出框的大小，UIAlertController将会根据设备大小自适应弹出框的大小。并且在iPhone或者紧缩宽度的设备中它将会返回nil值。配置该弹出框的代码如下：
     */
        UIPopoverPresentationController *popOver =alertC.popoverPresentationController;
        if (popOver) {
            popOver.sourceView = sender;
            popOver.sourceRect = sender.bounds;
            popOver.permittedArrowDirections = UIPopoverArrowDirectionUp;
        }
    [self presentViewController:alertC animated:YES completion:^{
    }];
}
/**
 *
 */
- (IBAction)popOverAction:(UIButton *)sender {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"popOver" message:@"默认效果展示" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"-----保存");
    }];
    /**
     * UIAlertActionStyleCancel样式会默认显示在底部分区，且该类型事件最多只能添加一个，否则程序会崩溃
     */
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"-----删除");
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"-----取消");
    }];
    [alertC addAction:saveAction];
    [alertC addAction:deleteAction];
    [alertC addAction:cancelAction];
    /**
     * 在iOS 8中我们不再需要小心翼翼地计算出弹出框的大小，UIAlertController将会根据设备大小自适应弹出框的大小。并且在iPhone或者紧缩宽度的设备中它将会返回nil值。配置该弹出框的代码如下：
     */
    UIPopoverPresentationController *popOver =alertC.popoverPresentationController;
    if (popOver) {
        popOver.sourceView = sender;
        popOver.sourceRect = sender.bounds;
        popOver.permittedArrowDirections = UIPopoverArrowDirectionLeft;
    }
    [self presentViewController:alertC animated:YES completion:^{

    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
