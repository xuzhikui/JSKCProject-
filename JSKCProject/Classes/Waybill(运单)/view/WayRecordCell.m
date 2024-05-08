//
//  WayRecordCell.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/26.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "WayRecordCell.h"

@implementation WayRecordCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setUI];
        
    }
    
    return self;
}

-(void)setUI{
    
    _statsLab = [UILabel new];
    [self.contentView addSubview:_statsLab];
    
    _img = [UIImageView new];
    [self.contentView addSubview:_img];
    
    _userEndinfoLab = [UILabel new];
    [self.contentView addSubview:_userEndinfoLab];
    
    _zlLab = [UILabel new];
    [self.contentView addSubview:_zlLab];
    
    _pzLab = [UILabel new];
    [self.contentView addSubview:_pzLab];
    
    _userLab = [UILabel new];
    [self.contentView addSubview:_userLab];
    

    _timeLab = [UILabel new];
    [self.contentView addSubview:_timeLab];
    
    self.one1 = [UILabel new];
    [self.contentView addSubview:_one1];
    
    self.one2 = [UILabel new];
    [self.contentView addSubview:_one2];
    
    self.one3 = [UILabel new];
    [self.contentView addSubview:_one3];
    
    self.one4 = [UILabel new];
    [self.contentView addSubview:_one4];
    
    
}


-(void)layoutSubviews{
    
    
    
    UIColor *color = [UIColor grayColor];
    
    _statsLab.frame  = CGRectMake(30, 0, 80, 20);
    _statsLab.textColor = color;
    _statsLab.font = [UIFont systemFontOfSize:15*Width1];
    _statsLab.text = self.dic[@"state"];
    
    if ([self.code isEqualToString:@"0"]) {
             _statsLab.textColor = [UIColor redColor];
                color = COLOR2(51);
         }
   
    
    _img.frame = CGRectMake(120, 0, 20, 20);
  
    _img.image = [UIImage imageNamed:@"椭圆 2 拷贝"];
    if([_statsLab.text isEqualToString:@"已接单"]){
         _img.image = [UIImage imageNamed:@"始"];
        
    }
    
    
    
    if ([self.code isEqualToString:@"0"]) {
        
        if ([_statsLab.text isEqualToString:@"已发货"]) {
            _img.image = [UIImage imageNamed:@"向上1"];
        }else if([_statsLab.text isEqualToString:@"已收货"] || [_statsLab.text isEqualToString:@"已送达"]){
              _img.image = [UIImage imageNamed:@"终"];
             
         }else if([_statsLab.text isEqualToString:@"待发货"]){
              _img.image = [UIImage imageNamed:@"运输"];
             
         }else  if([_statsLab.text isEqualToString:@"已接单"]){
                 _img.image = [UIImage imageNamed:@"开始"];
                
         }else if ([_statsLab.text isEqualToString:@"已签收"]){
        
                _img.image = [UIImage imageNamed:@"终"];
    }else if ([_statsLab.text isEqualToString:@"运输中"]){
         
         _img.image = [UIImage imageNamed:@"向上1"];
    }else if ([_statsLab.text isEqualToString:@"已取消"]){
        
        _img.image = [UIImage imageNamed:@"终"];
   }
 
    }
    
    
    _timeLab.frame = CGRectMake(160, 0, 300, 20);
    _timeLab.textColor = color;
    _timeLab.text = self.dic[@"operateTime"];
    _timeLab.font = [UIFont systemFontOfSize:15*Width1];
    
    
    [self.imgs removeFromSuperview];
    
    if ([self.code isEqualToString:@"3"]) {
        
    }else{
        
        self.imgs = [[UIImageView alloc]initWithFrame:CGRectMake(129.5, 22, 1, self.frame.size.height - 24)];
        self.imgs.backgroundColor = COLOR2(210);
        [self.contentView addSubview:self.imgs];
    }
    
  
    
    
  

    NSArray *arr = @[self.dic[@"contentThird"],self.dic[@"contentSecond"],self.dic[@"contentFirst"],self.dic[@"operator"]];
    
    
    NSArray *arrs = @[self.one1,self.one2,self.one3,self.one4];
     
    
    for (int i = 0; i < 4; i++) {
        
        UILabel *lab = arrs[i];
        lab.frame = CGRectMake(160, 30 + (25*i), 300, 20);
        lab.font = [UIFont systemFontOfSize:15*Width1];
        lab.textColor = color;
        lab.text = arr[i];
  
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
