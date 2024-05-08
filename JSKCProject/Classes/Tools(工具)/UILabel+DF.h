//
//  UILabel+DF.h
//  SecretaryProject
//
//  Created by 孟德峰 on 2019/3/11.
//  Copyright © 2019年 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (DF)

///初始化zlab
+(UILabel *)initWithDFLable:(CGRect )rect :(UIFont *)font :(UIColor *)titleFontColor :(NSString *)title :(UIView *)contViews :(NSInteger)anl;

@end

NS_ASSUME_NONNULL_END
