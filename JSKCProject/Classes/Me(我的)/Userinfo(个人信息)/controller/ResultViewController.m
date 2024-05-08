//
//  ResultViewController.m
//  faceDemo
//
//  Created by golang on 2022/4/6.
//  Copyright © 2022 hisign. All rights reserved.
//

#import "ResultViewController.h"
#import <HSFaceDetector/LiveHeader.h>

@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}


- (void)initView{
    
    UIView *bgView = [[UIView alloc]initWithFrame:self.view.frame];
    bgView.backgroundColor = HSBlueColor;
    [self.view addSubview:bgView];
    
    UILabel *messageLab = [[UILabel alloc]init];
    messageLab.textColor = HSGreenColor;
    messageLab.textAlignment = NSTextAlignmentCenter;
    messageLab.font = [UIFont systemFontOfSize:25];
    [bgView addSubview:messageLab];

    UIButton *quitBtn = [[UIButton alloc]init];
    quitBtn.backgroundColor = HSGreenColor;
    [quitBtn setTitle:@"退出" forState:UIControlStateNormal];
    [quitBtn setTitleColor:HSBlueColor forState:UIControlStateNormal];
    [quitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [quitBtn addTarget:self action:@selector(quitAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:quitBtn];
    
    if (self.errorCode == IV_ERROR_NONE) {
        messageLab.frame = CGRectMake(0, NavBarPadding + 64, SCREENWIDTH, 44);
        messageLab.text = @"采集成功";
        UITextView *signTv = [[UITextView alloc]initWithFrame:CGRectMake(SCREENWIDTH/10, CGRectGetMaxY(messageLab.frame) + 30, SCREENWIDTH/10*8, SCREENHEIGHT/2)];
        signTv.textColor = [UIColor blackColor];
        signTv.text = self.signImage;
        [bgView addSubview:signTv];
        quitBtn.frame = CGRectMake(SCREENWIDTH/10, CGRectGetMaxY(signTv.frame) + 44, SCREENWIDTH/10*8, 44);
    }else {
        messageLab.frame = CGRectMake(0, SCREENHEIGHT / 3, SCREENWIDTH, 44);
        messageLab.text = self.errorMessage;
        messageLab.textColor = [UIColor redColor];
        quitBtn.frame = CGRectMake(SCREENWIDTH/10, SCREENHEIGHT - HomeBarPadding - 128, SCREENWIDTH/10*8, 44);
    }
    
}

- (void)quitAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
