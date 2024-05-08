//
//  LoginController.m
//  JSKCProject
//
//  Created by 孟德峰 on 2020/9/12.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "LoginController.h"
#import "PhoneLoginController.h"
#import <ATAuthSDK/TXCommonHandler.h>//;
#import "PNSHttpsManager.h"
#import "PNSBuildModelUtils.h"
#import "MainController.h"
#import "PhoneLoginController.h"
#import "UIOffsetButton.h"
#import "JurisdictionController.h"

#define YBAlertShow(messageText,buttonName) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:(messageText) \
delegate:nil cancelButtonTitle:(buttonName) otherButtonTitles: nil];\
[alert show];
@interface LoginController ()
@property(nonatomic,strong)UITextField *phoneTF;//手机号
@property(nonatomic,strong)UITextView *textView;
@property (nonatomic, assign) BOOL isCanUseOneKeyLogin;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)UIButton *identityButton;

@end

@implementation LoginController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

- (void)viewDidLoad{
    [super viewDidLoad];
    [NSUserDefaults.standardUserDefaults setInteger:0 forKey:LoginIdentityKey];
    [NSUserDefaults.standardUserDefaults synchronize];
    self.view.backgroundColor = UIColor.whiteColor;
    [self getonecloick];
}


-(void)getonecloick{
    CGFloat heig = Height > 735 ? 1 : Height1;
    
        
           TXCustomModel *model = [[TXCustomModel alloc] init];
            model.navIsHidden = YES;
    model.logoImage = [UIImage imageNamed:@"去底色logo 拷贝"];
    model.loginBtnBgImgs = @[[TXCommonUtils imageWithColor:COLOR(245, 12, 12) size:CGSizeMake(280, 44) isRoundedCorner:YES radius:5],[TXCommonUtils imageWithColor:COLOR(245, 12, 12) size:CGSizeMake(280, 44) isRoundedCorner:YES radius:5],[TXCommonUtils imageWithColor:COLOR(245, 12, 12) size:CGSizeMake(280, 44) isRoundedCorner:YES radius:5]];
    
//    model.logoImage = [UIImage imageNamed:@"去底色logo 拷贝"];

   model.logoFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
    frame.size.width = 87;
                                  frame.size.height = 128*heig;
                                  frame.origin.y =110;
                                  frame.origin.x = (Width-87)/2;
                      
                   
         return frame;

     };
    
    model.sloganFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        
                frame.size.width =Width;
                              frame.size.height = 20*heig;
                              frame.origin.y = 335*heig;
                              frame.origin.x = 0;
                           
          return frame;
    };
    
    


        model.numberColor = [UIColor blackColor];
        model.numberFont = [UIFont boldSystemFontOfSize:30*Width1];
        
    model.numberFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
      
        frame.size.width = Width;
               frame.origin.y = 291*heig;
            
          return frame;
        };
    

    model.loginBtnFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
         frame.size.width = 280;
            frame.origin.x = (Width-280)*0.5f;
             frame.origin.y = 400*heig;
        frame.size.height = 44.0f;
                
        return frame;
    };
    

