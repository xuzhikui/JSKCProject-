//
//  MeController.m
//  JSKCProject
//
//  Created by XHJ on 2020/9/17.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "MeController.h"
#import "HomeClassView.h"
#import "HomeClassView.h"
#import "InfoController.h"
#import "payController.h"
#import "SuppMoenyController.h"
#import "DetailedController.h"
#import "loginController.h"
#import "AddBandCarController.h"
#import "InfoAuthViewController.h"

@interface MeController ()
{
    HomeClassView *classVC;
}
@property(nonatomic,strong)UIImageView *porImg;///头像
@property(nonatomic,strong)UIImageView *backVC;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *accLab;
@property(nonatomic,strong)UIButton *remoBut;
@property(nonatomic,strong)UILabel *payLab;
@end

@implementation MeController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.tabBarController.tabBar.hidden = NO;

  
    if ([UserModel shareInstance].accessToken != nil) {
        
        
    }
   
    if ([UserModel shareInstance] && [UserModel shareInstance].accessToken != nil) {
        [self postNUmmeass];
        [self getUserInfo];
//         [self setdata];
    }else{
        
        _porImg.image = [UIImage imageNamed:@"默认头像"];
        _nameLab.text = @"未登录";
        self.accLab.text = @"";
        [_remoBut setImage:[UIImage imageNamed:@"用户未认证"] forState:0];
    }
    [classVC reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    _backVC =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, 240)];
    self.backVC.image = [UIImage imageNamed:@"多边形 1 拷贝 2"];
    self.backVC.contentMode = UIViewContentModeScaleAspectFill;
    self.backVC.layer.masksToBounds = YES;
    self.backVC.userInteractionEnabled = YES;
    [self.view addSubview:self.backVC];
    [self.backVC addSubview:self.porImg];
    [self.backVC addSubview:self.remoBut];
    self.nameLab.textColor = [UIColor whiteColor];
    self.accLab.text = @"";
    

    
    UIView *payVC = [[UIView alloc]initWithFrame:CGRectMake(33, 209, Width - 66, 120)];
    payVC.backgroundColor = [UIColor whiteColor];
    payVC.layer.cornerRadius = 4;
    [self.view addSubview:payVC];
    
  
    
    NSArray *imagearr = @[@"明细-01 拷贝",@"余额-01 拷贝",@"提现-1"];
     NSArray *titArray = @[@"交易明细",@"余额 0.00元",@"提现余额"];
    CGFloat wid = payVC.frame.size.width;
    
    UIView *hfg = [[UIView alloc]initWithFrame:CGRectMake(0,payVC.frame.size.height - 41, wid, 1)];
    hfg.backgroundColor = COLOR2(220);
    [payVC addSubview:hfg];
    
    UIView *vfg = [[UIView alloc]initWithFrame:CGRectMake(payVC.frame.size.width/2 - 0.5,payVC.frame.size.height - 41, 1, 40)];
    vfg.backgroundColor = COLOR2(220);
    [payVC addSubview:vfg];
    
    UIButton *paybut =  [UIButton initWithFrame:CGRectMake(wid - 150, 10, 140, 25) :@"我的钱包>>" : 13*Width1];
    [paybut addTarget:self action:@selector(payButAction) forControlEvents:(UIControlEventTouchUpInside)];
    paybut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [paybut setTitleColor:COLOR2(85) forState:0];
    [payVC addSubview:paybut];
    
    
    
    
    UIImageView *yeImg = [[UIImageView alloc]initWithFrame:CGRectMake(30, 20, 50, 50)];
    yeImg.image = [UIImage imageNamed:@"余额s1"];
    [payVC addSubview:yeImg];
    
  
    
    
    self.payLab = [UILabel initWithDFLable:CGRectMake(85, 40, 200, 20) :[UIFont systemFontOfSize:15*Width1] :COLOR2(61) :@"余额：0.00元" :payVC :0];
    
    if ([UserModel shareInstance].balance) {
        self.payLab.text = [NSString stringWithFormat:@"余额：%@元",[UserModel shareInstance].balance];
        
    }
    
    
    UIButton *txBut = [UIButton initWithFrame:CGRectMake(0, payVC.frame.size.height - 40, wid/2, 40) :@"提现" :13*Width1];
    [txBut setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [txBut setTitleColor:[UIColor blackColor] forState:0];
[txBut addTarget:self action:@selector(txAction) forControlEvents:(UIControlEventTouchUpInside)];
    [txBut setImage:[UIImage imageNamed:imagearr[2]] forState:0];
    [payVC addSubview:txBut];
    
    
    
    UIButton *mxBut = [UIButton initWithFrame:CGRectMake(wid/2, payVC.frame.size.height - 40, wid/2, 40) :@"明细" :13*Width1];
    [mxBut setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [mxBut setImage:[UIImage imageNamed:imagearr[0]] forState:0];
    [mxBut addTarget:self action:@selector(mxButAction) forControlEvents:(UIControlEventTouchUpInside)];
    [mxBut setTitleColor:[UIColor blackColor] forState:0];
    [payVC addSubview:mxBut];
    

    
//    for (int i = 0; i < 3; i++) {
//
//        UIButton *sendBut = [UIButton initWithFrame:CGRectMake(wid/3*i + (wid/3 - 30 )/2,30, 30,30) :imagearr[i]];
//        [payVC addSubview:sendBut];
//
//         [UILabel initWithDFLable:CGRectMake(wid/3*i ,65, wid/3,20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(68) :titArray[i] :payVC :1];
//
//    }
//
      
    [UILabel initWithDFLable:CGRectMake(20, 350, Width, 20) :[UIFont systemFontOfSize:22*Width1] :[UIColor blackColor] :@"常用功能" :self.view :0];
    
    
    classVC = [[HomeClassView alloc]initWithFrame:CGRectMake(0, 390, Width, 240)];
    classVC.backgroundColor = [UIColor clearColor];
    [self.view addSubview:classVC];
}

-(void)mxButAction{
    
    if ([UserModel shareInstance].accessToken == nil) {
//        if ([TXCommonUtils simSupportedIsOK] && [TXCommonUtils checkDeviceCellularDataEnable]) {
//            LoginController *logVC =  [LoginController new];
//            [self.navigationController pushViewController:logVC animated:YES];
//        }else{
//            PhoneLoginController *logVC =  [PhoneLoginController new];
////            logVC.code = @"1";
//            [self.navigationController pushViewController:logVC animated:YES];
//        }
        PhoneLoginController *logVC =  [PhoneLoginController new];
//            logVC.code = @"1";
        [self.navigationController pushViewController:logVC animated:YES];
        return;
    }
    
    
    if ([[NSString stringWithFormat:@"%@",[UserModel shareInstance].cyrVerify] isEqualToString:@"0"]) {
        
        InfoVC *infoVC = [[InfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        infoVC.tag = 1;
        [UIApplication.sharedApplication.keyWindow addSubview:infoVC];

        return;
    }
    
    DetailedController *detVC = [DetailedController new];
    [self.navigationController pushViewController:detVC animated:YES];
}


-(void)txAction{
    
    if ([UserModel shareInstance].accessToken == nil) {
//        if ([TXCommonUtils simSupportedIsOK] && [TXCommonUtils checkDeviceCellularDataEnable]) {
//            LoginController *logVC =  [LoginController new];
//            [self.navigationController pushViewController:logVC animated:YES];
//        }else{
//            PhoneLoginController *logVC =  [PhoneLoginController new];
////            logVC.code = @"1";
//            [self.navigationController pushViewController:logVC animated:YES];
//        }
        PhoneLoginController *logVC =  [PhoneLoginController new];
//            logVC.code = @"1";
        [self.navigationController pushViewController:logVC animated:YES];
        return;
    }
    
    
    if ([[NSString stringWithFormat:@"%@",[UserModel shareInstance].cyrVerify] isEqualToString:@"0"]) {
        
        InfoVC *infoVC = [[InfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        infoVC.tag = 1;
        [UIApplication.sharedApplication.keyWindow addSubview:infoVC];

        return;
    }
    
    if (UserModel.shareInstance.hasBankCard != nil && UserModel.shareInstance.hasBankCard.integerValue != 0) {
        SuppMoenyController *suVC = [SuppMoenyController new];
        [self.navigationController pushViewController:suVC animated:YES];
    }else{
        AddBandCarController *addBandCarVC = [AddBandCarController new];
        [self.navigationController pushViewController:addBandCarVC animated:YES];
    }
    
}

///我的钱包
-(void)payButAction{
   
    
    if ([UserModel shareInstance].accessToken == nil) {
//        if ([TXCommonUtils simSupportedIsOK] && [TXCommonUtils checkDeviceCellularDataEnable]) {
//            LoginController *logVC =  [LoginController new];
//            [self.navigationController pushViewController:logVC animated:YES];
//        }else{
//            PhoneLoginController *logVC =  [PhoneLoginController new];
////            logVC.code = @"1";
//            [self.navigationController pushViewController:logVC animated:YES];
//        }
        PhoneLoginController *logVC =  [PhoneLoginController new];
//            logVC.code = @"1";
        [self.navigationController pushViewController:logVC animated:YES];
        return;
    }
    
    if ([[NSString stringWithFormat:@"%@",[UserModel shareInstance].cyrVerify] isEqualToString:@"0"]) {
        
        InfoVC *infoVC = [[InfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        infoVC.tag = 1;
        [UIApplication.sharedApplication.keyWindow addSubview:infoVC];
        return;
    }
    
    payController *payVC = [payController new];
    [self.navigationController pushViewController:payVC animated:YES];
    
}

- (UILabel *)accLab{
    
    if (_accLab == nil) {
           
           _accLab = [UILabel initWithDFLable:CGRectMake(50, 179, Width - 100, 14) :[UIFont systemFontOfSize:15*Width1] :[UIColor whiteColor] :@"" :_backVC :1];
       }
       
       return _accLab;
    
}


-(UILabel *)nameLab{
    
    if (_nameLab == nil) {
        
        _nameLab = [UILabel initWithDFLable:CGRectMake(50, 147, Width - 100, 21) :[UIFont systemFontOfSize:22*Width1] :[UIColor whiteColor] :@"未登录" :_backVC :1];
    }
    
    return _nameLab;
    
}

-(UIImageView *)porImg{
    
    if (_porImg == nil) {
        _porImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width/2 - 35.5, 61, 71, 71)];
        _porImg.layer.cornerRadius = 35.5;
        _porImg.layer.masksToBounds = YES;
        _porImg.image = [UIImage imageNamed:@"默认头像"];
        _porImg.layer.cornerRadius = _porImg.frame.size.height/2;
      
    }
    
    return _porImg;
}


-(UIButton *)remoBut{
    
     if (_remoBut == nil) {
         _remoBut = [UIButton initWithFrame:CGRectMake(Width - 98,  40, 100, 27) :@"用户未认证"];
         [_remoBut addTarget:self action:@selector(remoAction) forControlEvents:(UIControlEventTouchUpInside)];
        }
        
        return _remoBut;
    
    
}


///认证
-(void)remoAction{
    
    if ([UserModel shareInstance].accessToken == nil) {
//        if ([TXCommonUtils simSupportedIsOK] && [TXCommonUtils checkDeviceCellularDataEnable]) {
//            LoginController *logVC =  [LoginController new];
//            [[AFN_DF topViewController].navigationController pushViewController:logVC animated:YES];
//        }else{
//            PhoneLoginController *logVC =  [PhoneLoginController new];
//            [[AFN_DF topViewController].navigationController pushViewController:logVC animated:YES];
//        }  
        PhoneLoginController *logVC =  [PhoneLoginController new];
        [[AFN_DF topViewController].navigationController pushViewController:logVC animated:YES];
          return;
      }
    
    UserModel *userInfo = [UserModel shareInstance];
    if ([[NSString stringWithFormat:@"%@",userInfo.cyrVerify] isEqualToString:@"1"]) {
        
        InfoAuthViewController *infoVC = [InfoAuthViewController new];
        infoVC.cyrVerify = [NSString stringWithFormat:@"%@",UserModel.shareInstance.cyrVerify];
        [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
    }else if ([[NSString stringWithFormat:@"%@",userInfo.cyrVerify] isEqualToString:@"0"]){
        InfoAuthViewController *infoVC = [InfoAuthViewController new];
        infoVC.cyrVerify = [NSString stringWithFormat:@"%@",UserModel.shareInstance.cyrVerify];
        [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
    }else{
        if (userInfo.type == 1) {
            InfoController *infoVC = [InfoController new];
            infoVC.cyrVerify = [NSString stringWithFormat:@"%@",userInfo.cyrVerify];
            [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
        }else{
            InfoAuthViewController *infoVC = [InfoAuthViewController new];
            infoVC.cyrVerify = [NSString stringWithFormat:@"%@",userInfo.cyrVerify];
            [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
        }
    }
}

-(void)getUserInfo{
    WeakSelf
    [AFN_DF POST:@"/system/account/getUserInfo" Parameters:nil success:^(NSDictionary *responseObject) {
        
        [[UserModel shareInstance]setValuesForKeysWithDictionary:responseObject[@"data"]];
             
                NSDictionary *dic = responseObject[@"data"];
            id info = [PNSBuildModelUtils deleteEmpty:dic];

                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:info forKey:@"user"];
      
                [weakSelf setdata];
        [self->classVC reloadData];

    } failure:^(NSError *error) {
        
    }];
    
    
}


-(void)setdata{
    
    self.nameLab.text = [UserModel shareInstance].name;
              
             NSString *str1 = [[UserModel shareInstance].username substringToIndex:3];
             NSString *str2 = [[UserModel shareInstance].username substringFromIndex:7];
             self.accLab.text = [NSString stringWithFormat:@"账号: %@****%@",str1,str2];
         [self.porImg sd_setImageWithURL:[NSURL URLWithString:[UserModel shareInstance].headurl] placeholderImage:[UIImage imageNamed:@"默认头像"]];
         
          self.remoBut.userInteractionEnabled = YES;
         NSInteger cyrVerify = [[NSString stringWithFormat:@"%@",[UserModel shareInstance].cyrVerify]integerValue];
         if (cyrVerify == 1) {
             [self.remoBut setImage:[UIImage imageNamed:@"用户已认证"] forState:0];
             self.remoBut.userInteractionEnabled = NO;
         }else if (cyrVerify == 2){
                [self.remoBut setImage:[UIImage imageNamed:@"身份认证失败"] forState:0];
         }
         else if (cyrVerify == 3){
                 [self.remoBut setImage:[UIImage imageNamed:@"身份证已过期"] forState:0];
         }
         else if (cyrVerify == 4){
                 [self.remoBut setImage:[UIImage imageNamed:@"身份证即将过期"] forState:0];
                  
         }
         else if (cyrVerify == 0){
                 [self.remoBut setImage:[UIImage imageNamed:@"用户未认证"] forState:0];
         }
         else if (cyrVerify == 5){
                 [self.remoBut setImage:[UIImage imageNamed:@"身份审核中"] forState:0];
         }
   
        self.payLab.text = [NSString stringWithFormat:@"余额：%@元",[UserModel shareInstance].balance];
 
}



- (UIImage *)imageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0, 0, 1, 1);

    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);

    [color setFill];

    UIRectFill(rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return image;

}

-(void)postNUmmeass{

    
    [AFN_DF POST:@"/system/mess/getUnreadCount" Parameters:nil success:^(NSDictionary *responseObject) {

        NSLog(@"%@",responseObject);


        NSString *tag = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"unread"]];



        if ([tag isEqualToString:@"0"]) {
        
            self->classVC.code = @"0";
            
        }else{

            self->classVC.code = @"1";
            
            
        }


        [self->classVC.collectVC reloadData];


    } failure:^(NSError *error) {

    }];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
