//
//  EndCommController.m
//  JSKCProject
//
//  Created by 孟德峰 on 2020/12/27.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "EndCommController.h"
#import "CommDetController.h"
@interface EndCommController ()

@end

@implementation EndCommController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"评价成功";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStyleDone) target:self action:@selector(back)];
    
       
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setUI];
    
}

-(void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


-(void)setUI{
    

    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, NavaBarHeight, Width, 200)];
//    img.backgroundColor = [UIColor redColor];
    img.userInteractionEnabled = YES;
    img.image = [UIImage imageNamed:@"钱包back"];
    [self.view addSubview:img];
 
    
    
    UIImageView *iconimg = [[UIImageView alloc]initWithFrame:CGRectMake(Width/2 - 20, 30, 40, 40)];
    iconimg.image = [UIImage imageNamed:@"对"];
    [img addSubview:iconimg];
    
    
    [UILabel initWithDFLable:CGRectMake(0, 80, Width, 20) :[UIFont boldSystemFontOfSize:17*Width1] :[UIColor whiteColor] :@"评价成功，感谢您！" :img :1];
    
    
    
    
    UIView *butVC = [[UIView alloc]initWithFrame:CGRectMake(Width/2 - 40, 150, 80, 30)];
    butVC.backgroundColor = [UIColor whiteColor];
    butVC.layer.cornerRadius = 15;
    butVC.alpha = 0.6;
    butVC.layer.masksToBounds = YES;
    [img addSubview:butVC];
    
    
    UIButton *but = [UIButton initWithFrame:CGRectMake(Width/2 - 40, 150, 80, 30) :@"查看评论" :15];
//    but.backgroundColor = [UIColor whiteColor];
//    but.alpha = 0.6;
    but.layer.cornerRadius = 15;
    but.layer.masksToBounds = YES;
    [but addTarget:self action:@selector(butAction) forControlEvents:(UIControlEventTouchUpInside)];
    [but setTitleColor:[UIColor whiteColor] forState:0];
    [img addSubview:but];
    
    
}

-(void)butAction{
    
    
    CommDetController *coDet = [CommDetController new];
    coDet.dic = self.dic;
    [self.navigationController pushViewController:coDet animated:YES];
    
    
    
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
