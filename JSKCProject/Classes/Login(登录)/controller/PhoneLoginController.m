//
//  PhoneLoginController.m
//  JSKCProject
//
//  Created by XHJ on 2020/9/15.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "PhoneLoginController.h"
#import "CodeController.h"
#import "LoginController.h"
#import <ATAuthSDK/TXCommonHandler.h>//;
#import "PNSHttpsManager.h"
#import "PNSBuildModelUtils.h"
#import "HomeController.h"
#import "HomeController.h"
#import "MainController.h"
#import "UIOffsetButton.h"

@interface PhoneLoginController ()<UITextViewDelegate>
{
//    TXCustomModel *model;
}
@property(nonatomic,strong)UITextField *phoneTF;//手机号
@property(nonatomic,strong)UITextView *textView;
@property (nonatomic, assign) BOOL isCanUseOneKeyLogin;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)UIButton *identityButton;
@end

@implementation PhoneLoginController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      self.tabBarController.tabBar.hidden = YES;
//    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR2(255);
       
   
       [self setUI];
    
}


-(void)phoneAction{
//    [ImageUrlModel shareInstance].csPhone
    
      [[UIApplication   sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[ImageUrlModel shareInstance].csPhone]]];
    

}
 

-(void)setUI{
    
    _identityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _identityButton.frame = CGRectMake(Width-45, StatusBarHeight+10, 30, 30);
    [_identityButton setImage:[UIImage imageNamed:@"更换身份"] forState:UIControlStateNormal];
    [_identityButton setImage:[UIImage imageNamed:@"更换身份"] forState:UIControlStateSelected];
    [_identityButton setImage:[UIImage imageNamed:@"更换身份"] forState:UIControlStateHighlighted];
    [_identityButton addTarget:self action:@selector(switchIdentityFunction) forControlEvents:UIControlEventTouchUpInside];
    _identityButton.hidden = YES;
    [self.view addSubview:_identityButton];
    
    UIButton *clanBut = [UIButton initWithFrame:CGRectMake(16,  StatusBarHeight + 17, 18, 18) :@"关闭 拷贝"];
    [clanBut addTarget:self action:@selector(clanAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:clanBut];

    UIImageView *logoVC = [[UIImageView alloc]initWithFrame:CGRectMake(43, 109, 136,43)];
    
    logoVC.image = [UIImage imageNamed:@"快成物流透明"];
//    [logoVC sd_setImageWithURL:[NSURL URLWithString:[ImageUrlModel shareInstance].yzmdlLogo]];
    [self.view addSubview:logoVC];
 
    
    [UILabel initWithDFLable:CGRectMake(42, 266, 300, 20) :[UIFont systemFontOfSize:12*Width1] :COLOR2(102) :@"未注册用户验证后即完成注册" :self.view :0];
    
    
    UIView *phoneVC = [[UIView alloc]initWithFrame:CGRectMake(43, 295, Width - (43* 2), 45)];
    phoneVC.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneVC];
    phoneVC.layer.cornerRadius = 4;
    phoneVC.layer.masksToBounds = YES;
    phoneVC.layer.borderWidth = 1;
    phoneVC.layer.borderColor = [COLOR(255, 218, 217)CGColor];
    
    _phoneTF  = [[UITextField alloc]initWithFrame:CGRectMake(10, 7.5, Width - 120, 30)];
    _phoneTF.placeholder = @"请输入手机号码";
    _phoneTF.font = [UIFont systemFontOfSize:15*Width1];
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [phoneVC addSubview:_phoneTF];
    
    UIButton *canlBut = [UIButton initWithFrame:CGRectMake(phoneVC.frame.size.width - 30, 15, 15, 15) :@"关1-01-1"];
    [canlBut addTarget:self action:@selector(canlButAction) forControlEvents:(UIControlEventTouchUpInside)];
    [phoneVC addSubview:canlBut];
    
    UIButton *getcodeBut = [UIButton initWithFrame:CGRectMake((Width-( Width - 86))/2, 361, Width -86, 45) :@"获取验证码" :16*Width1];
    [self.view addSubview:getcodeBut];
    getcodeBut.layer.cornerRadius = 4;
    [getcodeBut addTarget:self action:@selector(getCodeAction) forControlEvents:(UIControlEventTouchUpInside)];
    getcodeBut.layer.masksToBounds = YES;
    getcodeBut.backgroundColor = COLOR(230, 48, 36);
    [self.view addSubview:getcodeBut];
    
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, Height - 200, Width, 200)];
         backImg.image = [UIImage imageNamed:@"圆角矩形 4 拷贝 2"];
         [self.view addSubview:backImg];
    
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 430, Width,30)];
    _textView.font = [UIFont systemFontOfSize:12*Width1];
    _textView.textColor = COLOR2(154);
    _textView.textAlignment = 1;
    _textView.text = @"登录代表您已同意《用户服务协议》和《隐私条款》";
    [self.view addSubview:_textView];
    [self setfwb:_textView :0 :0];

  UILabel *kfphoneTipsLab = [[UILabel alloc]initWithFrame:CGRectMake(0, Height - 55, Width, 15)];
     kfphoneTipsLab.font = [UIFont systemFontOfSize:12*Width1];
     kfphoneTipsLab.textColor = COLOR2(102);
     kfphoneTipsLab.textAlignment = 1;
     kfphoneTipsLab.text = @"服务投诉电话";
    kfphoneTipsLab.userInteractionEnabled = YES;
    [kfphoneTipsLab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneAction)]];
     [self.view addSubview:kfphoneTipsLab];
     
     
     UIButton *phoneBut = [UIButton initWithFrame:CGRectMake(50, Height - 40, Width -100, 20) :[ImageUrlModel shareInstance].csPhone :11*Width1];
     [phoneBut setTitleColor:[UIColor redColor] forState:0];
     [self.view addSubview:phoneBut];
    [phoneBut addTarget:self action:@selector(phoneAction) forControlEvents:(UIControlEventTouchUpInside)];
     [phoneBut setImage:[UIImage imageNamed:@"电话2-1"] forState:0];
    if (!self.oneclickLoginInto) {
        [self getLoginType];
    }else
        self.identityButton.hidden = !self.showIdentityButton;
}