//    model.loginBtnBgImgs = @[[UIImage imageNamed:@"未标题-1-1"],[UIImage imageNamed:@"未标题-1-1"],[UIImage imageNamed:@"未标题-1-1"]];
    
    NSMutableAttributedString *textFont = [[NSMutableAttributedString alloc] initWithString:@"本机号码一键登录"];

    [textFont addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:16.0*Width1]
                        range:[@"本机号码一键登录" rangeOfString:@"本机号码一键登录"]];
    
    [textFont addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 8)];
        model.loginBtnText = textFont;

    
        model.changeBtnIsHidden = YES;
    
    UIButton *unclickBut = [UIButton initWithFrame:CGRectMake((Width-280)*0.5f, 460*heig,280, 44) :@"其他手机号码登录" :16*Width1];

       unclickBut.layer.masksToBounds = YES;
      [unclickBut setTitleColor:COLOR2(154) forState:0];
      unclickBut.backgroundColor = COLOR(247, 248, 250);
     [unclickBut addTarget:self action:@selector(toOtherPhoneLoginFunction) forControlEvents:(UIControlEventTouchUpInside)];
    unclickBut.layer.cornerRadius = 5;
    
    
   UIButton *kfphoneTipsBut = [UIButton initWithFrame:CGRectMake(50, Height - 60, Width -100, 20) :@"服务投诉电话" :12*Width1];
       [ kfphoneTipsBut setTitleColor:[UIColor grayColor] forState:0];
        [kfphoneTipsBut addTarget:self action:@selector(phoneAction) forControlEvents:(UIControlEventTouchUpInside)];
         
         UIButton *phoneBut = [UIButton initWithFrame:CGRectMake(50, Height - 40, Width -100, 20) :[ImageUrlModel shareInstance].csPhone :11*Width1];
         [phoneBut setTitleColor:[UIColor redColor] forState:0];
        [phoneBut addTarget:self action:@selector(phoneAction) forControlEvents:(UIControlEventTouchUpInside)];
         [phoneBut setImage:[UIImage imageNamed:@"电话2-1"] forState:0];
    
    
  UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, Height - 200*heig, Width, 200*heig)];
       backImg.image = [UIImage imageNamed:@"圆角矩形 4 拷贝 2"];
    
    _identityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _identityButton.frame = CGRectMake(Width-45.0f, StatusBarHeight+10.0f, 30, 30);
    [_identityButton setImage:[UIImage imageNamed:@"更换身份"] forState:UIControlStateNormal];
    [_identityButton setImage:[UIImage imageNamed:@"更换身份"] forState:UIControlStateSelected];
    [_identityButton setImage:[UIImage imageNamed:@"更换身份"] forState:UIControlStateHighlighted];
    _identityButton.hidden = YES;
    [_identityButton addTarget:self action:@selector(switchIdentityFunction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *clanBut = [UIButton initWithFrame:CGRectMake(16,  StatusBarHeight + 17, 18, 18) :@"关闭 拷贝"];
    [clanBut addTarget:self action:@selector(clanAction) forControlEvents:(UIControlEventTouchUpInside)];

    model.customViewBlock = ^(UIView * _Nonnull superCustomView) {
          [superCustomView addSubview:backImg];
        [superCustomView addSubview:kfphoneTipsBut];
        [superCustomView addSubview:phoneBut];
        [superCustomView addSubview:unclickBut];
        [superCustomView addSubview:self.identityButton];
        if (![[self.navigationController.viewControllers firstObject] isEqual:self]) {
            [superCustomView addSubview:clanBut];
        }
    };
    model.checkBoxImages = @[[UIImage imageNamed:@"protocolUnSelected"],[UIImage imageNamed:@"protocolSelected"]];
    model.checkBoxIsChecked = YES;
    model.privacyOne = @[@"《用户服务协议》",@"https://kcwl-pro-oss.jskc56.com/jskcwl_file/jsyx_file/agreement.html"];
    model.privacyTwo = @[@"《隐私条款》",@"https://kcwl-pro-oss.jskc56.com/jskcwl_file/jsyx_file/agreement.html"];
    model.privacyFont = [UIFont systemFontOfSize:11*Width1];
    model.privacyPreText = @"为保障您的个人隐私权益，请仔细阅读";
    model.privacyColors = @[[UIColor grayColor],[UIColor redColor]];
        model.privacyOperatorPreText = @"《";
     model.privacyOperatorSufText = @"》";
    

    model.privacyFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
      
        frame.origin.y = 520*heig;
        frame.size.width = 280;
        frame.origin.x = (Width-280)*0.5f;
        return frame;
    };
    model.animationDuration = 0.0f;
        WeakSelf
       [[TXCommonHandler sharedInstance] getLoginTokenWithTimeout:3.0
                                                       controller:self.navigationController
                                                                   model:model
                                                                complete:^(NSDictionary * _Nonnull resultDic) {
                  NSString *resultCode = [resultDic objectForKey:@"resultCode"];
                  if ([PNSCodeLoginControllerPresentSuccess isEqualToString:resultCode]) {
                      NSLog(@"授权页拉起成功回调：%@", resultDic);
                     
                  } else if ([PNSCodeLoginControllerClickCancel isEqualToString:resultCode] ||
                             [PNSCodeLoginControllerClickChangeBtn isEqualToString:resultCode] ||
                             [PNSCodeLoginControllerClickLoginBtn isEqualToString:resultCode] ||
                             [PNSCodeLoginControllerClickCheckBoxBtn isEqualToString:resultCode] ||
                             [PNSCodeLoginControllerClickProtocol isEqualToString:resultCode]) {
                      NSLog(@"页面点击事件回调：%@", resultDic);
                   
                  } else if ([PNSCodeSuccess isEqualToString:resultCode]) {
                      NSLog(@"获取LoginToken成功回调：%@", resultDic);
                      NSString *token = [resultDic objectForKey:@"token"];
                      weakSelf.token = token;
                    
                      [weakSelf postLogin];
                  } else {
                      NSLog(@"获取LoginToken或拉起授权页失败回调：%@", resultDic);
                    
                  }
              }];

    [self getLoginType];
}


