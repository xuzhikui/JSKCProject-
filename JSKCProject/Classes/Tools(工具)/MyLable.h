//
//  MyLable.h
//  PetsProject
//
//  Created by 孟德峰 on 2019/8/21.
//  Copyright © 2019年 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;
@interface myUILabel : UILabel
{
@private
    VerticalAlignment _verticalAlignment;
}

@end

@interface MyLable : UILabel
@property (nonatomic) VerticalAlignment verticalAlignment;
@end

NS_ASSUME_NONNULL_END
