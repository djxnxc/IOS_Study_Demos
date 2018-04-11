//
//  PopView.h
//  MyVegetable
//
//  Created by mythkiven on 15/11/17.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol popViewDelegate <NSObject>
- (void)dismiss;
- (void)cancel;
- (void)sure;
@end

@interface PopView : UIView
@property (weak, nonatomic) IBOutlet UIView *bg;
@property (weak, nonatomic) IBOutlet UIView *popView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *fengeView;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (weak, nonatomic) IBOutlet UIButton *sure;
@property (weak, nonatomic) IBOutlet UIButton *dismiss;
@property (weak, nonatomic) IBOutlet UILabel *detail;

@property (nonatomic, weak) id<popViewDelegate> delegate;


- (IBAction)cancelBtn;
- (IBAction)sureBtn;
- (IBAction)dismissBtn;

@end
