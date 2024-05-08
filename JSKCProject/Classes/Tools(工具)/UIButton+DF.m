//
//  UIButton+DF.m
//  YbtPrject
//
//  Created by aaa on 2018/6/23.
//  Copyright © 2018年 mdfs. All rights reserved.
//

#import "UIButton+DF.h"

@implementation UIButton (DF)

///字体But
+ (UIButton *)initWithFrame:(CGRect )frames :(NSString *)title :(NSInteger )font{
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    
    but.frame = frames;
    [but setTitle:title forState:0];
    but.titleLabel.font = [UIFont systemFontOfSize:font];
    return but;
}

///Image
+(UIButton *)initWithFrame:(CGRect )frames :(NSString *)images{
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    
    but.frame = frames;
    [but setImage:[UIImage imageNamed:images] forState:0];
//    but.titleLabel.font = [UIFont systemFontOfSize:font];
    return but;
    
}


@end
