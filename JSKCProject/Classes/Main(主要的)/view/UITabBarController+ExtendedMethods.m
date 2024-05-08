//
//  UITabBarController+ExtendedMethods.m
//  JDL
//
//  Created by 胜炫电子 on 2018/1/12.
//  Copyright © 2018年 BlueSkyer-25. All rights reserved.
//

#import "UITabBarController+ExtendedMethods.h"

@implementation UITabBarController (ExtendedMethods)

#pragma mark 是否隐藏tabBar
- (void)hideTabBar:(BOOL)hide{
    if (hide == YES){
        self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, Height, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
        self.tabBar.alpha = 0.0;
    }else {
        self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, Height - 49 - UISafeAreaBottomHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
        self.tabBar.alpha = 1.0;
    }
}

- (void)hideTabBar:(BOOL)hide animated:(BOOL)animated{
    [UIView animateWithDuration:animated ? 0.2 : 0.0f animations:^{
        if (hide == YES){
            self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, Height, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            self.tabBar.alpha = 0.0;
        }else {
            self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, Height - 49 - UISafeAreaBottomHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            self.tabBar.alpha = 1.0;
        }
    }];
}

@end
