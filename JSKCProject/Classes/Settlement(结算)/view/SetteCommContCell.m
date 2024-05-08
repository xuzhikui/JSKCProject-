//
//  SetteCommContCell.m
//  JSKCProject
//
//  Created by 孟德峰 on 2020/12/27.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "SetteCommContCell.h"

@implementation SetteCommContCell

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 5;
    frame.origin.y += 0;
    frame.size.height -= 10;
    frame.size.width -= 10;
    [super setFrame:frame];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
      
//        self.backVC = [UIImageView new];
//          [self.contentView addSubview:self.backVC];
        
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
        
        self.backVC = [UIView new];
        [self.contentView addSubview:self.backVC];
        
        self.commLab = [UILabel new];
        [self.backVC addSubview:self.commLab];
       
        
        
        
        

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
    
    
    NSString *str = self.dic[@"content"];
    if (str == nil || [str isEqualToString:@""]) {
        str = @"当前暂无评论";
    }
    CGSize widSize =  [self sizeWithFont:[UIFont systemFontOfSize:14*Width1] maxWidth:Width - 60 maxStr:str];
    
    self.backVC.frame  = CGRectMake(10, 130, self.frame.size.width - 20, 40 + widSize.height);
    self.backVC.layer.borderColor = [COLOR2(220)CGColor];
    self.backVC.layer.borderWidth = 1;
    self.backVC.layer.cornerRadius = 4;
    
   
    self.commLab.frame = CGRectMake(20, 10, self.backVC.frame.size.width - 40, widSize.height);
    self.commLab.font = [UIFont systemFontOfSize:14*Width1];
    self.commLab.text = str;
    self.commLab.numberOfLines = 0;
    self.commLab.textColor = [UIColor grayColor];

    
    [UILabel initWithDFLable:CGRectMake(20, self.backVC.frame.size.height - 30, 40, 25) :[UIFont systemFontOfSize:14*Width1] :[UIColor grayColor] :@"评分:" :self.backVC :0];
    NSString *tag = self.dic[@"star"];
    LHRatingView * rView = [[LHRatingView alloc]initWithFrame:CGRectMake(65,self.backVC.frame.size.height - 30, 100, 25)];
//    rView.center = self.view.center;
        rView.ratingType = INTEGER_TYPE;//整颗星
        rView.score = tag.integerValue;
//    rView.delegate = self;
    [self.backVC addSubview:rView];
    rView.userInteractionEnabled = NO;
    
    NSString *codestr = @"";
    if (tag.integerValue == 1) {
        codestr = @"非常差";
    }else if (tag.integerValue == 2){
        
        codestr = @"差";
    }else if (tag.integerValue == 3){
        
        codestr = @"一般";
    }else if (tag.integerValue == 4){
        
        codestr = @"好";
    }else if (tag.integerValue == 5){
        
        codestr = @"非常好";
    }
    
    
    [UILabel initWithDFLable:CGRectMake(190,self.backVC.frame.size.height - 30, 120, 25) :[UIFont systemFontOfSize:14*Width1] :COLOR2(53) :codestr :self.backVC :0];
    
    
    
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


- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth maxStr:(NSString *)maxStr
{
    // 获取文字样式
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    
    // 根据文字样式计算文字所占大小
    // 文本最大宽度
    CGSize maxSize = CGSizeMake(Width - 70, 60);
    
    // NSStringDrawingUsesLineFragmentOrigin -> 从头开始
    
    
    
    return [maxStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
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
