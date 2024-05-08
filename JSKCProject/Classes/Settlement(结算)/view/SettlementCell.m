//
//  SettlementCell.m
//  JSKCProject
//
//  Created by XHJ on 2020/12/25.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "SettlementCell.h"
#import "ComplaintController.h"
#import "AddCompController.h"
#import "SuppCommController.h"
@implementation SettlementCell


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
    

    
    [self.tsBut removeFromSuperview];
    _tsBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _tsBut.frame =CGRectMake(self.frame.size.width - 170, 170, 60, 25);
    [ _tsBut setTitle:@"投诉" forState:0];
    [ _tsBut setTitleColor:[UIColor redColor] forState:0];
    _tsBut.titleLabel.font = [UIFont systemFontOfSize:11*Width1];
    _tsBut.hidden = YES;
    [ _tsBut addTarget:self action:@selector(tsActrion) forControlEvents:(UIControlEventTouchUpInside)];
    _tsBut.layer.cornerRadius = 4;
    _tsBut.backgroundColor = [UIColor whiteColor];
    _tsBut.layer.borderColor = [[UIColor redColor]CGColor];
    _tsBut.layer.borderWidth = 1;
    
    
    _phoneBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _phoneBut.frame =CGRectMake(self.frame.size.width - 100, 170, 60, 25);
    [_phoneBut setTitle:@"评价" forState:0];
    [_phoneBut setTitleColor:[UIColor whiteColor] forState:0];
    _phoneBut.titleLabel.font = [UIFont systemFontOfSize:11*Width1];
       _phoneBut.hidden = NO;
    [_phoneBut addTarget:self action:@selector(suppcommActrion) forControlEvents:(UIControlEventTouchUpInside)];
      _phoneBut.layer.cornerRadius = 4;
    _phoneBut.backgroundColor = [UIColor redColor];
    
    
    
    
    [_thereImg removeFromSuperview];
    [_thereLab removeFromSuperview]
    ;
    
    [self.contentView addSubview:self.phoneBut];
    [self.contentView addSubview:self.tsBut];
    NSString *state = [NSString stringWithFormat:@"%@",self.dic[@"verify"]];
    
    
    
//    ，0、没有申请记录，1、内部审核中，2、内部审核通过（平台待审核），3、内部审核失败（可提交申请），4、平台审核成功（待打款），5、平台审核失败，6、已打款，7、打款回退（需重新平台审核）8、打款失败
    
    if ([state isEqualToString:@"0"]){

    
            self.endImg.frame = CGRectMake(self.frame.size.width - 70, 145, 55, 55);
            self.endImg.image = [UIImage imageNamed:@"待核算"];
                _phoneBut.hidden = YES;
                [self.contentView addSubview:self.endImg];
    }else if ([state isEqualToString:@"1"] || [state isEqualToString:@"2"]){
        
        self.endImg.frame = CGRectMake(self.frame.size.width - 70, 145, 55, 55);
        self.endImg.image = [UIImage imageNamed:@"付款审核中"];
        _phoneBut.hidden = YES;
            [self.contentView addSubview:self.endImg];
        
    }else if ([state isEqualToString:@"3"] || [state isEqualToString:@"5"]){
        
        self.endImg.frame = CGRectMake(self.frame.size.width - 70, 145, 55, 55);
        self.endImg.image = [UIImage imageNamed:@"审核失败"];
        _phoneBut.hidden = YES;
            [self.contentView addSubview:self.endImg];
        
    }else if ([state isEqualToString:@"8"]){
        
        
        self.endImg.frame = CGRectMake(self.frame.size.width - 70, 145, 55, 55);
        self.endImg.image = [UIImage imageNamed:@"打款失败"];
        _phoneBut.hidden = YES;
            [self.contentView addSubview:self.endImg];
}else if ([state isEqualToString:@"4"]){
    
    
    self.endImg.frame = CGRectMake(self.frame.size.width - 70, 145, 55, 55);
    self.endImg.image = [UIImage imageNamed:@"待付款"];
    _phoneBut.hidden = YES;
        [self.contentView addSubview:self.endImg];
}else if ([state isEqualToString:@"6"]){

    
//
//
//    ///已结清
//    _phoneBut.hidden = NO;
////    [self.contentView addSubview:_phoneBut];
//
//    _tsBut.hidden = NO;
//
//
    
}else if ([state isEqualToString:@"7"]){
    
    ///打款回退
    self.endImg.frame = CGRectMake(self.frame.size.width - 70, 145, 55, 55);
    self.endImg.image = [UIImage imageNamed:@"付款审核中"];
    _phoneBut.hidden = YES;
        [self.contentView addSubview:self.endImg];
    
    
}
    
    
    
    
    NSString *sjEvaluated = [NSString stringWithFormat:@"%@",self.dic[@"sjEvaluated"]];
    if (![sjEvaluated isEqualToString:@"0"]) {
//        _phoneBut.layer.borderWidth = 0;
//        _phoneBut.backgroundColor = [UIColor grayColor];
//        _phoneBut.userInteractionEnabled = NO;
        _tsBut.frame = CGRectMake(self.frame.size.width - 100, 170, 60, 25);
        _phoneBut.hidden = YES;
    }else
        _tsBut.frame = CGRectMake(self.frame.size.width - 170, 170, 60, 25);

    
    NSString *sjComplainted = [NSString stringWithFormat:@"%@",self.dic[@"sjComplainted"]];
    if (![sjComplainted isEqualToString:@"0"]) {
//        _tsBut.layer.borderWidth = 0;
//        _tsBut.backgroundColor = [UIColor grayColor];
//        _tsBut.userInteractionEnabled = NO;
//        [_tsBut setTitleColor:[UIColor whiteColor] forState:0];
        _tsBut.hidden = YES;
    }else{
        _tsBut.hidden = NO;
    }

  

}


///评论

-(void)suppcommActrion{
    
    SuppCommController *suppVC = [SuppCommController new];
    suppVC.dic = self.dic;
    [[AFN_DF topViewController].navigationController pushViewController:suppVC animated:YES];
}


-(void)tsActrion{
    
   AddCompController *compVC = [AddCompController new];
    compVC.wayDic = self.dic;
    [[AFN_DF topViewController].navigationController pushViewController:compVC animated:YES];
    
    
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
