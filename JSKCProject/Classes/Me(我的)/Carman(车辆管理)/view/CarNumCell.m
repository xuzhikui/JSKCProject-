//
//  CarNumCell.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/29.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "CarNumCell.h"

@implementation CarNumCell


-(void)setUI{
    
    
    if ([self.str isEqualToString:@"*"]) {
        
        self.but =[[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 15)/2, self.frame.size.height/2 - 7.5, 15, 15)];
        
        self.but.image = [UIImage imageNamed:@"键盘删除"];
        [self.contentView addSubview:self.but];
        
        
    }else{
        
        
          self.lab = [UILabel new];
           self.lab.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
           self.lab.font = [UIFont systemFontOfSize:15*Width1];
           self.lab.textAlignment = 1;
           self.lab.text = self.str;
        
           self.lab.textColor = [UIColor blackColor];
           [self.contentView addSubview:self.lab];
        
    }
    
    
    
}

@end
