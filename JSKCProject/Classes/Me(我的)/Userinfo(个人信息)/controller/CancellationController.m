//
//  CancellationController.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/29.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "CancellationController.h"
#import "loginController.h"
@interface CancellationController ()

@end

@implementation CancellationController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注销账号";
    [self setUI];
    
}

-(void)setUI{
    
    
    UIImageView *canlImage = [[UIImageView alloc]initWithFrame:CGRectMake(Width/2 - 27.5, NavaBarHeight + 50, 55, 55)];
    canlImage.image = [UIImage imageNamed:@"提示-1"];
    [self.view addSubview:canlImage];
    
    
    
    
   UILabel *tips = [UILabel initWithDFLable:CGRectMake(30, NavaBarHeight + 130, Width - 60, 40) :[UIFont systemFontOfSize:13] :COLOR2(51) :[ImageUrlModel shareInstance].logoffTips :self.view :0];
    tips.numberOfLines = 0;
    
    
    
    
    UILabel *tipstwo = [UILabel initWithDFLable:CGRectMake(30, NavaBarHeight + 190, Width - 60, 40) :[UIFont systemFontOfSize:13] :COLOR2(51) :[ImageUrlModel shareInstance].logoffConfirmTips :self.view :0];
       tipstwo.numberOfLines = 0;
    
    
    
    UIButton *canlBut = [UIButton initWithFrame:CGRectMake(50, NavaBarHeight + 280, Width - 100, 50) :@"注销账号" :16];
    canlBut.layer.cornerRadius = 4;
    [canlBut addTarget:self action:@selector(canlAction) forControlEvents:(UIControlEventTouchUpInside)];
    canlBut.backgroundColor = [UIColor redColor];
    [self.view addSubview:canlBut];
        

    
}


-(void)canlAction{
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",[ImageUrlModel shareInstance].logoffConfirmTips] delegate:self cancelButtonTitle:@"确认注销" otherButtonTitles:@"我在想想", nil];
        alert.delegate = self;
        
    [UIView appearance].tintColor= [UIColor blackColor];
              [alert show];
    
    
}



- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {

    // 获取您按下的是哪个按钮

   
    
    if (buttonIndex == 0) {
        //注销登录
        WeakSelf
        [AFN_DF POST:@"/system/account/logoff" Parameters:nil success:^(NSDictionary *responseObject) {
            
            [[UserModel shareInstance] setValuesForKeysWithDictionary:@{}];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:@{} forKey:@"user"];
            [UserModel shareInstance].accessToken = nil;
            PhoneLoginController *logVC =  [PhoneLoginController new];
            logVC.logOut = YES;
            [weakSelf.navigationController pushViewController:logVC animated:YES];
//            if ([TXCommonUtils simSupportedIsOK] && [TXCommonUtils checkDeviceCellularDataEnable]) {
//                LoginController *logVC =  [LoginController new];
//                logVC.logOut = YES;
//                [weakSelf.navigationController pushViewController:logVC animated:YES];
//            }else{
//                PhoneLoginController *logVC =  [PhoneLoginController new];
//                logVC.logOut = YES;
//                [weakSelf.navigationController pushViewController:logVC animated:YES];
//            }
            
        } failure:^(NSError *error) {
            
        }];
    }
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
