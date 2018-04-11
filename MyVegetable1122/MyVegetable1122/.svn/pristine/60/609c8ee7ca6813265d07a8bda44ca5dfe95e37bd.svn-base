//
//  AboutCellTableViewCell.m
//  MyVegetable
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 yunhoo. All rights reserved.
//

#import "AboutCellTableViewCell.h"

@implementation AboutCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithNib
{
    NSArray* arr=[[NSBundle mainBundle]loadNibNamed:@"aboutCells" owner:self options:nil];
    self=[arr firstObject];
    return self;
}
-(void)setKey:(NSString *)key the:(NSString *)value
{
    self.textLabel.text=key;
    self.detailTextLabel.text=value;
}
@end
