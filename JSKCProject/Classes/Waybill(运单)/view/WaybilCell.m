//
//  WaybilCell.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/22.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "WaybilCell.h"
#import "WayCanlVC.h"
#import "EndSendWayVC.h"
@implementation WaybilCell

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
       
        _forImg = [UIImageView new];
              [self.contentView addSubview:_forImg];
        
        _oneLab = [UILabel new];
        [self.contentView addSubview:_oneLab];
        
        _twoLab = [UILabel new];
               [self.contentView addSubview:_twoLab];
      
        
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
    
        _startareaLab.frame =  CGRectMake(30, 70, 140, 20);
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
    
    
    _startTime.frame =CGRectMake(30, 95, 120, 20);
    _startTime.text = self.dic[@"planPickTime"];
    _startTime.textAlignment = 1;
     _startTime.font = [UIFont systemFontOfSize:11*Width1];
      _startTime.textColor = [UIColor grayColor];
    
    
    _overTime.frame =CGRectMake(Width -150, 95, 120, 20);
    _overTime.text = self.dic[@"planArrivalTime"];
    _overTime.textAlignment = 1;
    _overTime.font = [UIFont systemFontOfSize:11*Width1];
    _overTime.textColor = [UIColor grayColor];
    
    
//
    _fgImg.frame = CGRectMake(16, 125, self.frame.size.width - 32, 1);
    _fgImg.image = [UIImage imageNamed:@"矩形 9"];
    
  
    
    
    _oneImg.frame = CGRectMake(20, 135, 13, 13);
    _oneImg.image = [UIImage imageNamed:@"货物-01-1"];
    
    _oneLab.frame =  CGRectMake(40, 135, Width/2  -40, 13);
    _oneLab.font = [UIFont systemFontOfSize:11*Width1];
    _oneLab.textColor = [UIColor grayColor];
    _oneLab.text = self.dic[@"goods"];
    
    _twoImg.frame = CGRectMake(20, 160, 13, 13);
      _twoImg.image = [UIImage imageNamed:@"车型-01-1"];
    
    _twoLab.frame =  CGRectMake(40, 160, Width/2  -40, 13);
    _twoLab.font = [UIFont systemFontOfSize:11*Width1];
    _twoLab.textColor = [UIColor grayColor];
    _twoLab.text = self.dic[@"truck"];

    _forImg.frame = CGRectMake(self.frame.size.width - 120, 145, 13, 13);
    _forImg.image = [UIImage imageNamed:@"价格-01-1"];
    
    _priceLab.frame =  CGRectMake(self.frame.size.width - 100, 145, 80, 13);
    _priceLab.font = [UIFont systemFontOfSize:11*Width1];
    _priceLab.textColor = [UIColor redColor];
   
    _priceLab.text = [NSString stringWithFormat:@"%@%@",self.dic[@"freight"],self.dic[@"freightType"]];
    [self setfwbcell:self.priceLab];
    
    
    if (_phoneBut != nil) {
        
        [_phoneBut removeFromSuperview];
        
        
    }
    
    if (_endImg != nil) {
           
           [_endImg removeFromSuperview];
           
           
       }
    
    _phoneBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _phoneBut.frame =CGRectMake(self.frame.size.width - 120, 170, 80, 25);
    [_phoneBut setTitle:@"确认发货" forState:0];
    [_phoneBut setTitleColor:[UIColor whiteColor] forState:0];
    _phoneBut.titleLabel.font = [UIFont systemFontOfSize:11*Width1];
       _phoneBut.hidden = NO;
    [_phoneBut addTarget:self action:@selector(phoneActrion) forControlEvents:(UIControlEventTouchUpInside)];
      _phoneBut.layer.cornerRadius = 4;
    
    
    
    
    [_thereImg removeFromSuperview];
    [_thereLab removeFromSuperview]
    ;
    
    [self.contentView addSubview:self.phoneBut];
    if ([self.code isEqualToString:@"3"]) {
        
        _thereImg = [UIImageView new];
              [self.contentView addSubview:_thereImg];
        _thereLab = [UILabel new];
               [self.contentView addSubview:_thereLab];
        
        _thereImg.frame = CGRectMake(20, 185, 13, 13);
         _thereImg.image = [UIImage imageNamed:@"距离-1"];

        _thereLab.frame =  CGRectMake(40, 185, Width/2  -40, 13);
        _thereLab.font = [UIFont systemFontOfSize:11*Width1];
        _thereLab.textColor = [UIColor grayColor];
        _thereLab.text = self.dic[@"localDistanceStr"];
        
         [_phoneBut setBackgroundImage:[UIImage imageNamed:@"圆角矩形 6"] forState:0];
    }else if ([self.code isEqualToString:@"4"]){
        
        
        NSString *state = [NSString stringWithFormat:@"%@",self.dic[@"state"]];
        
        if ([state isEqualToString:@"4"]) {
            [_phoneBut setBackgroundImage:[UIImage imageNamed:@"圆角矩形 6"] forState:0];
                 [_phoneBut setTitle:@"确认到达" forState:0];
        }
        if ([state isEqualToString:@"5"]) {
            
            self.endImg.frame = CGRectMake(self.frame.size.width - 70, 145, 55, 55);
                         self.endImg.image = [UIImage imageNamed:@"代签收"];
                             _phoneBut.hidden = YES;
                  [self.contentView addSubview:self.endImg];
        }
     
        
    }else if ([self.code isEqualToString:@"6"]){
        
        self.endImg.frame = CGRectMake(self.frame.size.width - 70, 145, 55, 55);
               self.endImg.image = [UIImage imageNamed:@"已完成"];
                   _phoneBut.hidden = YES;
        [self.contentView addSubview:self.endImg];
        
    }else if ([self.code isEqualToString:@"7"]){
        
        
        
        [_phoneBut setTitle:@"删除订单" forState:0];
        _phoneBut.layer.borderWidth = 1;
        _phoneBut.layer.borderColor = [COLOR2(119)CGColor];
        [_phoneBut setTitleColor:COLOR2(119) forState:0];
        _phoneBut.backgroundColor = [UIColor whiteColor];
      
    }
    
    if ([self.type isEqualToString:@"comps"]) {
          
          [_phoneBut setTitle:@"确认选择" forState:0];
          _phoneBut.backgroundColor = [UIColor redColor];
          
      }
    
  
    
    
