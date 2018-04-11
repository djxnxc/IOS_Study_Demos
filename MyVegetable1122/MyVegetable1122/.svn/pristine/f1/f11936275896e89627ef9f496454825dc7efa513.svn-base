//
//  DingqiLICAI.h
//  LTInfiniteScrollView
//
//  Created by mythkiven on 15/11/16.
//  Copyright © 2015年 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DingQiLCDViewDelegate <NSObject>
- (void)didClickedDetailBtnn:(UIButton *)btn;
@end
@class DingLICAIModel;
@interface DingqiLICAI : UIView

@property (weak, nonatomic) IBOutlet UIView *UIVEW;
//@property (weak, nonatomic) IBOutlet UILabel *TopH;
//20
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopH;
@property (weak, nonatomic) IBOutlet UILabel *lastLabel;

//20
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *UpLabelH;
@property (weak, nonatomic) IBOutlet UILabel *Uplabel;
//26
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *MidLabelH;
//20
@property (weak, nonatomic) IBOutlet UIButton *boomBtn;
//42
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BoomLabelH;

@property (weak, nonatomic) IBOutlet UILabel *per;
@property (weak, nonatomic) IBOutlet UIImageView *bg;
@property (copy, nonatomic) NSString *str;
@property (strong, nonatomic) DingLICAIModel *dmodel;
//@property (weak, nonatomic) IBOutlet UILabel *lastLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lastImg;
@property (nonatomic, weak) id <DingQiLCDViewDelegate> delegate;
- (IBAction)clickedBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *chanpinBtn;
@property (weak, nonatomic) IBOutlet UILabel *nianhuaLabel;
+ (instancetype)viewWith:(NSString *)str;
@end
