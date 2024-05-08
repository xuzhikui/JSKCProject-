//
//  AboutController.m
//  JSKCProject
//
//  Created by XHJ on 2021/3/25.
//  Copyright © 2021 孟德峰. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()
@property(nonatomic,strong)NSDictionary *data;
@end

@implementation AboutController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    [self postUrl];
    [self setUI];
    
    
}

-(void)postUrl{
    
    [AFN_DF POST:@"/system/lawandnotice/getLawOrNotice" Parameters:@{@"type":@"1"} success:^(NSDictionary *responseObject) {
        
        self.data =responseObject[@"data"][0];
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

-(void)setUI{
    
    
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake((Width - 190)/2, 160, 190, 50)];
    img.image = [UIImage imageNamed:@"abtlog"];
    NSLog(@"%@",[ImageUrlModel shareInstance].aboutUsLogo);
//    [img sd_setImageWithURL:[NSURL URLWithString:[ImageUrlModel shareInstance].aboutUsLogo]];
    [self.view addSubview:img];
    
    
    [UILabel initWithDFLable:CGRectMake(0, 220, Width, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :@"版本v2.2.0" :self.view :1];
    
    
    
    UIButton *leftBut = [UIButton initWithFrame:CGRectMake(Width/2 - 150, Height - 120, 142, 30) :@"法律声明" :13];
    [leftBut setTitleColor:[UIColor redColor] forState:0];
    [leftBut addTarget:self action:@selector(leftAction) forControlEvents:(UIControlEventTouchUpInside)];
    leftBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:leftBut];
    
    UIView *fg = [[UIView alloc]initWithFrame:CGRectMake(Width/2 - 0.5, Height - 115,1, 20)];
    fg.backgroundColor = COLOR2(119);
    [self.view addSubview:fg];
    
    UIButton *rigBut = [UIButton initWithFrame:CGRectMake(Width/2 + 8, Height - 120, 145, 30) :@"隐私协议" :13];
    [rigBut setTitleColor:[UIColor redColor] forState:0];
    [rigBut addTarget:self action:@selector(rigAction) forControlEvents:(UIControlEventTouchUpInside)];
    rigBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:rigBut];

    
}

-(void)leftAction{
    
    if (self.data == nil) {
        
        [self postUrl];
        
        return;
    }
    
    WKController *wkVC = [WKController new];
    wkVC.urls = self.data[@"documentUrl"];
    wkVC.title = self.data[@"title"];
    [self.navigationController pushViewController:wkVC animated:YES];
    
}

-(void)rigAction{
    
    
    if (self.data == nil) {
        
        [self postUrl];
        
        return;
    }
    
    WKController *wkVC = [WKController new];
    wkVC.urls = self.data[@"documentUrl"];
    wkVC.title = self.data[@"title"];
    [self.navigationController pushViewController:wkVC animated:YES];
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
