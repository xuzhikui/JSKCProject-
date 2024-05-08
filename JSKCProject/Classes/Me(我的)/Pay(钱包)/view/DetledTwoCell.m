//
//  DetledTwoCell.m
//  JSKCProject
//
//  Created by 孟德峰 on 2020/12/29.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "DetledTwoCell.h"

@implementation DetledTwoCell



- (void)setFrame:(CGRect)frame{
        frame.origin.x += 0;
        frame.origin.y += 0;
        frame.size.height -= 1;
        frame.size.width -= 0;
    [super setFrame:frame];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.wayLab = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.wayLab];
        
        self.cpLab = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.cpLab];
        
        self.priceLab = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.priceLab];
        
        self.timeLab = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.timeLab];
        
    }
    return self;
    
}

-(void)layoutSubviews{
    

    
    self.wayLab.frame = CGRectMake(20, 20, 200, 20);
    self.wayLab.font = [UIFont systemFontOfSize:13*Width1];
        self.wayLab.text =[NSString stringWithFormat:@"%@",self.dic[@"param1"]];
    if ([self.wayLab.text isEqualToString:@"提现成功"]) {
        
        self.wayLab.textColor = COLOR(94, 175, 69);
        
    }else if ([self.wayLab.text isEqualToString:@"提现失败"]) {
        self.wayLab.textColor = COLOR(246, 30, 30);
    }else if ([self.wayLab.text isEqualToString:@"提现中"]) {
        self.wayLab.textColor = COLOR(255, 156, 0);
    }
    
    
    
    self.cpLab.frame = CGRectMake(20, 45, 200, 20);
    self.cpLab.font = [UIFont systemFontOfSize:13*Width1];
        self.cpLab.text = [NSString stringWithFormat:@"运单数:%@",self.dic[@"param2"]];
    
    
    self.priceLab.frame = CGRectMake(Width - 120, 15, 110, 30);
    self.priceLab.font = [UIFont systemFontOfSize:18*Width1];
    self.priceLab.text = [NSString stringWithFormat:@"%@",self.dic[@"tradeAmount"]];
    self.priceLab.textColor = [UIColor blackColor];
    self.priceLab.textAlignment = 2;
    
    
    self.timeLab.frame =  CGRectMake(20, 70, 200, 20);
    self.timeLab.font = [UIFont systemFontOfSize:13*Width1];
    self.timeLab.text = [NSString stringWithFormat:@"%@",self.dic[@"updateTime"]];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
