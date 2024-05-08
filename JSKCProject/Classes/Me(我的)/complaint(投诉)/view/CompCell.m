//
//  CompCell.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "CompCell.h"

@implementation CompCell


- (void)setFrame:(CGRect)frame{
    frame.origin.x += 5;
    frame.origin.y += 0;
    frame.size.height -= 10;
    frame.size.width -= 10;
    [super setFrame:frame];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
      
        self.backVC = [UIImageView new];
          [self.contentView addSubview:self.backVC];
        
        self.timeImg = [UIImageView new];
        [self.contentView addSubview:self.timeImg];
        
        self.endImg = [UIImageView new];
        [self.contentView addSubview:self.endImg];
        
        self.timeLab =[UILabel new];
        [self.contentView addSubview:self.timeLab];
        
        
        _startLab = [UILabel new];
        [self.contentView addSubview:self.startLab];
        
        _startTime = [UILabel new];
        [self.contentView addSubview:_startTime];
        
        
        _overLab = [UILabel new];
        [self.contentView addSubview:self.overLab];
               
        _overTime = [UILabel new];
        [self.contentView addSubview:_overTime];
        
        
        _startareaLab = [UILabel new];
        [self.contentView addSubview:_startareaLab];
        
        
        _overareaLab = [UILabel new];
        [self.contentView addSubview:_overareaLab];
        
        
        self.jiantouImg = [UIImageView new];
        [self.contentView addSubview:self.jiantouImg];
//        self.collVC = [UICollectionView new];
//        [self.contentView addSubview:self.collVC];
        self.distLab = [UILabel new];
        [self.contentView addSubview:self.distLab];
        
        self.consumingLab = [UILabel new];
        [self.contentView addSubview:self.consumingLab];
        
        self.fgImg = [UIImageView new];
        [self.contentView addSubview:self.fgImg];
    
       
        _oneImg = [UIImageView new];
        [self.contentView addSubview:_oneImg];
        
        _twoImg = [UIImageView new];
              [self.contentView addSubview:_twoImg];
        _thereImg = [UIImageView new];
              [self.contentView addSubview:_thereImg];
        _forImg = [UIImageView new];
              [self.contentView addSubview:_forImg];
        
        _oneLab = [UILabel new];
        [self.contentView addSubview:_oneLab];
        
        _twoLab = [UILabel new];
               [self.contentView addSubview:_twoLab];
        _thereLab = [UILabel new];
               [self.contentView addSubview:_thereLab];
        
        _priceLab = [UILabel new];
               [self.contentView addSubview:_priceLab];
        
        _phoneBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_phoneBut];
  
    }
    
    return self;
}



-(void)layoutSubviews{
    

        _timeImg.frame = CGRectMake(0, 30, self.frame.size.width, 1);
        _timeImg.image = [UIImage imageNamed:@"线 拷贝"];
    
    _timeLab.frame = CGRectMake(10,5,self.frame.size.width - 20, 20);
    _timeLab.text = [NSString stringWithFormat:@"运单号: %@",self.dic[@"waybillId"]];
    _timeLab.font = [UIFont systemFontOfSize:15*Width1];
    _timeLab.textColor = [UIColor redColor];
    [self setfwb:self.timeLab];
    
    _startLab.frame = CGRectMake(30, 47, 140, 20);
    _startLab.text =self.dic[@"loadCity"];
    _startLab.font = [UIFont boldSystemFontOfSize:21*Width1];
    _startLab.textAlignment = 1;
    
        _overLab.frame = CGRectMake(Width -150, 47, 120, 20);
    _overLab.text = self.dic[@"unloadCity"];
     _overLab.font = [UIFont boldSystemFontOfSize:21*Width1];
     _overLab.textAlignment = 1;
    
        _startareaLab.frame =  CGRectMake(30, 70, 120, 20);
    _startareaLab.text = self.dic[@"loadArea"];
        _startareaLab.font = [UIFont systemFontOfSize:17*Width1];
        _startareaLab.textAlignment = 1;
    
        _overareaLab.frame =  CGRectMake(Width -150, 70, 120, 20);
        _overareaLab.text =self.dic[@"unloadArea"];
        _overareaLab.font = [UIFont systemFontOfSize:17*Width1];
        _overareaLab.textAlignment = 1;
    
    
        _jiantouImg.frame = CGRectMake(160, 60, Width - 320, 7);
        _jiantouImg.image = [UIImage imageNamed:@"箭头"];
    
        _distLab.frame = CGRectMake(160, 48, Width - 320, 12);
    _distLab.text = self.dic[@"distanceStr"];
        _distLab.textAlignment = 1;
        _distLab.font = [UIFont systemFontOfSize:11*Width1];
        _distLab.textColor = [UIColor grayColor];
    
      _consumingLab.frame = CGRectMake(160, 70, Width - 320, 12);
    _consumingLab.text = self.dic[@"durationStr"];
     _consumingLab.textAlignment = 1;
      _consumingLab.font = [UIFont systemFontOfSize:11*Width1];
        _consumingLab.textColor = [UIColor grayColor];
    
    
//    _startTime.frame =CGRectMake(30, 95, 120, 20);
//    _startTime.text = self.dic[@"planPickTime"];
//    _startTime.textAlignment = 1;
//     _startTime.font = [UIFont systemFontOfSize:11*Width1];
//      _startTime.textColor = [UIColor grayColor];
//
//
//    _overTime.frame =CGRectMake(Width -150, 95, 120, 20);
//    _overTime.text = self.dic[@"planArrivalTime"];
//    _overTime.textAlignment = 1;
//    _overTime.font = [UIFont systemFontOfSize:11*Width1];
//    _overTime.textColor = [UIColor grayColor];
    
   
    _oneLab.frame = CGRectMake(20, 100, Width - 30, 20);
    _oneLab.font = [UIFont systemFontOfSize:12*Width1];
    _oneLab.textColor = [UIColor grayColor];
    _oneLab.text = [NSString stringWithFormat:@"投诉人对象: %@",self.dic[@"cpobjectStr"]];
    
    _twoLab.frame = CGRectMake(20, 125, Width - 30, 20);
    _twoLab.font = [UIFont systemFontOfSize:12*Width1];
    _twoLab.textColor = [UIColor grayColor];
    _twoLab.text = [NSString stringWithFormat:@"投诉时间: %@",self.dic[@"createTime"]];
    
    
    
    
    _thereLab.frame = CGRectMake(Width - 150, 125, 120, 20);
    _thereLab.font = [UIFont systemFontOfSize:15*Width1];
    _thereLab.textColor = [UIColor orangeColor];
   _thereLab.text = @"处理中";
   _thereLab.textAlignment = 2;
    NSString *state = [NSString stringWithFormat:@"%@",self.dic[@"state"]];
    if ([state isEqualToString:@"0"]) {
        
    
        
        
    }else if ([state isEqualToString:@"1"]){
        
         _thereLab.textColor = COLOR(94, 178, 27);
        _thereLab.text = @"已处理";
        
    }else if ([state isEqualToString:@"2"]){
     
        
        
    }
    
}



-(void)setfwb:(UILabel *)las{
    
    NSString *str = las.text;
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    //给富文本添加属性1-字体大小
//        [attributedStr addAttribute:NSFontAttributeName
//                              value:[UIFont systemFontOfSize:14*Width1]
//                              range:NSMakeRange(0, 3)];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor blackColor]
                          range:NSMakeRange(0, 4)];
    
    
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
