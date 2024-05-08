//
//  MeassListCell.m
//  JSKCProject
//
//  Created by 孟德峰 on 2021/2/3.
//  Copyright © 2021 孟德峰. All rights reserved.
//

#import "MeassListCell.h"

@implementation MeassListCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.img =[[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.img];
        
        self.tipImg =[[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.tipImg];
        
        self.titLab = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.titLab];
        
        self.costLab = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.costLab];
        
        self.timeLab = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.timeLab];
    
    }
    
    return self;
}



-(void)layoutSubviews{
    
    
    
    self.img.frame = CGRectMake(15, 20, 35, 35);
    self.img.backgroundColor = [UIColor whiteColor];
    [self.img sd_setImageWithURL:[NSURL URLWithString:self.dic[@"typeIco"]] placeholderImage:[UIImage imageNamed:@"消息-订单"]];
    
    self.tipImg.frame = CGRectMake(50, 16, 3, 3);
    self.tipImg.backgroundColor = [UIColor redColor];
    self.tipImg.layer.cornerRadius = 1.5;
    self.tipImg.layer.masksToBounds = YES;
    
    
    NSString *readed = [NSString stringWithFormat:@"%@",self.dic[@"readed"]];

    
    if ([readed isEqual:@"0"]) {
        self.tipImg.backgroundColor = [UIColor redColor];
    }else{
        self.tipImg.backgroundColor = [UIColor whiteColor];

    }
    
    
    NSString *code = [NSString stringWithFormat:@"%@",self.dic[@"type"]];
    
    
    
    
    self.titLab.frame = CGRectMake(60, 18, 150, 15);
    self.titLab.font = [UIFont systemFontOfSize:15*Width1];
    
    self.titLab.text = @"订单消息";

    
    if ([code isEqualToString:@"0"]) {
        self.titLab.text = @"系统消息";
    }
    
    
    self.titLab.text = self.dic[@"title"];
    
    self.costLab.frame = CGRectMake(60, 40, Width - 70, 15);
    self.costLab.font = [UIFont systemFontOfSize:12*Width1];
    self.costLab.textColor  =  COLOR2(153);
    self.costLab.text = self.dic[@"summary"];
    
    
    self.timeLab.frame = CGRectMake(Width - 160, 20, 150, 15);
    self.timeLab.font = [UIFont systemFontOfSize:12*Width1];
    self.timeLab.textAlignment = 2;
    self.timeLab.textColor = COLOR2(153);
    self.timeLab.text = self.dic[@"createTime"];
    
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 75, Width, 1)];
    back.backgroundColor = COLOR2(240);
    [self.contentView addSubview:back];
    
    
    
    
    
    
    
    
    
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
