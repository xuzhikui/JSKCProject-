//
//  PassWordView.m
//  YbtPrject
//
//  Created by aaa on 2018/6/28.
//  Copyright © 2018年 mdfs. All rights reserved.
//

#import "PassWordView.h"
#import "SYPasswordView.h"
@implementation PassWordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    UILabel *tipLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20*Height1, Width, 20*Height1)];
    tipLab.font = [UIFont systemFontOfSize:18];
    tipLab.textColor = [UIColor redColor];
    tipLab.text =@"支付密码";
    tipLab.textAlignment = YES;
    [self addSubview:tipLab];
 
    
    self.pasView = [[SYPasswordView alloc] initWithFrame:CGRectMake(16*Width1, 70*Height1, Width - 32*Width1, 45*Height1)];
    
    __weak PassWordView *weakSelf = self;
    
    self.pasView.block = ^(NSString *password) {
      
        [weakSelf endpassWord:password];
        
    };
    [self addSubview:_pasView];
    
    
    UIButton *but = [UIButton initWithFrame:CGRectMake(40*Width1,  150*Height1, Width - 80*Width1, 35*Height1) :@"取消" :16];
    but.layer.cornerRadius = 17.5*Width1;
    but.layer.masksToBounds = YES;
    [but addTarget:self action:@selector(butAction) forControlEvents:(UIControlEventTouchUpInside)];
    but.backgroundColor = navigationColor;
     [self addSubview:but];
    
    
}


-(void)endpassWord:(NSString *)pass{
    
    _block(pass);
     [self removeFromSuperview];
}


-(void)butAction
{
    
//    _block(@"");
    [self removeFromSuperview];
}


@end