-(void)postLogin{
    [NSUserDefaults.standardUserDefaults setInteger:self.identityButton.selected forKey:LoginIdentityKey];
    [NSUserDefaults.standardUserDefaults synchronize];
    WeakSelf
    [AFN_DF POST:@"/reg/regoneclick" Parameters:@{@"token":self.token} success:^(NSDictionary *responseObject) {
        
               NSDictionary *dic = responseObject[@"data"];
           id info = [PNSBuildModelUtils deleteEmpty:dic];
        [[UserModel shareInstance]setValuesForKeysWithDictionary:dic];
        [[TXCommonHandler sharedInstance]cancelLoginVCAnimated:YES complete:nil];
        [NSNotificationCenter.defaultCenter postNotificationName:RefreHomeDataNotification object:nil];
        [weakSelf.navigationController pushViewController:[MainController new] animated:YES];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:info forKey:@"user"];
        
    } failure:^(NSError *error) {
        
    }];
    
}
- (void)switchIdentityFunction{
    self.identityButton.selected = !self.identityButton.selected;
}

-(void)clanAction{
    [NSUserDefaults.standardUserDefaults setInteger:0 forKey:LoginIdentityKey];
    [NSUserDefaults.standardUserDefaults synchronize];
    [[TXCommonHandler sharedInstance]cancelLoginVCAnimated:YES complete:nil];
    if (self.logOut) {
        self.navigationController.tabBarController.selectedIndex = 0;
    }
    if ([[self.navigationController.viewControllers firstObject] isEqual:self] || [[self.navigationController.viewControllers firstObject] isKindOfClass:JurisdictionController.class]) {
        [self.navigationController pushViewController:[MainController new] animated:YES];
    }else
        [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)phoneAction{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4000777956"]];
}

- (void)toOtherPhoneLoginFunction{
    [NSUserDefaults.standardUserDefaults setInteger:0 forKey:LoginIdentityKey];
    [NSUserDefaults.standardUserDefaults synchronize];
    
    [[TXCommonHandler sharedInstance]cancelLoginVCAnimated:YES complete:nil];
    PhoneLoginController *phoneVC = [PhoneLoginController new];
    phoneVC.oneclickLoginInto = YES;
    phoneVC.showIdentityButton = !self.identityButton.hidden;
    if ([[self.navigationController.viewControllers firstObject] isEqual:self] || [[self.navigationController.viewControllers firstObject] isKindOfClass:JurisdictionController.class]) {
        phoneVC.code = @"1";
    }
    [self.navigationController pushViewController:phoneVC animated:NO];
}

- (void)getLoginType{
    WeakSelf
    [AFN_DF POST:@"/public/getAppLoginType" Parameters:nil success:^(NSDictionary *responseObject) {
        if ([responseObject[@"data"][@"appLoginType"] integerValue] == 1) {
            weakSelf.identityButton.hidden = NO;
        }
        
    } failure:^(NSError *error) {
        
    }];
}

@end