-(void)senAction{
    
    
    NSLog(@"112");
    
    
    
}


-(void)canlButAction{
    
    _phoneTF.text = @"";
    
}

-(void)clanAction{
    [NSUserDefaults.standardUserDefaults setInteger:0 forKey:LoginIdentityKey];
    [NSUserDefaults.standardUserDefaults synchronize];
    if (self.logOut) {
        self.navigationController.tabBarController.selectedIndex = 0;
    }
    if ([self.code isEqualToString:@"1"]) {
        [self.navigationController pushViewController:[MainController new] animated:YES];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(void)getCodeAction{
    
        [self.view endEditing:YES];
    
//    self.phoneTF.text = @"17766095158";
//    self.phoneTF.text = @"18669608086";
    if ([self.phoneTF.text isEqualToString:@""] ) {
        
        
        return [self.view addSubview:[Toast makeText:@"手机号不能为空"]];
    }
    
    if (self.phoneTF.text.length != 11) {
        
        return [self.view addSubview:[Toast makeText:@"请输入正确手机号"]];
        
    }
    [NSUserDefaults.standardUserDefaults setInteger:self.identityButton.selected forKey:LoginIdentityKey];
    [NSUserDefaults.standardUserDefaults synchronize];
    WeakSelf
    [AFN_DF POST:@"/reg/sendsms" Parameters:@{@"phone":self.phoneTF.text} success:^(NSDictionary *responseObject) {
        
//        idcardState
        ///承运人身份证状态，0、正常，1、过期，2、即将过期
        
        [weakSelf.view addSubview:[Toast makeText:@"发送验证码成功"]];
        CodeController *codeVC = [CodeController new];
        codeVC.phone = weakSelf.phoneTF.text;
        codeVC.sendCode = weakSelf.code;
         [weakSelf.navigationController pushViewController:codeVC animated:YES];
        
    } failure:^(NSError *error) {
        
    }];

    
}



-(void)setfwb:(UITextView *)button :(NSInteger)start :(NSInteger)over{
        
    NSInteger font = 12;

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"登录代表您已同意《用户服务协议》和《隐私条款》"];

     

        [attributedString addAttribute:NSLinkAttributeName value:@"fuwu"

        range:[[attributedString string] rangeOfString:@"《用户服务协议》"]];

        [attributedString addAttribute:NSLinkAttributeName  value:@"yinsi"

        range:[[attributedString string] rangeOfString:@"《隐私条款》"]];


        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, attributedString.length)];

        _textView.attributedText = attributedString;

        _textView.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor redColor],

                                         
                                         
        NSUnderlineColorAttributeName: [UIColor lightGrayColor],

        NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};

        _textView.delegate = self;

         //必须禁止输入，否则点击将弹出输入键盘
        _textView.editable = NO;

        _textView.scrollEnabled = NO;
    
    
    CGFloat deadSpace = ([_textView bounds].size.height - [_textView contentSize].height);
    CGFloat inset = MAX(0, deadSpace/2.0);
    _textView.contentInset = UIEdgeInsetsMake(inset, _textView.contentInset.left, inset, _textView.contentInset.right);

    _textView.textAlignment = 1;
   
      
