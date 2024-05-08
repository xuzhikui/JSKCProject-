//
//  CardInfoVC.m
//  JSKCProject
//
//  Created by 王宾 on 2022/4/2.
//  Copyright © 2022 孟德峰. All rights reserved.
//

#import "CardInfoVC.h"
#import "AddBandCarController.h"
@implementation CardInfoVC

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    _backVC = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
    self.backVC.backgroundColor = [UIColor blackColor];
    self.backVC.alpha = 0.5;
    UITapGestureRecognizer *TapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapGR)];
         self.backVC.userInteractionEnabled = YES;
         [ self.backVC addGestureRecognizer:TapGR];
    
    [self addSubview:self.backVC];
    
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake((Width - 255)/2,(Height - 290)*0.5f, 255, 290)];
    img.image = [UIImage imageNamed:@"cardInfo"];
    img.userInteractionEnabled = YES;
    [self addSubview:img];
    
    [UILabel initWithDFLable:CGRectMake(0, 130, 255, 20) :[UIFont systemFontOfSize:19*Width1] :[UIColor blackColor] :@"未绑定银行卡" :img :1];
    UILabel *notCerInfoLable = [UILabel initWithDFLable:CGRectMake(47.5, 170, 160, 30) :[UIFont systemFontOfSize:12] :[UIColor colorWithRed:153.0/255.0f green:153.0/255.0f blue:153.0/255.0f alpha:1] :@"抢单之前，为避免影响运费结算， 请先绑定银行卡！" :img :1];
    notCerInfoLable.numberOfLines = 0;


    UIButton *rzBut = [UIButton initWithFrame:CGRectMake(20, 230, img.frame.size.width - 40, 35) :@"立即绑卡" :15*Width1];
    rzBut.layer.cornerRadius = 4;
    rzBut.backgroundColor = [UIColor redColor];
    [rzBut addTarget:self action:@selector(rzButAction) forControlEvents:(UIControlEventTouchUpInside)];
    [img addSubview:rzBut];
}

///认证
-(void)rzButAction{
    AddBandCarController *infoVC = [AddBandCarController new];
 //    infoVC.hidesBottomBarWhenPushed = YES;
     [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
    [self canlAction];
}

-(void)canlAction{
    
    [self onTapGR];
    
}


-(void)onTapGR{
//      [[AFN_DF topViewController].navigationController setNavigationBarHidden:YES animated:YES];
      [self removeFromSuperview];
}


@end
