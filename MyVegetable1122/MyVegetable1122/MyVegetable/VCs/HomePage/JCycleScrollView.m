//
//
//
//
//

#import "JCycleScrollView.h"
#import "ImgModel.h"
@interface JCycleScrollView () <UIScrollViewDelegate>
{

    NSTimer         *_timer;

    CGFloat         _jScrollW ;
    CGFloat         _jScrollH ;
    CGRect          _frame;
    NSInteger       _intervalTime;


}
@end

@implementation JCycleScrollView

- (id)initWithFrame:(CGRect)frame duration:(CGFloat)duration slideImages:(NSMutableArray *)slideImages
{
    
    self = [super initWithFrame:frame];
    if (self) {
        _jScrollW = frame.size.width;
        _jScrollH = frame.size.height;
        _frame = frame;
        _intervalTime = duration;
        if (slideImages.count) {
            _slideImages = slideImages;
            [self loadData];
        }else{
            _slideImages = [ NSMutableArray array];
        }
        
        
        
        [self beginTimer];
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        [self createScrollView];
        _scrollView.contentOffset = CGPointMake(_jScrollW, 0);
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 15, frame.size.width, 15)];
        [self createPageControl];
        [self addSubview:_pageControl];
       
        
    }
    return self;
}
- (void)reloadImg:(NSArray *)arr {
    [_slideImages removeAllObjects];
    _slideImages = [NSMutableArray arrayWithArray:arr];
    [self loadData];
    [self stopTimer];
    [self beginTimer];
    [self createScrollView];
    [self createPageControl];
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[UIPageControl class]]) {
            [self bringSubviewToFront:v];
            v.userInteractionEnabled = YES;
        }
    }
//    for (UIView *v in self.subviews) {
//        if ([v isKindOfClass:[UIPageControl class]]) {
//            [self bringSubviewToFront:v];
//        }
//    }
    
    
}
- (void)loadData {
    if (_slideImages.count) {
        [_slideImages insertObject:[_slideImages lastObject] atIndex:0];
        [_slideImages addObject:[_slideImages objectAtIndex:1]];
    }
    
}
- (void)createScrollView {
    
    _scrollView.contentSize = CGSizeMake(_slideImages.count * _jScrollW, 0);
    _scrollView.bounces = YES;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:_scrollView];
    if (_slideImages.count) {
        for (int i = 0; i < [_slideImages count]; i++) {
            ImgModel *model = _slideImages[i];
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(i * _jScrollW, 0, _jScrollW, _jScrollH)];
//            iv.contentMode = UIViewContentModeScaleAspectFill;
            iv.userInteractionEnabled = YES;
            
            if (model.iconName) {
                iv.image = [UIImage imageNamed:model.iconName];
            }else if(model.iconUrl){
                iv.tag = [model.iconID integerValue];
                [iv sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]];
            }
            UITapGestureRecognizer *singleTap =
            [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(whenClickImage:)];
            [iv addGestureRecognizer:singleTap];
            [_scrollView insertSubview:iv belowSubview:_pageControl];
            //[_scrollView addSubview:iv];
        }
    }
    
    
}
- (void)whenClickImage:(UIGestureRecognizer *)gestureRecognizer{
    if ([self.sdelegate respondsToSelector:@selector(didClickedScrollView:)]) {
        [self.sdelegate didClickedScrollView:gestureRecognizer];
    }
}

- (void)createPageControl {
    _pageControl.center = CGPointMake(_jScrollW/2, _jScrollH-15);
    _pageControl.numberOfPages = _slideImages.count - 2;
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor =  RGB(211, 211, 211, 1);
    _pageControl.hidesForSinglePage = NO;
    _pageControl.enabled = NO;
    _pageControl.currentPage = 0;
}
- (void)nextPicture {
    CGPoint offset = CGPointMake(_scrollView.contentOffset.x + _jScrollW, 0);
    [_scrollView setContentOffset:offset animated:YES];

}
- (void)beginTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:_intervalTime target:self selector:@selector(nextPicture) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)stopTimer {
    [_timer setFireDate:[NSDate distantFuture]];
    _timer = nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float page = scrollView.contentOffset.x/_jScrollW;
    
    if (page<=0.5) {
        _pageControl.currentPage = _slideImages.count - 3;
    } else if(page>=_slideImages.count - 1+0.5){
        _pageControl.currentPage = 0;
    }else{
        _pageControl.currentPage = page-1;
    }
    if(scrollView.contentOffset.x == 0) {
        scrollView.contentOffset = CGPointMake((_slideImages.count-2) * _jScrollW, 0);
    }
    if (scrollView.contentOffset.x == (_slideImages.count-1) * _jScrollW) {
        scrollView.contentOffset = CGPointMake(_jScrollW, 0);
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.x == 0) {
        scrollView.contentOffset = CGPointMake((_slideImages.count-2) * _jScrollW, 0);
    }

    if (scrollView.contentOffset.x == (_slideImages.count-1) * _jScrollW) {
        scrollView.contentOffset = CGPointMake(_jScrollW, 0);
    }
 
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self beginTimer];
}

@end
