//
//  BindMasterCell.m
//  JSKCProject
//
//  Created by XHJ on 2020/9/22.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "BindMasterCell.h"

@implementation BindMasterCell


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
        
        
        
        self.phoneLab = [UILabel new];
        [self.contentView addSubview:self.phoneLab];
        
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
    
    
    
    [self.phoneLab removeFromSuperview];
    [self.nameLab removeFromSuperview];

    
    
    self.phoneLab = [UILabel new];
    [self.contentView addSubview:self.phoneLab];
    
    self.nameLab = [UILabel new];
    [self.contentView addSubview:self.nameLab];
    

    self.nameLab.frame = CGRectMake(20, 10, 60, 30);
    self.nameLab.font = [UIFont systemFontOfSize:14*Width1];
    self.nameLab.text = self.dic[@"name"];
    self.nameLab.textColor = [UIColor grayColor];
//    self.nameLab.textAlignment = 1;
    
    
    self.phoneLab.frame = CGRectMake(self.frame.size.width/2 - 80, 10, 160, 30);
    self.phoneLab.font = [UIFont systemFontOfSize:14*Width1];
    self.phoneLab.text = self.dic[@"phone"];
   self.phoneLab.textColor = [UIColor grayColor];
    self.phoneLab.textAlignment = 1;
    
    
//    self.nameLab.frame = CGRectMake(Width/2, 10, Width/4, 30);
//    self.nameLab.font = [UIFont systemFontOfSize:14*Width1];
//    self.nameLab.text = @"王振吉";
//    self.nameLab.textColor = [UIColor grayColor];
//    self.nameLab.textAlignment = 1;
    
    self.selectBut.frame = CGRectMake(self.frame.size.width - 100,10, 80, 30);
    [self.selectBut setTitleColor:[UIColor redColor] forState:0];
    self.selectBut.titleLabel.font = [UIFont systemFontOfSize:14*Width1];
    [self.selectBut setTitle:@"选择" forState:0];
    [self.selectBut addTarget:self action:@selector(seleAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    NSString *hasBind  = [NSString stringWithFormat:@"%@",self.dic[@"hasBind"]];
       
       if ([hasBind isEqualToString:@"0"]) {

          
             self.selectBut.userInteractionEnabled = YES;
       }else{
           
            [self.selectBut setTitleColor:[UIColor grayColor] forState:0];
            self.selectBut.userInteractionEnabled = NO;
       }
 
    
    
    self.fg1.frame = CGRectMake(20, 49,self.frame.size.width - 40, 1);
    self.fg1.backgroundColor = COLOR2(203);
    
}


-(void)seleAction{
    
    
    self.block(self.dic);
    
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
