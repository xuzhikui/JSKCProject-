//
//  NavController.m
//  FoodcirclesPrject
//
//  Created by 孟德峰 on 2020/5/15.
//  Copyright © 2020年 孟德峰. All rights reserved.
//

#import "NavController.h"

@interface NavController ()

@end

@implementation NavController




//-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//
//
//
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationBar.topItem.title = @"";
//    self.navigationBar.tintColor = [UIColor blackColor];
//
//    [super pushViewController:viewController animated:YES];
//
//}
//
//-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
//
//
//    self.navigationBar.topItem.title = self.title;
//
//  return   [super popViewControllerAnimated:animated];
//}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    backBtn.title = @"";
    [backBtn setTintColor:[UIColor blackColor]];
    viewController.navigationItem.backBarButtonItem = backBtn;
  
    [super pushViewController:viewController animated:animated];
    //    [self pushViewController:viewController animated:YES];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}


////重写这个方法，在跳转后自动隐藏tabbar
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if ([self.viewControllers count] > 0){
//        viewController.hidesBottomBarWhenPushed = YES;
//        //可以在这里定义返回按钮等
//        /*
//         UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
//         viewController.navigationItem.leftBarButtonItem = backItem;
//         */
//    }
//    //一定要写在最后，要不然无效
//    [super pushViewController:viewController animated:animated];
//    //处理了push后隐藏底部UITabBar的情况，并解决了iPhonX上push时UITabBar上移的问题。
//    CGRect rect = self.tabBarController.tabBar.frame;
//    rect.origin.y = [UIScreen mainScreen].bounds.size.height - rect.size.height;
//    self.tabBarController.tabBar.frame = rect;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
