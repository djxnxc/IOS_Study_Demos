//
//  ViewController.m
//  重力感应
//
//  Created by 邓家祥 on 2019/1/7.
//  Copyright © 2019年 HT. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation ViewController
-(CMMotionManager *)motionManager {
    if (_motionManager == nil) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    return _motionManager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startUpdateAccelerometerResult];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)stopUpdate
{
    if ([self.motionManager isAccelerometerActive] == YES)
    {
        [self.motionManager stopAccelerometerUpdates];
    }
}
- (void)startUpdateAccelerometerResult{
    if ([self.motionManager isAccelerometerAvailable] == YES) {
        [self.motionManager setAccelerometerUpdateInterval:0.06];
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         {
             double x = accelerometerData.acceleration.x;
             double y = accelerometerData.acceleration.y;
             if (fabs(y) >= fabs(x))
             {
                 if (y >= 1){
                     //Down
                     NSLog(@"Down");
                 }
                 if(y<= -1){
                     //Portrait
                     NSLog(@"Portrait");
                 }
             }
             else
             {
                 if (x >= 1){
                     //Right
                     NSLog(@"Right");
//                     self.btnClick.backgroundColor =[UIColor blueColor];
                     
                 }
                 if(x<= -1){
                     //Left
                     NSLog(@"Left");
//                     self.btnClick.backgroundColor =[UIColor yellowColor];
                 }
             }
         }];
    }
}

- (void)dealloc
{
    _motionManager = nil;
}
@end
