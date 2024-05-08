//
//  MainController.m
//  JSKCProject
//
//  Created by XHJ on 2020/9/17.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "MainController.h"
#import "HomeController.h"
#import "MeController.h"
#import "SettlementController.h"
#import "WaybilController.h"
#import "TestViewController.h"
@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];

    HomeController *homeVC = [HomeController new];
       
       [self addChildViewControllerTitle:@"货源" finishedSelected:[UIImage imageNamed:@"货源1"] finishedUnSelected:[UIImage imageNamed:@"货源"] viewController:homeVC];
  
    
    WaybilController *wayVC = [WaybilController new];
    [self addChildViewControllerTitle:@"运单" finishedSelected:[UIImage imageNamed:@"运单1"] finishedUnSelected:[UIImage imageNamed:@"运单"] viewController:wayVC];


    SettlementController *setVC = [SettlementController new];
     [self addChildViewControllerTitle:@"结算" finishedSelected:[UIImage imageNamed:@"结算1"] finishedUnSelected:[UIImage imageNamed:@"结算"] viewController:setVC];




       MeController *meVC = [MeController new];
        [self addChildViewControllerTitle:@"我的" finishedSelected:[UIImage imageNamed:@"我的1"] finishedUnSelected:[UIImage imageNamed:@"我的"] viewController:meVC];

    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    
}


    ///创建
    - (void)addChildViewControllerTitle:(NSString *)title finishedSelected:(UIImage *)finishedSelected finishedUnSelected:(UIImage *)finishedUnSelected viewController:(UIViewController *)viewController
    {
        
        
        
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
//        attrs[NSForegroundColorAttributeName] = [UIColor redColor];
//
//
        NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
        attrSelected[NSFontAttributeName] = [UIFont systemFontOfSize:14];
//        attrSelected[NSForegroundColorAttributeName] = [UIColor redColor];
        
      

        
        finishedSelected = [finishedSelected imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        UITabBarItem* item = [[UITabBarItem alloc] initWithTitle:title image:finishedUnSelected selectedImage:finishedSelected];
        viewController.tabBarItem = item;
        
        [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [item setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
        
        viewController.view.backgroundColor = COLOR2(240);
//        [viewController setTitle:title];
    //    self.tabBar.tintColor = selColor;
        
        self.tabBar.tintColor = [UIColor redColor];
        
        
        
        if (Height > 736.00) {
          
            if (@available(iOS 13.0, *)) {
                      UITabBarAppearance *appearance = [UITabBarAppearance new];
                      appearance.stackedLayoutAppearance.normal.titleTextAttributes = @{NSFontAttributeName :[UIFont systemFontOfSize:13]};
                    appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffsetMake(0, 2);
                     appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = UIOffsetMake(0, 2);
                            item.imageInsets = UIEdgeInsetsMake(0, -2, 0, 2);
                          item.standardAppearance = appearance;
                  } else {
                      // Fallback on earlier versions
                  }
            
        }
        
        self.tabBar.backgroundColor = UIColor.whiteColor;
        
        
        NavController *nav = [[NavController alloc] initWithRootViewController:viewController];
         [nav setNavigationBarHidden:YES animated:YES];
        [self addChildViewController:nav];


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
