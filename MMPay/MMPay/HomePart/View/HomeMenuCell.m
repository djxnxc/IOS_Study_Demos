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
        _collectionData = @[@{@"title":@"Transfer",@"image":@"转账"},@{@"title":@"Top up",@"image":@"充值"},@{@"title":@"Withdraw",@"image":@"提现"},@{@"title":@"Bouns",@"image":@"佣金奖励"},@{@"title":@"Coupon",@"image":@"优惠券"},@{@"title":@"Credit",@"image":@"credit"},@{@"title":@"Credit pay",@"image":@"支付"},@{@"title":@"Insurance",@"image":@"保险"},@{@"title":@"Fortune",@"image":@"财富"},@{@"title":@"Phone Top up",@"image":@"手机充值"},@{@"title":@"Utilities",@"image":@"生活缴费"},@{@"title":@"Intl.wire",@"image":@"跨境人民币汇款"}];
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
    return CGSizeMake(MMP_ScreenW/4-3, 65);
    
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
