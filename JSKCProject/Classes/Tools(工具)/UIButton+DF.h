//
//  UIButton+DF.h
//  YbtPrject
//
//  Created by aaa on 2018/6/23.
//  Copyright © 2018年 mdfs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (DF)

///字体But
+ (UIButton *)initWithFrame:(CGRect )frames :(NSString *)title :(NSInteger )font;

///Image
+(UIButton *)initWithFrame:(CGRect )frames :(NSString *)images;

@end
