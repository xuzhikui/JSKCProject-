//
//  SourceCell.m
//  JSKCProject
//
//  Created by XHJ on 2020/9/21.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "SourceCell.h"

@implementation SourceCell

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 0;
    frame.size.height -= 0;
    frame.size.width -= 20;
    [super setFrame:frame];
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
      self.backVC = [UIView new];
             [self.contentView addSubview:self.backVC];
        self.titleLab = [UILabel new];
        [self.contentView addSubview:self.titleLab];
        
        self.costLab = [UILabel new];
        [self.contentView addSubview:self.costLab];
        
       
    }
    
    
    return self;
}

-(void)layoutSubviews{
    
    

    
    self.titleLab.frame = CGRectMake(0, 10, self.frame.size.width - 20,20);
    self.titleLab.backgroundColor = [UIColor whiteColor];
    self.titleLab.font = [UIFont systemFontOfSize:14*Width1];
//    self.titleLab.text = @"装货时间: 2020-09-11 12:30";
    self.titleLab.text = [NSString stringWithFormat:@"%@:  %@",self.dic[@"tit"],self.dic[@"value"]];
    
    
    
    
    
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
