//
//  WayRecordCell.h
//  JSKCProject
//
//  Created by XHJ on 2020/10/26.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WayRecordCell : UITableViewCell
    
@property(nonatomic,strong)UILabel *statsLab;
@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *userEndinfoLab;
@property(nonatomic,strong)UILabel *zlLab;
@property(nonatomic,strong)UILabel *pzLab;
@property(nonatomic,strong)UILabel *userLab;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)UILabel *one1;
@property(nonatomic,strong)UILabel *one2;
@property(nonatomic,strong)UILabel *one3;
@property(nonatomic,strong)UILabel *one4;
@property(nonatomic,strong)UIImageView *imgs;
@end

NS_ASSUME_NONNULL_END
