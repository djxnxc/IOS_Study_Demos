//
//  AccountHQCell.m
//  MyVegetable
//
//  Created by mythkiven on 15/11/21.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import "AccountHQCell.h"
#import "AccountHQCellModel.h"
@implementation AccountHQCell
@synthesize SBW;
-(id)initWithNib:(CGFloat)sw
{
    NSArray* arr=[[NSBundle mainBundle]loadNibNamed:@"AccountHQCell" owner:self options:nil];
    self=[arr firstObject];
    if (self) {
        CGRect f=self.contentView.frame;
        f.size.width=sw;
        self.contentView.frame=f;
        self.SBW=sw;
    }
    return self;
}
- (void)setModel:(AccountHQCellModel *)model {
    self.time.text = model.time;
    self.monkey.text = model.monkey;
    self.monkeyGet.text = model.monkeyGet;
   // self.style.text= model.style;
//    self.w.constant=JSCREEN_W/3.0;
    CGRect g=self.time.frame;
    g.size.width=self.SBW/3.0;
    g.origin.x=0;
    self.time.frame=g;
    g=self.monkey.frame;
     g.size.width=self.SBW/3.0;
    g.origin.x=self.SBW/3.0;
    self.monkey.frame=g;
    g=self.monkeyGet.frame;
     g.size.width=self.SBW/3.0;
    g.origin.x=self.SBW/3.0*2;
    self.monkeyGet.frame=g;
    
    
}
- (void)layoutSublayersOfLayer:(CALayer *)layer {
//    if (iPhone6P) {
//        self.w.constant=JSCREEN_W/3.0;
//    }if (iPhone6 ) {
//        self.w.constant=JSCREEN_W/3.0;
//    }if (iPhone5) {
//        self.w.constant=JSCREEN_W/3.0;
//    }
}
@end
