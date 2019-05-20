//
//  ViewController.m
//  归档和解档
//
//  Created by 12 on 2018/2/28.
//  Copyright © 2018年 djx. All rights reserved.
//

#import "ViewController.h"
#import "YCArchiveBaseModel+ArchiveMethod.h"
#import "User.h"
@interface ViewController ()
{
    NSString *filePath;
}
@property (weak, nonatomic) IBOutlet UITextField *saveTextF;
@property (weak, nonatomic) IBOutlet UILabel *readLab;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
//归档
- (IBAction)save:(id)sender {
    User *user = [[User alloc]init];
    Lines *line = [[Lines alloc]init];
    line.lineName = @"aaa";
    line.lineCode = @"001";
    Lines *line1 = [[Lines alloc]init];
    line1.lineName = @"bbb";
    line1.lineCode = @"002";
    user.lines = @[line,line1];
    // 获取沙盒Document路径
    filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingPathComponent:@"test.plist"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:user forKey:@"aaa"];
    [NSKeyedArchiver archiveRootObject:user  toFile:filePath];

    if (self.saveTextF.text.length>0) {
//        NSString *homePath = NSHomeDirectory();
//        NSString *path = [homePath stringByAppendingPathComponent:@"Library/Caches/hehe.archive"];
//        [NSKeyedArchiver archiveRootObject:_saveTextF.text toFile:path];
        //使用第三方归档
        [YCArchiveBaseModel archiveWithObjc:line];
    }
}
/**
 *stringByAppendingPathComponent 与stringByAppendingString的区别在于后者在要拼接的字符串前要手动添加'/'
 **/

//解档
- (IBAction)read:(id)sender {
//    NSString *homePath = NSHomeDirectory();
//    NSString *path = [homePath stringByAppendingString:@"/Library/Caches/hehe.archive"];
//    self.readLab.text =[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    //使用第三方解档
//   Lines *us = [YCArchiveBaseModel unarchive];
   NSDictionary *us= [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

    NSLog(@"%@",us);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
