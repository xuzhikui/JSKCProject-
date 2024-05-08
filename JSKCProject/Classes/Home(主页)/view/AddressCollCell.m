//
//  AddressCollCell.m
//  JSKCProject
//
//  Created by XHJ on 2020/9/21.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "AddressCollCell.h"

@implementation AddressCollCell

-(void)initUIs{
    
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width - 15 , self.frame.size.height)];
    self.nameLab.text = _tit;
    self.nameLab.font = [UIFont systemFontOfSize:14*Width1];
    self.nameLab.textColor = [UIColor grayColor];
    self.nameLab.textAlignment = 1;
    [self.contentView addSubview:self.nameLab];
    
    self.imgVC = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 18,7.5, 10, 10)];
        self.imgVC.image = [UIImage imageNamed:@"关闭-01-01-01 拷贝 4"];
        [self.contentView addSubview:self.imgVC];
    
    
}


@end
