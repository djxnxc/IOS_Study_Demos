//
//  TopUpCell.m
//  MMPay
//
//  Created by 12 on 2017/12/21.
//  Copyright © 2017年 Jack_D. All rights reserved.
//

#import "TopUpCell.h"
#import "TopUpCollectionViewCell.h"
@interface TopUpCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
{
    NSInteger i;//定义全局变量
    
}
@end
@implementation TopUpCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"cellID";
    TopUpCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"TopUpCell" owner:self options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    i=0;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.phoneNumberTextField.delegate = self;
    [self.phoneNumberTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TopUpCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectionViewcell"];
    // Initialization code
}
//输入框值发生变化
-(void)textFieldDidChange:(UITextField *)textField{
    
    if (textField.text.length > i) {
        if (textField.text.length == 4 || textField.text.length == 9 ) {//输入
            NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
            [str insertString:@" " atIndex:(textField.text.length-1)];
            textField.text = str;
        }if (textField.text.length >= 13 ) {//输入完成
            textField.text = [textField.text substringToIndex:13];
            [textField resignFirstResponder];
        }
        i = textField.text.length;
        
    }else if (textField.text.length < i){//删除
        if (textField.text.length == 4 || textField.text.length == 9) {
            textField.text = [NSString stringWithFormat:@"%@",textField.text];
            textField.text = [textField.text substringToIndex:(textField.text.length-1)];
        }
        i = textField.text.length;
    }
}
//打开通讯录按钮
- (IBAction)addressBookButClick:(UIButton *)sender {
}
#pragma mark - UICollectionView代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((MMP_ScreenW-30-20)/3,(MMP_ScreenW-30-20)/3/110*65);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TopUpCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewcell" forIndexPath:indexPath];
    cell.topLabel.text = [self.arrData[indexPath.row] componentsSeparatedByString:@"-"].firstObject;
    cell.bottomLabel.text = [self.arrData[indexPath.row] componentsSeparatedByString:@"-"].lastObject;
    return cell;
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//选中
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TopUpCollectionViewCell *cell = (TopUpCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderColor = MMP_BLUECOLOR.CGColor;
    cell.backgroundColor =MMP_BLUECOLOR;
    cell.topLabel.backgroundColor = MMP_BLUECOLOR;
    cell.topLabel.textColor = [UIColor whiteColor];
    cell.bottomLabel.backgroundColor = MMP_BLUECOLOR;
    cell.bottomLabel.textColor = [UIColor whiteColor];
    cell.layer.masksToBounds = YES;
    NSString *selectStr = [self.arrData[indexPath.row] componentsSeparatedByString:@"-"].firstObject;
    if (self.selectblcok) {
        self.selectblcok(selectStr);
    }
}
//取消选中
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    TopUpCollectionViewCell *cell = (TopUpCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderColor = MMP_CUSTOM_COLOR(218, 218, 218, 1).CGColor;
    cell.layer.masksToBounds = YES;
    cell.backgroundColor =[UIColor whiteColor];
    cell.topLabel.backgroundColor = [UIColor whiteColor];
    cell.topLabel.textColor = MMP_BLUECOLOR;
    cell.bottomLabel.backgroundColor = [UIColor whiteColor];
    cell.bottomLabel.textColor = MMP_BLUECOLOR;
    cell.layer.masksToBounds = YES;
    NSLog(@"取消*****%ld",indexPath.row);
  
}
#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.addressBookBut.hidden = YES;
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.addressBookBut.hidden = NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
