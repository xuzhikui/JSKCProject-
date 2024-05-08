//
//  JurisdCell.m
//  JSKCProject
//
//  Created by XHJ on 2020/11/2.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "JurisdCell.h"

@implementation JurisdCell



- (void)setFrame:(CGRect)frame{
    frame.origin.x += 0;
    frame.origin.y += 0;
    frame.size.height -= 10;
    frame.size.width -= 0;
    [super setFrame:frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
      
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        
        
        self.tipLab = [UILabel new];
        [self.contentView addSubview:self.tipLab];
        
        self.titleLab = [UILabel new];
        [self.contentView addSubview:self.titleLab];
        
      
        self.img = [UIImageView new];
        [self.contentView addSubview:self.img];
        
    }
    
    return self;
    
}


-(void)layoutSubviews{
    
    
    self.img.frame = CGRectMake(5, 15,50 , 50);
//    self.img.backgroundColor = [UIColor redColor];
    self.img.image = [UIImage imageNamed:self.dic[@"img"]];

    self.titleLab.frame = CGRectMake(65, 15, self.frame.size.width - 85, 20);
    self.titleLab.text = self.dic[@"tit"];
    self.titleLab.font = [UIFont systemFontOfSize:18*Width1];
    
    
    self.tipLab.frame = CGRectMake(65, 40,self.frame.size.width - 95 , 30);
    self.tipLab.font = [UIFont systemFontOfSize:11*Width1];
    self.tipLab.textColor = COLOR2(102);
    self.tipLab.text = self.dic[@"det"];
    self.tipLab.numberOfLines = 2;
    
    
    
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
