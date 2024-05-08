//
//  DriectInfoVC.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "DriectInfoVC.h"

@implementation DriectInfoVC

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        

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
    
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(40, Height/2 - 170, Width - 80 , 340)];
    back.backgroundColor = [UIColor whiteColor];
    back.layer.cornerRadius = 4;
    [self addSubview:back];
    
    
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(back.frame.size.width/2 - 35, 35, 70, 70)];
    img.image = [UIImage imageNamed:@"账户已存在"];
    [back addSubview:img];
    
    
    
    UIButton *closeBut = [UIButton initWithFrame:CGRectMake(back.frame.size.width - 30, 10, 20, 20) :@"关闭"];
     [closeBut addTarget:self action:@selector(closeAction) forControlEvents:(UIControlEventTouchUpInside)];
     [back addSubview:closeBut];
     
    [UILabel initWithDFLable:CGRectMake(0,120, back.frame.size.width, 30) :[UIFont systemFontOfSize:20*Width1] :COLOR2(51) :@"账号已存在，请核对身份" :back :1];
    
    
    NSArray *arr = @[
        [NSString stringWithFormat:@"姓名:%@",self.dic[@"obj"][@"name"]],
        [NSString stringWithFormat:@"身份证号:%@",self.dic[@"obj"][@"num"]],
        [NSString stringWithFormat:@"手机号码:%@",self.dic[@"obj"][@"phone"]],
    ];
    
    CGFloat wid = back.frame.size.width;
    for (int i = 0;  i < 3; i++) {
        
       [UILabel initWithDFLable:CGRectMake(0,170 + (25 *i), Width - 122, 25) :[UIFont systemFontOfSize:13*Width1] :COLOR2(151) :arr[i] :back :1];

    }
    

UIButton *endBut = [UIButton initWithFrame:CGRectMake(15, back.frame.size.height - 70,wid - 30, 40) :@"我知道了" :16*Width1];
endBut.layer.cornerRadius = 4;
                   endBut.backgroundColor = [UIColor redColor];
                 [endBut addTarget:self action:@selector(resAction) forControlEvents:(UIControlEventTouchUpInside)];
                  [back addSubview:endBut];
    
    

    
}
  
/// 直接添加
-(void)resAction{
    
    
    [self onTapGR];
    
    
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
