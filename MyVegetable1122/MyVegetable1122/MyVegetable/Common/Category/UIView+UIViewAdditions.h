//
//  UIView+UIViewAdditions.h
//  CommunityPersonal
 
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewAdditions)


// frame.origin.x
@property (nonatomic) CGFloat left;

// frame.origin.y
@property (nonatomic) CGFloat top;

// frame.origin.x + frame.size.width
@property (nonatomic) CGFloat right;

// frame.origin.y + frame.size.height
@property (nonatomic) CGFloat bottom;

// frame.size.width
@property (nonatomic) CGFloat width;

// frame.size.height
@property (nonatomic) CGFloat height;

// center.x
@property (nonatomic) CGFloat centerX;

// center.y
@property (nonatomic) CGFloat centerY;



// return the x coordinate on the screen.
@property (nonatomic, readonly) CGFloat screenX;

// return the y coordinate on the screen.
@property (nonatomic, readonly) CGFloat screenY;



- (void)hiddenAllSubviews;
- (void)showAllSubviews;

// Remove all subviews of self.
- (void)removeAllSubviews;


/**
 * Shows the view in a window at the bottom of the screen.
 *
 * This will send a notification pretending that a keyboard is about to appear so that
 * observers who adjust their layout for the keyboard will also adjust for this view.
 */
- (void)presentAsKeyboardInView:(UIView *)containingView;

/**
 * Hides a view that was showing in a window at bottom of the screen (via presentAsKeyboardInView:)
 * 
 * This will send a notification pretending that a keyboard is about to disappear so that
 * observers who adjust their layout for the keyboard will also adjust for this view.
 
 */
- (void)dismissAsKeyboardInView:(BOOL)animated;

@end
