//
//  CodeController.m
//  JSKCProject
//
//  Created by XHJ on 2020/9/15.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "CodeController.h"
#import "MQVerCodeInputView.h"
#import "MainController.h"
@interface CodeController ()<UITextViewDelegate>{
    UIButton *codeBut;
    NSMutableAttributedString *attributedString;
}
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)UITextView *textView;


@end

@implementation CodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}
-(void)setUI{
    
    UIButton *clanBut = [UIButton initWithFrame:CGRectMake(16,  StatusBarHeight + 17, 18, 18) :@"返回"];
       [clanBut addTarget:self action:@selector(clanAction) forControlEvents:(UIControlEventTouchUpInside)];
       [self.view addSubview:clanBut];

       UIImageView *logoVC = [[UIImageView alloc]initWithFrame:CGRectMake(43, 109, 136,43)];
       logoVC.image = [UIImage imageNamed:@"快成物流透明"];
//    [logoVC sd_setImageWithURL:[NSURL URLWithString:[ImageUrlModel shareInstance].yzmdlLogo]];
       [self.view addSubview:logoVC];
    
    [UILabel initWithDFLable:CGRectMake(30, 266, 300, 20) :[UIFont systemFontOfSize:12*Width1] :COLOR2(102) :[NSString stringWithFormat:@"已发送验证码至%@",self.phone] :self.view :0];
    
    MQVerCodeInputView *verView = [[MQVerCodeInputView alloc]initWithFrame:CGRectMake(30, 300, Width -60, 50)];
       verView.maxLenght = 6;//最大长度
       verView.keyBoardType = UIKeyboardTypeNumberPad;
       [verView mq_verCodeViewWithMaxLenght];
       verView.block = ^(NSString *text){
           NSLog(@"text = %@",text);
           
           if (text.length == 6) {
               
                 [self loginAction:text];
               
           }
           
           
       };
       [self.view addSubview:verView];
    
    
    
    codeBut = [UIButton initWithFrame:CGRectMake(Width/2 -50, 370,100 , 20) :@"重新获取" :14*Width1];
    
    [codeBut setTitleColor:COLOR2(102) forState:0];
    [codeBut addTarget:self action:@selector(codeAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:codeBut];
        NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:@"重新获取"];
    
    [attributedStr addAttribute:NSUnderlineStyleAttributeName
                           value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                           range:NSMakeRange(0, 4)];
    
    
    codeBut.titleLabel.attributedText = attributedStr;
   
    
    
    
    
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, Height - 200, Width, 200)];
           backImg.image = [UIImage imageNamed:@"圆角矩形 4 拷贝 2"];
           [self.view addSubview:backImg];
    
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 400, Width ,30)];
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
       [self.view addSubview:kfphoneTipsLab];
       
       
       UIButton *phoneBut = [UIButton initWithFrame:CGRectMake(50, Height - 40, Width -100, 20) :@" 400-777-958" :11*Width1];
       [phoneBut setTitleColor:[UIColor redColor] forState:0];
       [self.view addSubview:phoneBut];
       [phoneBut setImage:[UIImage imageNamed:@"电话2-1"] forState:0];
       
//     [self getCode];
    
}

-(void)loginAction:(NSString *)code{
    
    [AFN_DF POST:@"/reg/useSMSReg" Parameters:@{@"code":code,@"phone":self.phone} success:^(NSDictionary *responseObject) {
        
        [[UserModel shareInstance]setValuesForKeysWithDictionary:responseObject[@"data"]];
     
            NSDictionary *dic = responseObject[@"data"];
        id info = [PNSBuildModelUtils deleteEmpty:dic];
                           NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                           [user setObject:info forKey:@"user"];
        [NSNotificationCenter.defaultCenter postNotificationName:RefreHomeDataNotification object:nil];
        
        if ([self.sendCode isEqualToString:@"1"]) {
            [self.navigationController pushViewController:[MainController new] animated:YES];
        }else{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        
    }];
        
    
}

-(void)setfwb:(UITextView *)button :(NSInteger)start :(NSInteger)over{
        
    NSInteger font = 12;

    attributedString = [[NSMutableAttributedString alloc] initWithString:@"登录代表您已同意《用户服务协议》和《隐私条款》"];

     

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
    
    _textView.textAlignment = 1;

    
    
    [self.view addSubview:[Toast makeText:@"短信验证码已经发送到您的手机，请注意查收！"]];
    
    }



-(void)codeAction{
    
    [AFN_DF POST:@"/reg/sendsms" Parameters:@{@"phone":self.phone} success:^(NSDictionary *responseObject) {
           
           [self.view addSubview:[Toast makeText:@"发送验证码成功"]];
        [self getCode];
       } failure:^(NSError *error) {
           
       }];
    
}


-(void)getCode{
    
      NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:@"重新获取"];
                        
                        [attributedStr addAttribute:NSUnderlineStyleAttributeName
                                               value:[NSNumber numberWithInteger: NSUnderlineStyleNone]
                                               range:NSMakeRange(0, 4)];
                     self->codeBut.titleLabel.attributedText = attributedStr;
                     [self->codeBut setTitle:@"重新获取" forState:0];
    
//    [self codeButAction];
    self->codeBut.enabled = NO;
    //    self->codeBut.backgroundColor = [UIColor grayColor];
    
    __block NSInteger timeout = 9; // 倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); // 每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=1){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{

                //设置界面的按钮显示 根据自己需求设置
                self->codeBut.enabled = YES;
                
                NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:@"重新获取"];
                   
                   [attributedStr addAttribute:NSUnderlineStyleAttributeName
                                          value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                                          range:NSMakeRange(0, 4)];
                   
                   
                self->codeBut.titleLabel.attributedText = attributedStr;
                [self->codeBut setTitle:@"重新获取" forState:0];
                //                self->codeBut.backgroundColor = [UIColor redColor];
            });
        }else{
            
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            if (seconds < 10) {
                strTime = [NSString stringWithFormat:@"%.1d", seconds];
                
            } dispatch_async(dispatch_get_main_queue(), ^{
//
                

                
                [self->codeBut setTitle:[NSString stringWithFormat:@"重新获取 %@s",strTime] forState:0];
            });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
    
}

    
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    
    
    NSString *urlStr =[NSString stringWithFormat:@"%@",URL];
    
       if ([urlStr  isEqualToString:@"fuwu"]) {

    ///服务协议
           WKController *wkVC = [WKController new];
           wkVC.urls = @"https://kcwl-pro-oss.jskc56.com/jskcwl_file/jsyx_file/agreement.html";
           [self.navigationController pushViewController:wkVC animated:YES];
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


-(void)clanAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
