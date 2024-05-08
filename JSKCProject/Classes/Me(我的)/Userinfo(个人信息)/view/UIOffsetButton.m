//
//  UIOffsetButton.m
//  BaseFramework
//
//  Created by 王宾 on 2020/7/29.
//  Copyright © 2020 王宾. All rights reserved.
//

#import "UIOffsetButton.h"

@implementation UIOffsetButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return _titleFrame;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return _imageFrame;
}

@end
