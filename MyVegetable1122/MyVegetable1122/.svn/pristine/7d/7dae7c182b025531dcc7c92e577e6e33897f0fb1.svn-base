//
//  ScrollView.h
//  UIScrollView_循环滚动
//
//  Created by 蒋孝才 on 15/7/19.
//

#import <UIKit/UIKit.h>

@protocol JCycleScrollViewDelegate <NSObject>
- (void)didClickedScrollView:(UIGestureRecognizer *)img;
@end

@interface JCycleScrollView : UIView

@property (strong,nonatomic)    UIScrollView    *scrollView;
@property (strong,nonatomic)    NSMutableArray  *slideImages;
@property (strong,nonatomic)    UIPageControl   *pageControl;
@property (nonatomic, weak) id <JCycleScrollViewDelegate> sdelegate;
//@property (strong, nonatomic)   UITextField     *text;
- (id)initWithFrame:(CGRect)frame duration:(CGFloat)duration slideImages:(NSMutableArray *)slideImages;
- (void)reloadImg:(NSArray *)arr;
@end
