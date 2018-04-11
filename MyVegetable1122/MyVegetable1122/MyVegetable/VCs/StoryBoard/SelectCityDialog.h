//
//  SelectCityDialog.h
//  MyVegetable
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 yunhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectCityDelegate<NSObject>
-(void)selectCityIndex:(id)selectCity atIndex:(NSInteger)index;
@end
@interface SelectCityDialog : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    //NSArray* citys;
    UIView* backView;
    UIWindow *windows;
    id<SelectCityDelegate> selectDelegate;
    NSInteger selectIndex;
}
@property(retain) id<SelectCityDelegate> selectDelegate;
@property (strong,nonatomic) NSArray* citys;
@property (strong, nonatomic) IBOutlet UILabel *cityTitle;
@property (strong, nonatomic) IBOutlet UIPickerView *cityPickerView;

- (IBAction)cancleBtn:(id)sender;
- (IBAction)shure:(id)sender;
-(void)show;
-(void)dismiss;
-(id)initWithNib;
@end
