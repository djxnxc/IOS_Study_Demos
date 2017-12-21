//
//  HomeMenuCell.h
//  MMPay
//
//  Created by 12 on 2017/11/23.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeMenuCellDelegate <NSObject>
-(void)mmpCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath title:(NSString *)title;
@end

@interface HomeMenuCell : UITableViewCell
@property(nonatomic,weak)id <HomeMenuCellDelegate>delegate;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

