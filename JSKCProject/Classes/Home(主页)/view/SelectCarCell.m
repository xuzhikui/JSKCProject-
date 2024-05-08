//
//  SelectCarCell.m
//  JSKCProject
//
//  Created by XHJ on 2020/9/22.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "SelectCarCell.h"

@implementation SelectCarCell

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 0;
    frame.origin.y += 0;
    frame.size.height -= 0;
    frame.size.width -= 0;
    [super setFrame:frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
      
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.carLab = [UILabel new];
        [self.contentView addSubview:self.carLab];
        
        self.zlLab = [UILabel new];
        [self.contentView addSubview:self.zlLab];
        
        self.nameLab = [UILabel new];
        [self.contentView addSubview:self.nameLab];
        
        self.selectBut = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:self.selectBut];
        
        self.fg1 = [UIView new];
        [self.contentView addSubview:self.fg1];
    }
    
    return self;
    
}


- (void)layoutSubviews{
    
    
    NSLog(@"%@",[UserModel shareInstance].accessToken);
    
    self.carLab.frame = CGRectMake(0, 10, Width/4, 30);
    self.carLab.font = [UIFont systemFontOfSize:14*Width1];
    self.carLab.text = self.dic[@"plateNumber"];
    self.carLab.textColor = [UIColor grayColor];
    self.carLab.textAlignment = 1;
    self.zlLab.frame = CGRectMake(Width/4, 10, Width/4, 30);
    self.zlLab.font = [UIFont systemFontOfSize:14*Width1];
    self.zlLab.text = [NSString stringWithFormat:@"%@吨",self.dic[@"approvedWeight"]];
    self.zlLab.textColor = [UIColor grayColor];
    self.zlLab.textAlignment = 1;
    
    
    self.nameLab.frame = CGRectMake(Width/2, 10, Width/4, 30);
    self.nameLab.font = [UIFont systemFontOfSize:14*Width1];
    self.nameLab.text = self.dic[@"mainDriver"];
    self.nameLab.textColor = [UIColor grayColor];
    self.nameLab.textAlignment = 1;
    
    self.selectBut.frame = CGRectMake(Width/4 * 3 - 10, 10, Width/4, 30);
    [self.selectBut setTitleColor:[UIColor redColor] forState:0];
    self.selectBut.titleLabel.font = [UIFont systemFontOfSize:14*Width1];
    [self.selectBut setTitle:@"选择" forState:0];
    [self.selectBut addTarget:self action:@selector(selectAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    NSString *driverId =  [NSString stringWithFormat:@"%@",self.dic[@"driverId"]];
              if ([driverId isEqualToString:@"0"]) {
                    [self.selectBut setTitle:@"绑定主驾" forState:0];
                    [self.selectBut setTitleColor:[UIColor orangeColor] forState:0];
                      self.selectBut.userInteractionEnabled = YES;
              }else{
                  
                  NSString *codes = [NSString stringWithFormat:@"%@",self.dic[@"usabled"]];
                  
                  if ([codes isEqualToString:@"0"]) {
                      [self.selectBut setTitleColor:[UIColor grayColor] forState:0];
                      self.selectBut.userInteractionEnabled = NO;
                  }else{
                      self.selectBut.userInteractionEnabled = YES;

                      }
                  
                  
              }
    
    
    

    
   

    
   
    
    
  
    
    
    self.fg1.frame = CGRectMake(20, 49,self.frame.size.width - 40, 1);
    self.fg1.backgroundColor = COLOR2(203);
    
}

-(void)selectAction{
    
     NSString *driverId =  [NSString stringWithFormat:@"%@",self.dic[@"driverId"]];
    
    if ([driverId isEqualToString:@"0"]) {
        self.bdblock(self.dic);
    }else{
         self.block(self.dic);
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