//  已完成
    
    
}

-(void)phoneActrion{
    
    
    if ([self.type isEqualToString:@"comps"]) {
        ///投诉选择
        
        self.endBlock(self.dic);
        
        
        
        
    }else{
    
    
    if ([self.code isEqualToString:@"3"]) {
        //确认发货
        [[AFN_DF topViewController].navigationController setNavigationBarHidden:YES animated:YES];
        EndSendWayVC *endVC = [[EndSendWayVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        endVC.vc = [AFN_DF topViewController];
        endVC.dic = self.dic;
        endVC.canlCode = @"1";
        WeakSelf
        endVC.block = ^(NSDictionary * _Nonnull dic) {
                weakSelf.block(dic);
            [[AFN_DF topViewController].navigationController setNavigationBarHidden:YES animated:YES];
            
        };
        
        [[AFN_DF topViewController].view addSubview:endVC];
        
            
        
        
    }else if ([self.code isEqualToString:@"4"]){
        
        
        self.endBlock(self.dic);
        
        
        
        
    }else if ([self.code isEqualToString:@"7"]){
        
        __weak WaybilCell *weskSelf = self;
        ///取消订单
        [AFN_DF topViewController].tabBarController.tabBar.hidden = YES;
        WayCanlVC *vc = [[WayCanlVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        vc.dic = self.dic;
        vc.code = @"1";
        vc.bolock = ^(NSString * _Nonnull code) {
          
            weskSelf.removeBlock(self.dic);
        };
        [[AFN_DF topViewController].view addSubview:vc];
    }
    
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

-(void)setfwbcell:(UILabel *)las{
    
    NSString *str = las.text;
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    //给富文本添加属性1-字体大小
//        [attributedStr addAttribute:NSFontAttributeName
//                              value:[UIFont systemFontOfSize:14*Width1]
//                              range:NSMakeRange(0, 3)];

    if (las.text.length > 3) {
            [attributedStr addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor grayColor]
                                 range:NSMakeRange(las.text.length - 3,3)];
    }
    
    
  
    
    
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