//    [self contentSizeToFit];

    }
    
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    
    
    NSString *urlStr =[NSString stringWithFormat:@"%@",URL];
    
       if ([urlStr  isEqualToString:@"fuwu"]) {
           WKController *wkVC = [WKController new];
           wkVC.urls = @"https://kcwl-pro-oss.jskc56.com/jskcwl_file/jsyx_file/agreement.html";
           [self.navigationController pushViewController:wkVC animated:YES];
    ///服务协议

    return NO;

    } else if ([urlStr  isEqualToString:@"yinsi"]) {
    ///隐私协议
        WKController *wkVC = [WKController new];
        wkVC.urls = @"https://kcwl-pro-oss.jskc56.com/jskcwl_file/jsyx_file/agreement.html";
        [self.navigationController pushViewController:wkVC animated:YES];

    return NO;

    }

    return YES;
    
}


- (void)contentSizeToFit
{
    //先判断一下有没有文字（没文字就没必要设置居中了）
    if([self.textView.text length]>0)
    {
        //textView的contentSize属性
        CGSize contentSize = self.textView.contentSize;
        //textView的内边距属性
        UIEdgeInsets offset;
        CGSize newSize = contentSize;
        
        //如果文字内容高度没有超过textView的高度
        if(contentSize.height <= self.textView.frame.size.height)
        {
            //textView的高度减去文字高度除以2就是Y方向的偏移量，也就是textView的上内边距
            CGFloat offsetY = (self.textView.frame.size.height - contentSize.height)/2;
            offset = UIEdgeInsetsMake(offsetY, 0, 0, 0);
        }
        else          //如果文字高度超出textView的高度
        {
            newSize = self.textView.frame.size;
            offset = UIEdgeInsetsZero;
            CGFloat fontSize = 18;

           //通过一个while循环，设置textView的文字大小，使内容不超过整个textView的高度（这个根据需要可以自己设置）
            while (contentSize.height > self.textView.frame.size.height)
            {
                [self.textView setFont:[UIFont fontWithName:@"Helvetica Neue" size:fontSize--]];
                contentSize = self.textView.contentSize;
            }
            newSize = contentSize;
        }
        
        //根据前面计算设置textView的ContentSize和Y方向偏移量
        [self.textView setContentSize:newSize];
        [self.textView setContentInset:offset];
        
    }
}

//-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
//
//
//
//}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (void)switchIdentityFunction{
    self.identityButton.selected = !self.identityButton.selected;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
