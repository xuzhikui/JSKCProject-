//
//  AddBandCell.m
//  JSKCProject
//
//  Created by 孟德峰 on 2020/12/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "AddBandCell.h"

@implementation AddBandCell

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
    
        self.textTF = [UITextField new];
        [self.contentView addSubview:self.textTF];
        
        
    }
        
    return self;
}

-(void)layoutSubviews{
    
    
    
    self.titleLab.frame =  CGRectMake(20, 0, 100, 40);
    self.titleLab.numberOfLines = 0;
    self.titleLab.text = self.tit;
    self.titleLab.textColor = [UIColor blackColor];
    self.titleLab.font = [UIFont systemFontOfSize:12*Width1];
  
  
    self.textTF.frame = CGRectMake(130, 0, 200, 40);
    self.textTF.font = [UIFont systemFontOfSize:12*Width1];
    self.textTF.textColor = COLOR2(153);
    self.textTF.delegate = self;
//    self.textTF.textAlignment = ;
//    self.textTF.placeholder = @"请输入姓名";
    
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

      [textField resignFirstResponder];

  return YES;
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
