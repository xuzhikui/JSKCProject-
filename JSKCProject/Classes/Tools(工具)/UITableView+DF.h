//
//  UITableView+DF.h
//  SecretaryProject
//
//  Created by 孟德峰 on 2019/3/11.
//  Copyright © 2019年 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (DF)

///简体初始化

+(UITableView *)initWithDFTablbleView:(UITableViewStyle *)style :(CGRect )cgrect :(UIViewController *)delegate :(UIColor *)tableBackColor :(NSString *)cell :(UIView *)contViews;

@end

NS_ASSUME_NONNULL_END
