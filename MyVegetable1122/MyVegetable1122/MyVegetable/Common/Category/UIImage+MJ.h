//


#import <UIKit/UIKit.h>

@interface UIImage (MJ)

+ (UIImage *)imageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
@end
