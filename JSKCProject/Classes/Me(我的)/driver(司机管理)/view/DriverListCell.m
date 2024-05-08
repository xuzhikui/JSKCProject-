//
//  DriverListCell.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/27.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "DriverListCell.h"

@implementation DriverListCell

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
        
       
        
        self.userLab = [UILabel new];
        [self.contentView addSubview:self.userLab];
        

        self.startImg = [UIImageView new];
        [self.contentView addSubview:self.startImg];
        
        self.startLab = [UILabel new];
        [self.contentView addSubview:self.startLab];
        
        
        
        }
    
    return self;

}

- (void)layoutSubviews{
    
    
    [self.img removeFromSuperview];
    
    self.img = [[UIImageView alloc]initWithFrame:CGRectMake(28, 15, 50, 50)];
    self.img.layer.cornerRadius = 25;
    self.img.layer.masksToBounds = YES;
    [self.img sd_setImageWithURL:[NSURL URLWithString:self.dic[@"headurl"]]];
    [self.contentView addSubview:self.img];
    
   
    
    
    self.userLab.frame = CGRectMake(100, 20, Width - 200, 20);
    self.userLab.font = [UIFont systemFontOfSize:14*Width1];
    self.userLab.textColor = COLOR2(51);
    self.userLab.text = [NSString stringWithFormat:@"%@ %@",self.dic[@"name"],self.dic[@"phone"]];
    
    self.numLab.frame = CGRectMake(100, 45, Width - 200, 20);
    self.numLab.font = [UIFont systemFontOfSize:13*Width1];
    self.numLab.textColor =[UIColor grayColor];
    self.numLab.text = self.dic[@"idCardNum"];
    
    
    
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
