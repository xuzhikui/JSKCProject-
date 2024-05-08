//
//  SourceListCell.m
//  JSKCProject
//
//  Created by XHJ on 2020/9/18.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "SourceListCell.h"
#import "loginController.h"
@implementation SourceListCell


- (void)setFrame:(CGRect)frame{
    frame.origin.x += 5;
    frame.origin.y += 0;
    frame.size.height -= 10;
    frame.size.width -= 10;
    [super setFrame:frame];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _thereButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _thereButton.frame = CGRectMake(20, 182.5, 75, 18);
        _thereButton.backgroundColor = COLOR(242, 254, 233);
        _thereButton.layer.cornerRadius = 2;
        _thereButton.layer.masksToBounds = YES;
        [_thereButton addTarget:self action:@selector(phoneAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.thereButton];
        
        self.backVC = [UIImageView new];
          [self.contentView addSubview:self.backVC];
        
        self.timeImg = [UIImageView new];
        [self.contentView addSubview:self.timeImg];
        
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
    
    
     _backVC.frame = CGRectMake(0, 0, 200, 30);
      _backVC.image = [UIImage imageNamed:@"圆角矩形 7 拷贝 2"];
    
    _timeImg.frame = CGRectMake(12, 7.5, 13, 13);
    _timeImg.image = [UIImage imageNamed:@"时间-1"];
    
    _timeLab.frame = CGRectMake(35, 7.5, 150, 15);
//    _timeLab.text = @"抢单剩于01时08分35秒";
    _timeLab.textColor = COLOR2(102);
    _timeLab.font = [UIFont systemFontOfSize:11*Width1];
      
    NSString *code = [NSString stringWithFormat:@"%@",self.dic[@"longterm"]];
    if ([code isEqualToString:@"1"]) {
     _timeLab.text = @"此货源 长期有效";
        [self setfwbs:_timeLab];
    }

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
    
 
        _thereImg.frame = CGRectMake(25, 187.5, 10, 10);
         _thereImg.image = [UIImage imageNamed:@"立即沟通"];
    
    _thereLab.frame =  CGRectMake(40, 185, Width/2  -40, 13);
    _thereLab.font = [UIFont systemFontOfSize:11*Width1];
    _thereLab.textColor = COLOR(112, 175, 62);
    _thereLab.text = @"立即沟通";
    
    _forImg.frame = CGRectMake(self.frame.size.width - 120, 145, 13, 13);
    _forImg.image = [UIImage imageNamed:@"价格-01-1"];
    
    _priceLab.frame =  CGRectMake(self.frame.size.width - 100, 145, 80, 13);
    _priceLab.font = [UIFont systemFontOfSize:11*Width1];
    _priceLab.textColor = [UIColor redColor];
   
    _priceLab.text = [NSString stringWithFormat:@"%@%@",self.dic[@"freight"],self.dic[@"freightType"]];
    [self setfwbs:_priceLab];
    
    _phoneBut.frame =CGRectMake(self.frame.size.width - 120, 170, 80, 25);
    [_phoneBut setBackgroundImage:[UIImage imageNamed:@"圆角矩形 6"] forState:0];
    [_phoneBut setTitle:@"立即抢单" forState:0];
    [_phoneBut setTitleColor:[UIColor whiteColor] forState:0];
    [_phoneBut setImage:[UIImage imageNamed:@"立即抢单"] forState:0];
    [_phoneBut addTarget:self action:@selector(grabAnOrderFunction) forControlEvents:(UIControlEventTouchUpInside)];
    _phoneBut.titleLabel.font = [UIFont systemFontOfSize:11*Width1];
      [ _phoneBut setImageEdgeInsets:UIEdgeInsetsMake(0, -5 , 0,  0)];
    [_phoneBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
}


-(void)phoneAction{
    
    
    if ([UserModel shareInstance].accessToken == nil) {
//        if ([TXCommonUtils simSupportedIsOK] && [TXCommonUtils checkDeviceCellularDataEnable]) {
//            LoginController *logVC =  [LoginController new];
//            [[AFN_DF topViewController].navigationController pushViewController:logVC animated:YES];
//        }else{
//            PhoneLoginController *logVC =  [PhoneLoginController new];
//            [[AFN_DF topViewController].navigationController pushViewController:logVC animated:YES];
//        }
        PhoneLoginController *logVC =  [PhoneLoginController new];
        [[AFN_DF topViewController].navigationController pushViewController:logVC animated:YES];
    }else{
        
        if([[NSString stringWithFormat:@"%@",[UserModel shareInstance].cyrVerify] isEqualToString:@"0"]){
        
            InfoVC *infoVC = [[InfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
            infoVC.tag = 1;
            [UIApplication.sharedApplication.keyWindow addSubview:infoVC];
        }else{
            
            NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.dic[@"sendContactPhone"]];
              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }
}

- (void)grabAnOrderFunction{
    if (self.grabAnOrderBlock) {
        self.grabAnOrderBlock(self.indexPath);
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
                          value:[UIColor redColor]
                          range:NSMakeRange(4, 4)];
    
    
    las.attributedText = attributedStr;
//    las.textAlignment = YES;
    
   
    
}


-(void)setfwbs:(UILabel *)las{
    
    NSString *str = las.text;
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    //给富文本添加属性1-字体大小
//        [attributedStr addAttribute:NSFontAttributeName
//                              value:[UIFont systemFontOfSize:14*Width1]
//                              range:NSMakeRange(0, 3)];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor grayColor]
                          range:NSMakeRange(las.text.length  - 3, 3)];
    
    
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
