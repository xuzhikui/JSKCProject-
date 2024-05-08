//
//  UIButton+ExtendedMethods.h
//  BaseFramework
//
//  Created by Zanilia on 2017/4/12.
//  Copyright © 2017年 王宾. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, UIButtonControlState) {
    UIButtonControlStateNormal       = 0,
    UIButtonControlStateSelected  = 1 << 0
};

@interface UIButton (ExtendedMethods)

@property (strong, nonatomic) UIColor *indicatorColor;

- (void)startCountDownTime:(NSInteger)time withCountDownBlock:(void(^)(void))countDownBlock;
- (void)stopCountDownTime;
@end
