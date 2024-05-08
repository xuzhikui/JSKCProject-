//
//  NoticeCell.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "NoticeCell.h"

@implementation NoticeCell


- (void)setFrame:(CGRect)frame{
        frame.origin.x += 0;
        frame.origin.y += 0;
        frame.size.height -= 2;
        frame.size.width -= 0;
    [super setFrame:frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
       
        self.titleLab = [UILabel new];
        [self.contentView addSubview:self.titleLab];
    
        self.imgs = [UIImageView new];
        [self.contentView addSubview:self.imgs];
        
        
    }
        
    return self;
}

-(void)layoutSubviews{
    
    
    
    self.titleLab.frame =  CGRectMake(20, 0, Width - 60, 50);
    self.titleLab.numberOfLines = 0;
    self.titleLab.text = self.dic[@"title"];
    self.titleLab.textColor = [UIColor grayColor];
    self.titleLab.font = [UIFont systemFontOfSize:15*Width1];
  
    self.imgs.frame = CGRectMake(Width - 30, 17.5, 10, 15);
    self.imgs.image = [UIImage imageNamed:@"返 回 拷贝 2"];
    
    
    
    
    
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
