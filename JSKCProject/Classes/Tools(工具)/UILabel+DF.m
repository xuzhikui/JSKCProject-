//
//  UILabel+DF.m
//  SecretaryProject
//
//  Created by 孟德峰 on 2019/3/11.
//  Copyright © 2019年 孟德峰. All rights reserved.
//

#import "UILabel+DF.h"

@implementation UILabel (DF)

+(UILabel *)initWithDFLable:(CGRect )rect :(UIFont *)font :(UIColor *)titleFontColor :(NSString *)title :(UIView *)contViews :(NSInteger)anl{
    
    UILabel *lab = [UILabel new];
    lab.frame = rect;
    lab.font = font;
    lab.textColor = titleFontColor;
    lab.text = title;
    lab.textAlignment = anl;
    [contViews addSubview:lab];
    
    return lab;
}

@end
