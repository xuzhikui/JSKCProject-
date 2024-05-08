//
//  UpPhoneController.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/29.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "UpPhoneController.h"
#import "EndUpPhoneController.h"

@interface UpPhoneController ()
{
    UIButton *codeBut;
}
@property(nonatomic,strong)UITextField *codeTF;
@end

@implementation UpPhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"修改手机号";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    
}

-(void)setUI{
    
    UIView *phoneVC = [[UIView alloc]initWithFrame:CGRectMake(0, NavaBarHeight + 40, Width, 50)];
    phoneVC.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneVC];
    
    
    [UILabel initWithDFLable:CGRectMake(20, 12.5, 80, 25) :[UIFont systemFontOfSize:15*Width1] :[UIColor blackColor] :@"手机号" :phoneVC :0];
    
    
    
    NSString *str1 = [[UserModel shareInstance].username substringToIndex:3];
    NSString *str2 = [[UserModel shareInstance].username substringFromIndex:7];
    
    [UILabel initWithDFLable:CGRectMake(100, 12.5, Width - 200, 25) :[UIFont systemFontOfSize:15*Width1] :[UIColor blackColor] :[NSString stringWithFormat:@"%@****%@",str1,str2] :phoneVC :0];
    
    
            codeBut = [UIButton initWithFrame:CGRectMake(Width - 100, 12.5, 80, 25) :@"发送验证码" :14*Width1];
                codeBut.layer.cornerRadius = 4;
                codeBut.layer.borderColor = [[UIColor redColor]CGColor];
                codeBut.layer.borderWidth = 1;
                [codeBut setTitleColor:[UIColor redColor] forState:0];
                 [codeBut addTarget:self action:@selector(codeAction) forControlEvents:(UIControlEventTouchUpInside)];
                 [phoneVC addSubview:codeBut];
             
    
    UIView *fg1 = [[UIView alloc]initWithFrame:CGRectMake(20, 49, Width - 40, 1)];
    fg1.backgroundColor = COLOR2(203);
    [phoneVC addSubview:fg1];
    
    
    UIView *codeVC = [[UIView alloc]initWithFrame:CGRectMake(0, NavaBarHeight + 100, Width, 50)];
       codeVC.backgroundColor = [UIColor whiteColor];
       [self.view addSubview:codeVC];
       
       
       [UILabel initWithDFLable:CGRectMake(20, 12.5, 80, 25) :[UIFont systemFontOfSize:15*Width1] :[UIColor blackColor] :@"验证码" :codeVC :0];
       
       
       
    self.codeTF = [[UITextField alloc]initWithFrame:CGRectMake(100, 12.5, Width - 200, 25)];
    self.codeTF.placeholder = @"请输入验证码";
    self.codeTF.font = [UIFont systemFontOfSize:15*Width1];
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    [codeVC addSubview:self.codeTF];
    
    
       UIView *fg2 = [[UIView alloc]initWithFrame:CGRectMake(20, 49, Width - 40, 1)];
       fg2.backgroundColor = COLOR2(203);
       [codeVC addSubview:fg2];
    
    
    
    UIButton *endBut = [UIButton initWithFrame:CGRectMake(20, NavaBarHeight + 180, Width - 40, 50) :@"验证后绑定新手机" :15];
    endBut.layer.cornerRadius = 4;
    [endBut addTarget:self action:@selector(endActrion) forControlEvents:(UIControlEventTouchUpInside)];
    endBut.backgroundColor = COLOR(214,12,12);
    [self.view addSubview:endBut];
    

    [UILabel initWithDFLable:CGRectMake(20, NavaBarHeight + 290, 200, 30) :[UIFont systemFontOfSize:12*Width1] :COLOR2(58) :@"温馨提示：" :self.view :0];
    
    
     [UILabel initWithDFLable:CGRectMake(20, NavaBarHeight + 320, Width - 20, 30) :[UIFont systemFontOfSize:12*Width1] :COLOR2(119) :@"1.手机号修改成功后，原手机号将不支持登录" :self.view :0];
    
     [UILabel initWithDFLable:CGRectMake(20, NavaBarHeight + 340, Width - 20, 30) :[UIFont systemFontOfSize:12*Width1] :COLOR2(119) :@"2.修改手机会同步更新账号信息" :self.view :0];
    

}



-(void)endActrion{
    [self.codeTF resignFirstResponder];
    if ([self.codeTF.text isEqualToString:@""]) {
        return [self.view addSubview:[Toast makeText:@"请输入验证码"]];
    }
    WeakSelf
    [AFN_DF POST:@"/system/account/updatePhone" Parameters:@{@"code":self.codeTF.text, @"phone":[UserModel shareInstance].username,@"type":@"1"} success:^(NSDictionary *responseObject) {
        NSLog(@"%@",responseObject);
        EndUpPhoneController *endUpC = [EndUpPhoneController new];
        [weakSelf.navigationController pushViewController:endUpC animated:YES];
       } failure:^(NSError *error) {
           NSLog(@"%@",error);
       }];

}

-(void)codeAction{
   
    
    [AFN_DF POST:@"/system/account/getSMS" Parameters:@{@"phone":[UserModel shareInstance].username,@"type":@"1"} success:^(NSDictionary *responseObject) {
        
 [[AFN_DF topViewController].view addSubview:[Toast makeText:@"验证码发送成功"]];
        [self getCode];
        
    } failure:^(NSError *error) {

    }];
    
}



-(void)getCode{
    
   
    
//    [self codeButAction];
    self->codeBut.enabled = NO;
    //    self->codeBut.backgroundColor = [UIColor grayColor];
    
    __block NSInteger timeout = 59; // 倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); // 每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=1){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
               self->codeBut.layer.borderColor = [[UIColor redColor]CGColor];
                [self->codeBut setTitleColor:[UIColor redColor] forState:0];
                //设置界面的按钮显示 根据自己需求设置
                self->codeBut.enabled = YES;
                [self->codeBut setTitle:@"获取验证码" forState:0];
                //                self->codeBut.backgroundColor = [UIColor redColor];
            });
        }else{
            
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            if (seconds < 10) {
                strTime = [NSString stringWithFormat:@"%.1d", seconds];
                
            } dispatch_async(dispatch_get_main_queue(), ^{
                self->codeBut.layer.borderColor = [[UIColor grayColor]CGColor];
                [self->codeBut setTitleColor:[UIColor grayColor] forState:0];
                [self->codeBut setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:0];
            });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
    
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
