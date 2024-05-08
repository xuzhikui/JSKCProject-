//
//  OrSuccessController.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/17.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "OrSuccessController.h"
#import "WayDetController.h"
@interface OrSuccessController ()

@end

@implementation OrSuccessController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
            self.tabBarController.tabBar.hidden = YES;
        [self.navigationController setNavigationBarHidden:YES animated:YES];

}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
    
   
    [self setUI];
    
}

-(void)setUI{
    
    
    
    UIButton *leftBut = [UIButton initWithFrame:CGRectMake(10, 25, 30, 30) :@"返回"];
    [leftBut addTarget:self action:@selector(leftAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:leftBut];
    
    
    
    
    UIImageView *imagVC = [[UIImageView alloc]initWithFrame:CGRectMake((Width - 171)/2, 144, 171, 127)];
    imagVC.image = [UIImage imageNamed:@"圆角矩形 4 拷贝 3"];
    [self.view addSubview:imagVC];
    
    
    [UILabel initWithDFLable:CGRectMake(0, 330, Width, 20) :[UIFont systemFontOfSize:13*Width1] :COLOR2(51) :@"接单成功,抓紧联系货主装货吧！" :self.view :1];
    
    
    
    UIButton *lookBut = [UIButton initWithFrame:CGRectMake(Width/2 + 20, 400, Width/2 - 80, 35) :@"查看运单":15*Width1];
       [lookBut addTarget:self action:@selector(leftAction) forControlEvents:(UIControlEventTouchUpInside)];
    lookBut.layer.cornerRadius = 4;
    lookBut.backgroundColor =  COLOR(228, 23, 23);
       [self.view addSubview:lookBut];
    
        UIButton *phoneBut = [UIButton initWithFrame:CGRectMake(60, 400, Width/2 - 80, 35) :@"我知道了":15*Width1];
          [phoneBut addTarget:self action:@selector(endAction) forControlEvents:(UIControlEventTouchUpInside)];
        phoneBut.layer.cornerRadius = 4;
    phoneBut.backgroundColor = COLOR2(204);
        [self.view addSubview:phoneBut];
    
    
    
    
    
    
    
}

///我知道了
-(void)endAction{
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
    
}

///查看运单
-(void)leftAction{
    
    
    WayDetController *detVC = [WayDetController new];
    detVC.types = @"1";
    detVC.dic = self.dic;
    detVC.block = ^(NSDictionary * _Nonnull dic, BOOL isCancel) {
        
    };
    [self.navigationController pushViewController:detVC animated:YES];
    [self.navigationController.tabBarController setSelectedIndex:1];
     
//    [self.navigationController popViewControllerAnimated:YES]; 
    
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
