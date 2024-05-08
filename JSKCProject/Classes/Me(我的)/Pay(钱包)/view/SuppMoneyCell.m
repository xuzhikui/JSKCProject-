//
//  SuppMoneyCell.m
//  JSKCProject
//
//  Created by 孟德峰 on 2020/12/29.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "SuppMoneyCell.h"

@implementation SuppMoneyCell

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
        
        self.selectBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.selectBut];
        
        
        self.wayLab = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.wayLab];
        
        self.cpLab = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.cpLab];
        
        self.priceLab = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.priceLab];
    }
    
    return self;
}

-(void)layoutSubviews{
    

    self.selectBut.frame = CGRectMake(20, 25, 30, 30);
    [self.selectBut setImage:[UIImage imageNamed:@"未选s1"] forState:0];
    [self.selectBut addTarget:self action:@selector(selectAction) forControlEvents:(UIControlEventTouchUpInside)];
//                      "选中s2
    
    self.wayLab.frame = CGRectMake(50, 20, 200, 20);
    self.wayLab.font = [UIFont systemFontOfSize:13*Width1];
    self.wayLab.text =[NSString stringWithFormat:@"运单号: %@",self.dic[@"waybillId"]];
    
    self.cpLab.frame = CGRectMake(50, 45, 200, 20);
    self.cpLab.font = [UIFont systemFontOfSize:13*Width1];
    self.cpLab.text = [NSString stringWithFormat:@"车牌号: %@",self.dic[@"plateNumber"]];
    
    
    self.priceLab.frame = CGRectMake(Width - 120, 15, 110, 30);
    self.priceLab.font = [UIFont systemFontOfSize:18*Width1];
    self.priceLab.text = [NSString stringWithFormat:@"%@",self.dic[@"withdrawalAmount"]];
    self.priceLab.textColor = COLOR(255, 96, 18);
    self.priceLab.textAlignment = 2;
    if ([self.dic[@"selected"] boolValue]) {
        [self.selectBut setImage:[UIImage imageNamed:@"选中s2"] forState:0];
    }else
        [self.selectBut setImage:[UIImage imageNamed:@"未选s1"] forState:0];
}

-(void)selectAction{
    if ([self.dic[@"selected"] boolValue]) {
        if (self.removeBlock) {
            self.removeBlock(self.indexPath);
        }
    }else{
        if (self.addBlock) {
            self.addBlock(self.indexPath);
        }
    }  
    
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
