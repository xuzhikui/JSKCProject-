//
//  DFTableCell.m
//  JSKCProject
//
//  Created by XHJ on 2020/9/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "DFTableCell.h"

@implementation DFTableCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    
    self.but = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.contentView addSubview:self.but];
    
    self.lab = [UILabel new];
    [self.contentView addSubview:self.lab];
    
    self.textTF = [UITextField new];
    [self.contentView addSubview:self.textTF];
    
    
    self.oneClideBut = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.contentView addSubview:self.oneClideBut];
    
    
 self.twoClideBut = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.contentView addSubview:self.twoClideBut];
    
    
}


-(void)layoutSubviews{
    
    NSInteger tag = self.type.integerValue;
    
    switch (tag) {
        case 0:
        {
          ///文本
            
            self.lab.frame = CGRectMake(Width - 250, 10, 190, 30);
            self.lab.text = self.str;
            self.lab.font = [UIFont systemFontOfSize:15*Width1];
            self.lab.textAlignment = 2;
            
        }
            break;
            case 1:
        {
            ///单选
            self.but.frame = CGRectMake(Width - 250, 10, 190, 30);
            [self.but setTitleColor:[UIColor blackColor] forState:0];
            self.but.titleLabel.font = [UIFont systemFontOfSize:15*Width1];
            self.but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [self.but setTitle:self.str forState:0];
        }
            break;
            case 2:
        {
            self.textTF.frame = CGRectMake(Width - 250, 10, 190, 30);
            self.textTF.text = _str;
            self.textTF.font = [UIFont systemFontOfSize:15*Width1];
            self.textTF.textAlignment = 2;
            self.textTF.placeholder = self.str;
            
        }
            break;
            case 3:
        {
            
            
            
                    self.oneClideBut.frame = CGRectMake(Width - 200, 10, 90, 30);
                    [ self.oneClideBut setTitleColor:[UIColor blackColor] forState:0];
                     self.oneClideBut.titleLabel.font = [UIFont systemFontOfSize:15*Width1];
                    self.oneClideBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                    [ self.oneClideBut setTitle:self.str forState:0];
                [self.oneClideBut setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
                    [self.oneClideBut setImage:[UIImage imageNamed:@""] forState:(UIControlStateSelected)];
            
            
                    self.twoClideBut.frame = CGRectMake(Width - 100, 10, 90, 30);
                              [ self.twoClideBut setTitleColor:[UIColor blackColor] forState:0];
                               self.twoClideBut.titleLabel.font = [UIFont systemFontOfSize:15*Width1];
                              self.twoClideBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                              [ self.twoClideBut setTitle:self.str forState:0];
                          [self.twoClideBut setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
                          [self.twoClideBut setImage:[UIImage imageNamed:@""] forState:(UIControlStateSelected)];
            
        }
        
            
            break;

        default:
            break;
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
