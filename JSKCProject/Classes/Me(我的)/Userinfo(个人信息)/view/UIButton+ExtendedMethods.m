//
//  UIButton+ExtendedMethods.m
//  BaseFramework
//
//  Created by Zanilia on 2017/4/12.
//  Copyright © 2017年 王宾. All rights reserved.
//

#import "UIButton+ExtendedMethods.h"
#import <objc/runtime.h>

const void *UIButton_titleLabel_Text_Key = "UIButton_titleLabel_Text_Key";
const void *UIButton_imageView_Image_Key = "UIButton_imageView_Image_Key";
const void *UIButton_indicatorColor_Key = "UIButton_indicatorColor_Key";
const void *UIButton_AnimatedLayer_Key = "UIButton_AnimatedLayer_Key";

const void *UIButton_countdownStarts_Key = "UIButton_countdownStarts_Key";
const void *UIButton_backgroundColorStateNormal_Key = "UIButton_backgroundColorStateNormal_Key";
const void *UIButton_backgroundColorStateSelected_Key = "UIButton_backgroundColorStateSelected_Key";

@interface UIButton ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) UIImage *image;
@property (nonatomic, strong) CALayer *animatedLayer;
@property (nonatomic, assign) BOOL countdownStarts;
@property (nonatomic, assign) BOOL backgroundColorStateKey;
@end

@implementation UIButton (ExtendedMethods)

- (void)setTitle:(NSString *)title{
    objc_setAssociatedObject(self, &UIButton_titleLabel_Text_Key, title, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)title{
    return objc_getAssociatedObject(self, &UIButton_titleLabel_Text_Key);
}

- (void)setIndicatorColor:(UIColor *)indicatorColor{
    objc_setAssociatedObject(self, &UIButton_indicatorColor_Key, indicatorColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)indicatorColor{
    return objc_getAssociatedObject(self, &UIButton_indicatorColor_Key);
}

- (void)setImage:(UIImage *)image{
    objc_setAssociatedObject(self, &UIButton_imageView_Image_Key, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)image{
    return objc_getAssociatedObject(self, &UIButton_imageView_Image_Key);
}

- (void)setCountdownStarts:(BOOL)countdownStarts{
    objc_setAssociatedObject(self, &UIButton_countdownStarts_Key, @(countdownStarts), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)countdownStarts{
    return objc_getAssociatedObject(self, &UIButton_countdownStarts_Key);
}

- (void)startCountDownTime:(NSInteger)time withCountDownBlock:(void (^)(void))countDownBlock{
    NSString *text = [NSString stringWithFormat:@"%02lds",(long)time];
    [self setTitle:text forState:UIControlStateNormal];
    self.userInteractionEnabled = NO;
    [self startTime:time];
    self.hidden = NO;
    if (countDownBlock) {
        countDownBlock();
    }
}

- (void)stopCountDownTime{
    self.countdownStarts = NO;
    self.hidden = YES;
}

- (void)startTime:(NSInteger)time{
    self.countdownStarts = YES;
    __block NSInteger timeout = time;
    WeakSelf;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        //倒计时结束
        if(timeout <= 0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setTitle:@"重新获取" forState:UIControlStateNormal];
                weakSelf.userInteractionEnabled = YES;
                weakSelf.countdownStarts = NO;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!weakSelf.countdownStarts) {
                    dispatch_source_cancel(_timer);
                    [weakSelf setTitle:@"重新获取" forState:UIControlStateNormal];
                    weakSelf.userInteractionEnabled = YES;
                    weakSelf.countdownStarts = NO;
                }else{
                    NSString *text = [NSString stringWithFormat:@"%02lds",(long)timeout];
                    [weakSelf setAttributedTitle:nil forState:UIControlStateNormal];
                    [weakSelf setTitle:text forState:UIControlStateNormal];;
                    weakSelf.userInteractionEnabled = NO;
                }
            });
            timeout --;
        }
    });
    dispatch_resume(_timer);
}

@end
