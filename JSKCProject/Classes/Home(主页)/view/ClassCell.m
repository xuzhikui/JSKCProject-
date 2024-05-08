//
//  ClassCell.m
//  ExcellentCarProject
//
//  Created by 孟德峰 on 2020/9/23.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "ClassCell.h"

@implementation ClassCell

-(void)setUI{
    
    
//    [self.titles removeFromSuperview];
    
    
    self.imgs = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 30)/2, 0, 30, 30)];
    self.imgs.image = [UIImage imageNamed:self.dic[@"img"]];
    [self.contentView addSubview:self.imgs];
    
    self.titles= [UILabel initWithDFLable:CGRectMake(0, 38, self.frame.size.width, 15) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :self.dic[@"tit"] :self.contentView:1];
    self.titles.textAlignment = 1;
    
    if ([self.code isEqualToString:@"1"]) {
        
        
        self.codeimgs = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 30)/2 + 26, -3, 8, 8)];
        self.codeimgs.layer.cornerRadius = 4;
        self.codeimgs.layer.masksToBounds = YES;
        self.codeimgs.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.codeimgs];
        
        
    }
    
}

@end
