//
//  DreCarAddVC.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "DreCarAddVC.h"
#import "CarManController.h"
#import "SourceGoodController.h"
@implementation DreCarAddVC

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
    
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(40, Height/2 - 170, Width - 80 , 290)];
    back.backgroundColor = [UIColor whiteColor];
    back.layer.cornerRadius = 4;
    [self addSubview:back];
    
    
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(back.frame.size.width/2 - 35, 35, 70, 70)];
    img.image = [UIImage imageNamed:@"已有车辆"];
    [back addSubview:img];
    
    
    
    UIButton *closeBut = [UIButton initWithFrame:CGRectMake(back.frame.size.width - 30, 10, 20, 20) :@"关闭"];
     [closeBut addTarget:self action:@selector(closeAction) forControlEvents:(UIControlEventTouchUpInside)];
     [back addSubview:closeBut];
     
    [UILabel initWithDFLable:CGRectMake(0,120,back.frame.size.width, 30) :[UIFont systemFontOfSize:20*Width1] :COLOR2(51) :@"车辆已存在,是否直接添加" :back :1];
    
    NSArray *arr = @[
        [NSString stringWithFormat:@"车牌号:%@",self.dic[@"obj"][@"plateNumber"]],
     
    ];
    
    CGFloat wid = back.frame.size.width;
    for (int i = 0;  i < 1; i++) {
        
       [UILabel initWithDFLable:CGRectMake(0,170 + (25 *i), back.frame.size.width, 25) :[UIFont systemFontOfSize:13*Width1] :COLOR2(151) :arr[i] :back :1];

    }
    
    
            UIButton *deleBut = [UIButton initWithFrame:CGRectMake(10, back.frame.size.height - 70, wid/2 - 20, 40) :@"暂不添加" :16*Width1];
                                     deleBut.layer.cornerRadius = 4;
                     deleBut.layer.borderColor = [[UIColor redColor]CGColor];
                     deleBut.layer.borderWidth = 1;
                     [deleBut setTitleColor:[UIColor redColor] forState:0];
                     [deleBut addTarget:self action:@selector(closeAction) forControlEvents:(UIControlEventTouchUpInside)];
                     [back addSubview:deleBut];
     
                 UIButton *endBut = [UIButton initWithFrame:CGRectMake(wid/2 + 10, back.frame.size.height - 70,wid/2 - 20, 40) :@"直接添加" :16*Width1];
                   endBut.layer.cornerRadius = 4;
                   endBut.backgroundColor = [UIColor redColor];
                 [endBut addTarget:self action:@selector(resAction) forControlEvents:(UIControlEventTouchUpInside)];
                  [back addSubview:endBut];
    
    

    
}
  
/// 直接添加
-(void)resAction{
    
    WeakSelf
    [AFN_DF POST:@"/system/truck/driectAddDriver" Parameters:@{@"plateNumber":self.plateNumber,@"plateType":self.plateType,@"driverType":self.driverType} success:^(NSDictionary *responseObject) {
        NSInteger truckId = [responseObject[@"data"][@"truckId"]integerValue];
        if (truckId == 0) {
            truckId = [responseObject[@"data"][@"obj"][@"truckId"]integerValue];
        }
        UserModel.shareInstance.bandTruckId = @(truckId);
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        id userInfo = [user objectForKey:@"user"];
        if (userInfo && [userInfo count] > 0) {
            NSMutableDictionary *userInfoParams = [NSMutableDictionary dictionaryWithDictionary:userInfo];
            [userInfoParams setObject:@(truckId) forKey:@"bandTruckId"];
            [user setObject:userInfoParams forKey:@"user"];
            [user synchronize];
        }
        
//        for (UIViewController *vc in [[AFN_DF topViewController].navigationController viewControllers]) {
//
//            if ([vc isKindOfClass:[CarManController class]]) {
//
//
//                [self closeAction];
//                [[AFN_DF topViewController].navigationController popToViewController:vc animated:YES];
//
//                return;
//            }
//
//            if ([vc isKindOfClass:[SourceGoodController class]]) {
//
//                self.block(self.dic);
//                [self closeAction];
//                [[AFN_DF topViewController].navigationController popToViewController:vc animated:YES];
//
//                return;
//            }
//
//
//
//        }
        
        [self closeAction];
        [[AFN_DF topViewController].navigationController popToRootViewControllerAnimated:YES];
        if (UserModel.shareInstance.hasBankCard == nil || [UserModel.shareInstance.hasBankCard integerValue] == 0) {
            CardInfoVC *vc =  [[CardInfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
            vc.tag = 1;
            [UIApplication.sharedApplication.keyWindow addSubview:vc];
            return;
        }

//            [self onTapGR];
//        [[AFN_DF topViewController].navigationController popViewControllerAnimated:YES];
        
        
    } failure:^(NSError *error) {
    }];
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
