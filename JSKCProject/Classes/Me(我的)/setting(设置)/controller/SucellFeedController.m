//
//  SucellFeedController.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "SucellFeedController.h"

@interface SucellFeedController ()

@end

@implementation SucellFeedController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.tabBarController.tabBar.hidden = YES;
   

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    
    self.view.backgroundColor = COLOR2(240);
    
    
    [self setUI];
    
    
}

-(void)setUI{
    
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake((Width - 155)/2, 110, 155, 115)];
    img.image = [UIImage imageNamed:@"圆角矩形 4 拷贝 3"];
    [self.view addSubview:img];
    
    
    [UILabel initWithDFLable:CGRectMake(0, 270, Width, 30) :[UIFont boldSystemFontOfSize:21*Width1] :[UIColor blackColor] :@"反馈成功" :self.view :1];
    
    
   UILabel *tips =   [UILabel initWithDFLable:CGRectMake(40, 320, Width - 80, 40) :[UIFont systemFontOfSize:13*Width1] :[UIColor grayColor] :@"感谢您的关注与支持，我们会认证处理您的反馈，尽快修复和完善相关功能。" :self.view :1];
    tips.numberOfLines = 2;
    
    
    
        UIButton *endBut = [UIButton initWithFrame:CGRectMake((Width - 120)/2, 410, 120, 30) :@"我知道了" :16*Width1];
                                   endBut.layer.cornerRadius = 4;
                        endBut.layer.borderColor = [[UIColor redColor]CGColor];
                        [endBut setTitleColor:[UIColor redColor] forState:0];
                            endBut.layer.borderWidth = 1;
                    [endBut addTarget:self action:@selector(delegateAction) forControlEvents:(UIControlEventTouchUpInside)];
                        [self.view addSubview:endBut];
    
    
    
}



-(void)delegateAction{
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
    
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
