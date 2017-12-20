//
//  HomeMenuCell.m
//  MMPay
//
//  Created by 12 on 2017/11/23.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "HomeMenuCell.h"
#import "HomeMenuCollectionViewCell.h"
@interface HomeMenuCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,copy)NSArray *collectionData;
@property (weak, nonatomic) IBOutlet UICollectionView *menuCollectionView;//菜单视图

@end
@implementation HomeMenuCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"cellID";
    HomeMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"HomeMenuCell" owner:self options:nil].firstObject;
    }
    return cell;
}
-(NSArray *)collectionData{
    if (!_collectionData) {
        _collectionData = @[@{@"title":@"Transfer",@"image":@"icom_transfer"},@{@"title":@"Top up",@"image":@"icon_topup"},@{@"title":@"Withdraw",@"image":@"icon_withdraw"},@{@"title":@"Bouns",@"image":@"icon_bouns"},@{@"title":@"Coupon",@"image":@"icon_coupon"},@{@"title":@"Credit",@"image":@"icon_credit"},@{@"title":@"Credit pay",@"image":@"icon_creditPay"},@{@"title":@"Insurance",@"image":@"icon_insurance"},@{@"title":@"Fortune",@"image":@"iocn_fortune"},@{@"title":@"Phone Top up",@"image":@"icon_phoneTopup"},@{@"title":@"Utilities",@"image":@"icon_utilities"},@{@"title":@"Intl.wire",@"image":@"icon_Intl.wire"}];
    }
    return _collectionData;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.menuCollectionView.delegate = self;
    self.menuCollectionView.dataSource = self;
    [self.menuCollectionView registerNib:[UINib nibWithNibName:@"HomeMenuCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"collectionCell"];
    // Initialization code
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeMenuCollectionViewCell *cell = (HomeMenuCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.collectionData[indexPath.row][@"image"]];
    cell.titleL.text = self.collectionData[indexPath.row][@"title"];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(MMP_ScreenW/4-0.03, 65);
    
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.01;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.01;
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    if (self.delegate&&[self.delegate respondsToSelector:@selector(mmpCollectionView:didSelectItemAtIndexPath:)]) {
        [self.delegate mmpCollectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
