//
//  CarManListCell.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/27.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "CarManListCell.h"

@implementation CarManListCell


- (void)setFrame:(CGRect)frame{
        frame.origin.x += 0;
        frame.origin.y += 0;
        frame.size.height -= 2;
        frame.size.width -= 0;
    [super setFrame:frame];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.numLab = [UILabel new];
        [self.contentView addSubview:self.numLab];
        
        self.nameLab = [UILabel new];
        [self.contentView addSubview:self.nameLab];
        
        self.userLab = [UILabel new];
        [self.contentView addSubview:self.userLab];
        

   
        
        self.numBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.numBut];
        
    
      
        
        self.loogLab = [UILabel new];
        [self.contentView addSubview:self.loogLab];
        }
    
    return self;

}

- (void)layoutSubviews{
    
    
    [self.numBut removeFromSuperview];
    
    
    
    self.numBut = [UIButton initWithFrame:CGRectMake(20, 30, 75, 25) :self.dic[@"plateNumber"]:14*Width1];
    [self.numBut setTitleColor:[UIColor blackColor] forState:0];
//    self.numBut.backgroundColor = [UIColor redColor];
    self.numBut.layer.cornerRadius = 4;
  [self.contentView addSubview:self.numBut];
   
    
    NSString *code = [NSString stringWithFormat:@"%@",self.dic[@"plateColor"]];
    if ([code isEqualToString:@"1"]) {
      [self.numBut setBackgroundImage:[UIImage imageNamed:@"黄牌"] forState:0];
    }else if([code isEqualToString:@"2"]){
        
          [self.numBut setBackgroundImage:[UIImage imageNamed:@"蓝牌"] forState:0];
        [self.numBut setTitleColor:[UIColor whiteColor] forState:0];
    }else if([code isEqualToString:@"3"]){
        
          [self.numBut setBackgroundImage:[UIImage imageNamed:@"绿牌"] forState:0];
    }
    
    self.nameLab.frame = CGRectMake(110, 20, self.frame.size.width/2 - 80, 20);
    self.nameLab.text =[NSString stringWithFormat:@"类型:%@",self.dic[@"truckType"]];
    self.nameLab.textColor = [UIColor blackColor];
    self.nameLab.font = [UIFont systemFontOfSize:12*Width1];
    [self setfwb:self.nameLab :3];
    
    self.loogLab.frame = CGRectMake(self.frame.size.width/2 + 30, 20, self.frame.size.width/2 - 50, 20);
    self.loogLab.text = [NSString stringWithFormat:@"长度: %@",self.dic[@"truckLength"]];
    self.loogLab.textColor = [UIColor blackColor];
    self.loogLab.font = [UIFont systemFontOfSize:12*Width1];
     [self setfwb:self.loogLab :3];
    
    
    self.numLab.frame = CGRectMake(110, 40, self.frame.size.width - 100, 20);
//    self.numLab.text = @" 5吨/5吨";
    self.numLab.text = [NSString stringWithFormat:@"车重/核定载(牵引)质量: %@",self.dic[@"weight"]];
    self.numLab.textColor = COLOR2(119);
    self.numLab.font = [UIFont systemFontOfSize:12*Width1];
    
    
    [self.startImg removeFromSuperview];
    [self.startLab removeFromSuperview];
    
    self.startImg = [UIImageView new];
    [self.contentView addSubview:self.startImg];
         
         self.startLab = [UILabel new];
         [self.contentView addSubview:self.startLab];
    
    
    NSString *start = [NSString stringWithFormat:@"%@",self.dic[@"verify"]];
    
    
    if ([start isEqualToString:@"0"]) {
        self.startLab.frame = CGRectMake(self.frame.size.width - 100, 30, 90, 25);
           self.startLab.text = @"认证中";
           self.startLab.textColor = COLOR(250, 147, 25);
           self.startLab.font = [UIFont systemFontOfSize:14*Width1];
           self.startLab.textAlignment = 2;
    }else  if ([start isEqualToString:@"1"]) {
        
        
        self.startImg.frame = CGRectMake(self.frame.size.width - 65, 15,55, 55);
        self.startImg.image = [UIImage imageNamed:@"已认证"];
        
        
    }else{
        
        self.startLab.frame = CGRectMake(self.frame.size.width - 100, 30, 90, 25);
                self.startLab.text = @"认证失败";
        self.startLab.textColor = [UIColor redColor];
                self.startLab.font = [UIFont systemFontOfSize:14*Width1];
                self.startLab.textAlignment = 2;
        
    }
    

}



-(void)setfwb:(UILabel *)las :(NSInteger )tags{
    
    NSString *str = las.text;
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    //给富文本添加属性1-字体大小
//        [attributedStr addAttribute:NSFontAttributeName
//                              value:[UIFont systemFontOfSize:14*Width1]
//                              range:NSMakeRange(0, 3)];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:COLOR2(119)
                          range:NSMakeRange(0, tags)];
    
    
    las.attributedText = attributedStr;
//    las.textAlignment = YES;
    
   
    
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
