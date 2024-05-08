//
//  MCTabBarController.m
//  MCTabBarDemo
//
//  Created by chh on 2017/12/4.
//  Copyright © 2017年 Mr.C. All rights reserved.
//

#import "MCTabBarController.h"
#import "BaseNavigationController.h"
#import "MCTabBar.h"
#import "HomeController.h"
#import "MeController.h"
#import "SettlementController.h"
#import "WaybilController.h"

@interface MCTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) MCTabBar *mcTabbar;
@property (nonatomic, assign) NSUInteger selectItem;//选中的item
@end

@implementation MCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mcTabbar = [[MCTabBar alloc] init];
     [_mcTabbar.centerBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //选中时的颜色
    _mcTabbar.tintColor = [UIColor colorWithRed:254/255.0 green:2/255.0 blue:0/255.0 alpha:1];
   //透明设置为NO，显示白色，view的高度到tabbar顶部截止，YES的话到底部
    _mcTabbar.translucent = NO;
    //利用KVC 将自己的tabbar赋给系统tabBar
    [self setValue:_mcTabbar forKeyPath:@"tabBar"];
    
    self.selectItem = 0; //默认选中第一个
    self.delegate = self;
    [self addChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//添加子控制器
- (void)addChildViewControllers{
    
  
    
  
//
//    self.controllerArray = @[[HomeViewController new],[FindViewController new],[RelViewController new],[MeViewController new]];
    self.controllerArray = @[[HomeController new],[WaybilController new],[SettlementController new],[MeController new]];
    self.contImgArray = @[@"首页",@"首页",@"首页",@"首页"];
    NSArray *arr = @[@"首页",@"发现",@"发布",@"我的"];
    for (int i = 0; i < _contImgArray.count; i++) {
        
        [self addChildrenViewController:self.controllerArray[i] andTitle:arr[i] andImageName:_contImgArray[i] andSelectImage:_contImgArray[i]];
        
    }
    
    
//    //图片大小建议32*32
//    [self addChildrenViewController:homeVC andTitle:@"首页" andImageName:@"shouye111" andSelectImage:@"shouye111"];
//    [self addChildrenViewController:shopVC andTitle:@"发现" andImageName:@"faxian111" andSelectImage:@"faxian111"];
//    //中间这个不设置东西，只占位
//    [self addChildrenViewController:releaseVC andTitle:@"发布" andImageName:@"" andSelectImage:@""];
//    [self addChildrenViewController:orderVC andTitle:@"订单" andImageName:@"dingdan111" andSelectImage:@"dingdan111"];
//    [self addChildrenViewController:meVC andTitle:@"我的" andImageName:@"wode111" andSelectImage:@"wode111"];
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectImage:(NSString *)selectedImage{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
     childVC.view.backgroundColor = COLOR(240, 240, 240);
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:selectedImage];
    childVC.title = title;
    
    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:childVC];
   
    baseNav.navigationBar.barTintColor = navigationColor;
    baseNav.navigationBar.titleTextAttributes=
  @{NSForegroundColorAttributeName:[UIColor whiteColor],
    NSFontAttributeName:[UIFont boldSystemFontOfSize:12]};
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
  
    [self addChildViewController:baseNav];
}

- (void)buttonAction:(UIButton *)button{
    self.selectedIndex = 2;//关联中间按钮
    if (self.selectItem != 2){
        [self rotationAnimation];
    }
    self.selectItem = 2;
}

//tabbar选择时的代理
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex == 2){//选中中间的按钮
        if (self.selectItem != 2){
             [self rotationAnimation];
        }
    }else {
        [_mcTabbar.centerBtn.layer removeAllAnimations];
    }
    self.selectItem = tabBarController.selectedIndex;
}
//旋转动画
- (void)rotationAnimation{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 3.0;
    rotationAnimation.repeatCount = HUGE;
    [_mcTabbar.centerBtn.layer addAnimation:rotationAnimation forKey:@"key"];
}
@end
