//
//  UIImageView+DF.h
//  SecretaryProject
//
//  Created by 孟德峰 on 2019/3/13.
//  Copyright © 2019年 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (DF)


///初始化普通无网络Image
+(UIImageView *)initWithSetImageFrame:(CGRect )frame  Image:(UIImage *)image;

///初始化网络urlImage

+(UIImageView *)initWithURLImageFrame:(CGRect) frame Url:(NSString *)url Image:(UIImage *)image;


@end

NS_ASSUME_NONNULL_END
