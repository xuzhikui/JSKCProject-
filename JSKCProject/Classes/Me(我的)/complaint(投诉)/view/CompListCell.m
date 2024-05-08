//
//  CompListCell.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "CompListCell.h"

@implementation CompListCell


- (void)setFrame:(CGRect)frame{
    frame.origin.x += 20;
    frame.origin.y += 0;
    frame.size.height -= 10;
    frame.size.width -= 40;
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
    

      [UILabel initWithDFLable:CGRectMake(0, 10, 200, 25) :[UIFont systemFontOfSize:15*Width1] :[UIColor blackColor] :@"选择运单" :self.contentView :0];
    
    self.backVC.frame = CGRectMake(0, 40, self.frame.size.width, 100);
    self.backVC.layer.borderColor = [COLOR2(203) CGColor];
    self.backVC.layer.borderWidth = 1;
    self.backVC.layer.cornerRadius = 4;
    
    
      _timeImg.frame = CGRectMake(0, 70, self.frame.size.width, 1);
     _timeImg.image = [UIImage imageNamed:@"线 拷贝"];
    
    _timeLab.frame = CGRectMake(10,45,self.frame.size.width - 20, 20);
    _timeLab.text = [NSString stringWithFormat:@"运单号: %@",self.dic[@"waybillId"]];
    _timeLab.font = [UIFont systemFontOfSize:15*Width1];
    _timeLab.textColor = [UIColor redColor];
    [self setfwb:self.timeLab];
    
    _startLab.frame = CGRectMake(0, 87, self.frame.size.width/2 - 70, 20);
    _startLab.text =self.dic[@"loadCity"];
    _startLab.font = [UIFont boldSystemFontOfSize:21*Width1];
    _startLab.textAlignment = 2;
    
        _overLab.frame = CGRectMake(self.frame.size.width/2 + 70, 87, 120, 20);
    _overLab.text = self.dic[@"unloadCity"];
     _overLab.font = [UIFont boldSystemFontOfSize:21*Width1];
     _overLab.textAlignment = 0;
    
    _startareaLab.frame =  CGRectMake(0, 110, self.frame.size.width/2 - 70, 20);
    _startareaLab.text = self.dic[@"loadArea"];
        _startareaLab.font = [UIFont systemFontOfSize:17*Width1];
        _startareaLab.textAlignment = 2;
    
    _overareaLab.frame =  CGRectMake( self.frame.size.width/2 + 70, 110, 120, 20);
        _overareaLab.text =self.dic[@"unloadArea"];
        _overareaLab.font = [UIFont systemFontOfSize:17*Width1];
        _overareaLab.textAlignment = 0;
    
    
    _jiantouImg.frame = CGRectMake(self.frame.size.width/2 - 50, 100,100, 7);
        _jiantouImg.image = [UIImage imageNamed:@"箭头"];
    
        _distLab.frame = CGRectMake(self.frame.size.width/2 - 50, 88, 100, 12);
    _distLab.text = self.dic[@"distanceStr"];
        _distLab.textAlignment = 1;
        _distLab.font = [UIFont systemFontOfSize:11*Width1];
        _distLab.textColor = [UIColor grayColor];
    
        _consumingLab.frame = CGRectMake(self.frame.size.width/2 - 50, 110, 100, 12);
        _consumingLab.text = self.dic[@"durationStr"];
        _consumingLab.textAlignment = 1;
        _consumingLab.font = [UIFont systemFontOfSize:11*Width1];
            _consumingLab.textColor = [UIColor grayColor];
    
    

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
