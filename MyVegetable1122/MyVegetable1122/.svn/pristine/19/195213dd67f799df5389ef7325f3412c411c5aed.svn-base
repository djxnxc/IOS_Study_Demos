//
//  InputDialog.h
//  FootballReferee
//
//  Created by apple on 15/12/16.
//  Copyright © 2015年 com.yunhoo.www. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol InputDelegate<NSObject>
-(void)inputMessage:(id)dialog theMessage:(NSString*)string;
@end
@interface InputDialog : UIView
{
    UIWindow* windows;
    id<InputDelegate> inputDelegate;
    UIView* backView;
}
@property(retain) id<InputDelegate> inputDelegate;

- (IBAction)shure:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *shureBtn;
@property (strong, nonatomic) IBOutlet UITextField *inputMessage;
@property (strong, nonatomic) IBOutlet UILabel *title;
- (IBAction)cancle:(id)sender;
-(void)dismess;
-(void)show;
-(id)initWithNib;

@end
