//
//  UIImageView+DF.m
//  SecretaryProject
//
//  Created by 孟德峰 on 2019/3/13.
//  Copyright © 2019年 孟德峰. All rights reserved.
//

#import "UIImageView+DF.h"

@implementation UIImageView (DF)

///初始化普通无网络Image
+(UIImageView *)initWithSetImageFrame:(CGRect )frame  Image:(UIImage *)image{
    
    UIImageView *imags =  [[UIImageView alloc]initWithFrame:frame];
    imags.image = image;
    
    return imags;
    
}

///初始化网络urlImage

+(UIImageView *)initWithURLImageFrame:(CGRect) frame Url:(NSString *)url Image:(UIImage *)image{
    
     UIImageView *imags =  [[UIImageView alloc]initWithFrame:frame];
    [imags sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:image];
    
    return imags;
    
}


@end
