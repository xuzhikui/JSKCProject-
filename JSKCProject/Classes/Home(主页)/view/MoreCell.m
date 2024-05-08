//
//  MoreCell.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/12.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "MoreCell.h"

@implementation MoreCell


-(void)setUI{
    
    
  
    
    self.labs = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];

    self.labs.font = [UIFont systemFontOfSize:14*Width1];
    self.labs.text = self.dic[@"factor"];
    self.labs.textAlignment = 1;
    [self.contentView addSubview:self.labs];
    if ([self.code isEqualToString:@"1"]) {
              self.labs.textColor = COLOR2(68);
    }else{
        
        self.labs.textColor =[UIColor redColor];
    }

}
@end
