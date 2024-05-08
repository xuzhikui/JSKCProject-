//
//  TwoCarNumCell.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/30.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "TwoCarNumCell.h"

@implementation TwoCarNumCell


-(void)setUI{
    
    
    [self.but removeFromSuperview];
    [self.lab removeFromSuperview];
    
    
    if ([self.str isEqualToString:@"*"]) {
        
        self.but =[[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 5)/2, self.frame.size.height/2 - 2.5, 5, 5)];
        
        self.but.image = [UIImage imageNamed:@"键盘背景点"];
        [self.contentView addSubview:self.but];
        
        
    }else{
        
        
            self.lab = [UILabel new];
           self.lab.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
           self.lab.font = [UIFont systemFontOfSize:18*Width1];
           self.lab.textAlignment = 1;
           self.lab.text = self.str;
           self.lab.textColor = [UIColor blackColor];
           [self.contentView addSubview:self.lab];
        
    }
    
    
    
}

@end
