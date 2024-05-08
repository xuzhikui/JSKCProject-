//
//  CanlWayView.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/24.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "CanlWayView.h"

@implementation CanlWayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.backVC = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
       self.backVC.backgroundColor = [UIColor blackColor];
       self.backVC.alpha = 0.5;
       UITapGestureRecognizer *TapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapGR)];
            self.backVC.userInteractionEnabled = YES;
            [ self.backVC addGestureRecognizer:TapGR];
       
       [self addSubview:self.backVC];
    
    
    self.viewVC = [[UIView alloc]initWithFrame:CGRectMake((Width - 250)/2, 200, 250, 225)];
    self.viewVC.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.viewVC];
    self.viewVC.layer.cornerRadius = 4;
    
    
    
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake((self.viewVC.frame.size.width - 60)/2, 40,60 ,60)];
    img.image = [UIImage imageNamed:@"提示-1"];
    [self.viewVC addSubview:img];
    
    [UILabel initWithDFLable:CGRectMake(0, 120, self.viewVC.frame.size.width, 20) :[UIFont systemFontOfSize:15*Width1] :[UIColor blackColor] :@"确定取消此运单吗?" :self.viewVC :1];
    
    
    
    UIButton *czbut = [UIButton initWithFrame:CGRectMake((self.viewVC.frame.size.width /2 - 80)/2,160, 80, 30) :@"取消" :16*Width1];
            czbut.layer.cornerRadius = 4;
    [czbut setTitleColor:[UIColor redColor] forState:0];
    czbut.layer.cornerRadius = 4;
    czbut.layer.borderWidth  = 1;
    [czbut addTarget:self action:@selector(canlActrion) forControlEvents:(UIControlEventTouchUpInside)];
    czbut.layer.borderColor = [[UIColor redColor]CGColor];
    [self.viewVC addSubview:czbut];
    
    
    UIButton *endbut = [UIButton initWithFrame:CGRectMake(self.viewVC.frame.size.width/2 + (self.viewVC.frame.size.width/2 - 80)/2, 160,80, 30) :@"确定" :16*Width1];
    [endbut setTitleColor:[UIColor whiteColor] forState:0];
     endbut.layer.cornerRadius = 4;
    endbut.layer.cornerRadius = 4;
    endbut.backgroundColor = COLOR(227, 23, 23);
    [endbut addTarget:self action:@selector(endButAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.viewVC addSubview:endbut];
    
    
    
    
    
}

-(void)endButAction{
    
    
    self.bolock(self.dic);
    [self removeFromSuperview];
    
}


-(void)canlActrion{
    
    
     [self removeFromSuperview];
    
}


-(void)onTapGR{
      [[AFN_DF topViewController].navigationController setNavigationBarHidden:NO animated:YES];
      [self removeFromSuperview];
}

@end
