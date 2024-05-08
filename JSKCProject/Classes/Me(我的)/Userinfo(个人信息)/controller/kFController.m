//
//  kFController.m
//  JSKCProject
//
//  Created by XHJ on 2021/3/26.
//  Copyright © 2021 孟德峰. All rights reserved.
//

#import "kFController.h"

@interface kFController ()
@property(nonatomic,strong)NSDictionary *dict;
@end

@implementation kFController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = YES;
   

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"联系客服";
    self.view.backgroundColor = [UIColor whiteColor];
    [self postdata];
//    [self setUI];
    
    
}

-(void)postdata{
    
    
    [AFN_DF POST:@"/system/cusservice/get" Parameters:nil success:^(NSDictionary *responseObject) {
        
        
        self.dict = responseObject[@"data"];
        [self setUI];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

-(void)setUI{
    
    
    
    UIImageView *back = [[UIImageView alloc]initWithFrame:CGRectMake(0, NVAHEIGHT, Width, 200)];
    back.image = [UIImage imageNamed:@"kfimage"];
    [self.view addSubview:back];
    
    
    
    
    
    UIImageView *textImage = [[UIImageView alloc]initWithFrame:CGRectMake((Width - 180)/2,20, 180,65)];
//    [textImage sd_setImageWithURL:[NSURL URLWithString:self.dict[@"csBack"]]];
    textImage.image = [UIImage imageNamed:@"联系我们字"];
    [back addSubview:textImage];
    
    
    
    
    
    NSArray *titArray = @[@"工作时间",@"服务投诉电话",@"微信客服"];
    NSArray *dataArray = @[self.dict[@"workTime"],self.dict[@"csPhone"],self.dict[@"csWechat"]];
    
    UIView *backVC = [[UIView alloc]initWithFrame:CGRectMake(0, 200 + NVAHEIGHT, Width, 150)];
    [self.view addSubview:backVC];
    
    
    for (int i = 0;  i<titArray.count; i++) {
        
        
        UIView *fg = [[UIView alloc]initWithFrame:CGRectMake(20, 0 + (50 * i), Width - 40, 1)];
        fg.backgroundColor = COLOR2(220);
        [backVC  addSubview:fg];

        
        [UILabel initWithDFLable:CGRectMake(20, 0 + (50 * i), 100, 50) :[UIFont systemFontOfSize:14] :COLOR2(153) :titArray[i] :backVC :0];
        
       UILabel *tips = [UILabel initWithDFLable:CGRectMake(Width - 180, 0 + (50 * i), 160, 50) :[UIFont systemFontOfSize:14] :COLOR2(51) :dataArray[i] :backVC :2];
        
        if (i > 0) {
            tips.frame = CGRectMake(Width - 180, 0 + (50 * i), 130, 50);

        }
        
        
        if (i == 1) {
            UIButton *But = [UIButton initWithFrame:CGRectMake(Width - 50,  (i * 50) +  15, 20, 20) :@"电话"];
            [But addTarget:self action:@selector(phoneAction) forControlEvents:(UIControlEventTouchUpInside)];
            [backVC addSubview:But];
        }
        
        if (i == 2) {
            
            UIButton *But = [UIButton initWithFrame:CGRectMake(Width - 50, (i * 50) + 15, 20, 20) :@"复制1"];
            [backVC addSubview:But];
            
        }
        
        
        
    }
    
    
    
    
    UIImageView *qrImg = [[UIImageView alloc]initWithFrame:CGRectMake((Width - 130)/2, 400 + NVAHEIGHT, 130, 130)];
    [qrImg sd_setImageWithURL:[NSURL URLWithString:self.dict[@"publicAccountQr"]]];
    [self.view addSubview:qrImg];
    
    
    [UILabel initWithDFLable:CGRectMake(0, 535 + NVAHEIGHT, Width, 20) :[UIFont systemFontOfSize:14*Width1] :[UIColor blackColor] :@"微信公众号" :self.view :1];
    

    
}




-(void)copyAction{
    
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.dict[@"csWechat"];
    [self.view addSubview:[Toast makeText:@"成功复制到剪切板"]];
    
}

-(void)phoneAction{
    
         NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.dict[@"csPhone"]];
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

    
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
