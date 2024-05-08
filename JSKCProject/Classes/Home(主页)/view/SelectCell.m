//
//  SelectCell.m
//  JSKCProject
//
//  Created by XHJ on 2020/9/18.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "SelectCell.h"

@implementation SelectCell


- (void)setFrame:(CGRect)frame{
    frame.origin.x += 0;
    frame.origin.y += 0;
    frame.size.height -= 0;
    frame.size.width -= 0;
    [super setFrame:frame];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titles = [UILabel new];
        [self.contentView addSubview:self.titles];
        
        self.imgs = [UIImageView new];
        [self.contentView addSubview:self.imgs];
        
        self.fg = [UIView new];
        [self.contentView addSubview:self.fg];
       
    }
    
    return self;
}

-(void)layoutSubviews{
    
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:14*Width1]};
         CGFloat width = [self.titStr boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
    self.titles.frame = CGRectMake(10, 15,width, 20);
    self.titles.font = [UIFont systemFontOfSize:14*Width1];
    self.titles.text = _titStr;
    
   self.imgs.frame = CGRectMake(width + 15,19 , 12, 12);
             self.imgs.image = [UIImage imageNamed:@"√-1"];
    self.imgs.hidden = YES;
        if ([self.seleSt isEqualToString:self.titStr]) {
            self.imgs.hidden = NO;
        self.titles.textColor = [UIColor redColor];
       self.titles.frame = CGRectMake(10, 15,width, 20);
          
        

    }else{
        
         self.titles.textColor = [UIColor grayColor];
            self.imgs.hidden = YES;
        
    }
    
    
    
    
    if ([self.code isEqualToString:@"1"]) {
         self.titles.frame = CGRectMake(20, 15,width, 20);
        self.fg.frame = CGRectMake(20, 49, self.frame.size.width - 40, 1);
        self.fg.backgroundColor = COLOR2(241);
        self.imgs.frame = CGRectMake(width + 25,19 , 12, 12);
        self.imgs.hidden = YES;
        
    }
  
    
    
    if (self.seleArray.count != 0) {
        BOOL isbool = [self.seleArray containsObject: self.titStr];
       
        if (isbool) {
            
                self.imgs.hidden = NO;
                 self.titles.textColor = [UIColor redColor];
              
            
        }
        
        
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
