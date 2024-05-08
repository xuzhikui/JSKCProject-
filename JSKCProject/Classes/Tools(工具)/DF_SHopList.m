//
//  DF_SHopList.m
//  YbtPrject
//
//  Created by aaa on 2018/6/24.
//  Copyright © 2018年 mdfs. All rights reserved.
//

#import "DF_SHopList.h"

@implementation DF_SHopList

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor clearColor];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    
//    [[AFN_DF topViewController].navigationController setNavigationBarHidden:YES animated:YES];
   
    self.backVC = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
    self.backVC.backgroundColor = [UIColor blackColor];
    self.backVC.alpha = 0.5;
    UITapGestureRecognizer *TapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapGR)];
         self.backVC.userInteractionEnabled = YES;
         [ self.backVC addGestureRecognizer:TapGR];
    
    [self addSubview:self.backVC];
    
    // 选择框
    
    UIView *selectVC = [[UIView alloc]initWithFrame:CGRectMake(0, Height - 250, Width, 250)];
    selectVC.backgroundColor = [UIColor whiteColor];
    [self addSubview:selectVC];
    
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(50*Width1, 0, Width - 100*Width1, 250*Height1)];
    // 显示选中框
    pickerView.showsSelectionIndicator=YES;
    
    pickerView.dataSource = self;
    pickerView.delegate = self;
        [selectVC addSubview:pickerView];
    
    [[AFN_DF topViewController].view endEditing:YES];
    
    UIButton *endBut = [UIButton initWithFrame:CGRectMake(Width - 60*Width1, 10*Height1, 50*Width1, 30*Height1) :@"确定" :15];
    [endBut addTarget:self action:@selector(endButAction) forControlEvents:(UIControlEventTouchUpInside)];
    [endBut setTitleColor:[UIColor blackColor] forState:0];
    [selectVC addSubview:endBut];
    
    UIButton *canBut = [UIButton initWithFrame:CGRectMake(0, 10*Height1, 60*Width1, 30*Height1) :@"取消" :15];
       [canBut addTarget:self action:@selector(canButAction) forControlEvents:(UIControlEventTouchUpInside)];
        [canBut setTitleColor:[UIColor blackColor] forState:0];
    [selectVC addSubview:canBut];
    
}

-(void)endButAction{
    
    _block(_code);
    [self removeFromSuperview];
    [[AFN_DF topViewController].navigationController setNavigationBarHidden:NO animated:YES];
    
}
-(void)canButAction{
    
    
    [self removeFromSuperview];
    [[AFN_DF topViewController].navigationController setNavigationBarHidden:NO animated:YES];
    
}

#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    
    return [_proTimeList count];
}


#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    
    return 210*Width1;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSString  *_proTimeStr = [_proTimeList objectAtIndex:row];
    _code = row;

}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [_proTimeList objectAtIndex:row];
    
}
-(void)onTapGR{
    
      [[AFN_DF topViewController].navigationController setNavigationBarHidden:NO animated:YES];
      [self removeFromSuperview];
}



@end
