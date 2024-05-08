//
//  DriverbankView.m
//  JSKCProject
//
//  Created by XHJ on 2021/3/25.
//  Copyright © 2021 孟德峰. All rights reserved.
//

#import "DriverbankView.h"

@implementation DriverbankView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        [self setUI];
    }
    return self;
}

-(void)layoutSubviews{
    
    [self setUI];
    
}

-(void)setUI{
//
    self.backVC = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
    self.backVC.backgroundColor = [UIColor blackColor];
    self.backVC.alpha = 0.5;
    
    UITapGestureRecognizer *TapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapGR)];
         self.backVC.userInteractionEnabled = YES;
         [ self.backVC addGestureRecognizer:TapGR];
    
    [self addSubview:self.backVC];
    
    UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake(66, 150, Width - 132, 300)];
    img.image = [UIImage imageNamed:@"抢单背景"];
    [self addSubview:img];
    img.userInteractionEnabled = YES;
    
    UIButton *closeBut = [UIButton initWithFrame:CGRectMake(Width - 76, 202, 20, 20) :@"关闭"];
    [closeBut addTarget:self action:@selector(closeAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:closeBut];
    
   [UILabel initWithDFLable:CGRectMake(0,120, Width - 132, 30) :[UIFont systemFontOfSize:20*Width1] :COLOR2(51) :@"司机未绑卡" :img :1];
    
    
    UILabel *tips =  [UILabel initWithDFLable:CGRectMake(20,160, Width - 162, 40) :[UIFont systemFontOfSize:13*Width1] :COLOR2(153) :@"抢单之前，为避免影响运费结算， 请先与司机沟通绑定银行卡!" :img :1];
        tips.numberOfLines = 0;
    
    
    
    UIButton *endBut = [UIButton initWithFrame:CGRectMake(24, 240,img.frame.size.width - 48, 38) :@"我知道了" :17*Width1];
    endBut.backgroundColor = [UIColor redColor];
    endBut.layer.cornerRadius = 4;
    [endBut addTarget:self action:@selector(closeAction) forControlEvents:(UIControlEventTouchUpInside)];
    endBut.userInteractionEnabled = YES;
  
    [img addSubview:endBut];
    self.endBut = endBut;

    
   
}







-(void)closeAction{
    [[AFN_DF topViewController].navigationController setNavigationBarHidden:NO animated:YES];
    [self removeFromSuperview];
    
}


-(void)onTapGR{
      [[AFN_DF topViewController].navigationController setNavigationBarHidden:NO animated:YES];
      [self removeFromSuperview];
}
@end
