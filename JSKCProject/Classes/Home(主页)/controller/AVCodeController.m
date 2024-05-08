//
//  AVCodeController.m
//  JSKCProject
//
//  Created by XHJ on 2021/4/6.
//  Copyright © 2021 孟德峰. All rights reserved.
//

#import "AVCodeController.h"

@interface AVCodeController ()

@end

@implementation AVCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.view.backgroundColor = COLOR2(240);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStyleDone) target:self action:@selector(back)];
    
    self.title = @"扫码结果";
    [self setUI];
    
}

-(void)setUI{
    
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake((Width - 256)/2, NavaBarHeight + 170, 256, 174)];
    img.image = [UIImage imageNamed:self.img];
    [self.view addSubview:img];
    
    
}

-(void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
  

@end
