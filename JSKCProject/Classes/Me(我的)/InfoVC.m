//
//  InfoVC.m
//  JSKCProject
//
//  Created by 孟德峰 on 2020/12/30.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "InfoVC.h"
#import "InfoController.h"
#import "DriverCertificationViewController.h"
#import "InfoAuthViewController.h"

@implementation InfoVC

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
    
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake((Width - 255)/2, 170, 255, 130)];
    img.image = [UIImage imageNamed:@"info"];
    [self addSubview:img];
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake((Width - 255)/2, 295, 255, 175)];
    back.backgroundColor = [UIColor whiteColor];
    back.layer.cornerRadius = 8;
    [self addSubview:back];
    
    
    [UILabel initWithDFLable:CGRectMake(0, 0, 255, 20) :[UIFont systemFontOfSize:19*Width1] :[UIColor blackColor] :@"您尚未完成身份认证" :back :1];
    UILabel *notCerInfoLable = [UILabel initWithDFLable:CGRectMake(47.5, 40, 160, 30) :[UIFont systemFontOfSize:12] :[UIColor colorWithRed:153.0/255.0f green:153.0/255.0f blue:153.0/255.0f alpha:1] :@"请先提交认证资料、绑定车辆， 完成后即可接单！" :back :1];
    notCerInfoLable.numberOfLines = 0;
//        NSArray *arr = @[
//            @"海量货源等你抢单",
//            @"随时随地提现运费",
//            @"快捷管理车队和车辆",
//    ];
//
//    for (int i = 0; i < 3; i++) {
//
//
//        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(60, 52.5 + (25 * i), 10, 10)];
//        img.image = [UIImage imageNamed:@"info选中"];
//        [back addSubview:img];
//
//        [UILabel initWithDFLable:CGRectMake(80,  50 + (25 * i), 150, 15) :[UIFont systemFontOfSize:12*Width1] :[UIColor blackColor] :arr[i] :back :0];
//    }

    UIButton *rzBut = [UIButton initWithFrame:CGRectMake(20, 95, back.frame.size.width - 40, 35) :@"立即认证" :15*Width1];
    rzBut.layer.cornerRadius = 4;
    rzBut.backgroundColor = [UIColor redColor];
    [rzBut addTarget:self action:@selector(rzButAction) forControlEvents:(UIControlEventTouchUpInside)];
    [back addSubview:rzBut];
    
    UIButton *canlBut = [UIButton initWithFrame:CGRectMake(20, 135, back.frame.size.width - 40, 35) :@"以后再说" :15*Width1];
    canlBut.layer.cornerRadius = 4;
    [canlBut addTarget:self action:@selector(canlAction) forControlEvents:(UIControlEventTouchUpInside)];
    canlBut.backgroundColor = [UIColor whiteColor];
    [canlBut setTitleColor:COLOR2(119) forState:0];
    [back addSubview:canlBut];
    
}

///认证
-(void)rzButAction{
    if (UserModel.shareInstance.type == 1) {
        InfoController *infoVC = [InfoController new];
        [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
    }else{
        InfoAuthViewController *infoVC = [InfoAuthViewController new];
        [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
    }
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
