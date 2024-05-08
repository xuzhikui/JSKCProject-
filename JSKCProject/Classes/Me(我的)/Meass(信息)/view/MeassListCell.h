//
//  MeassListCell.h
//  JSKCProject
//
//  Created by 孟德峰 on 2021/2/3.
//  Copyright © 2021 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MeassListCell : UITableViewCell
@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,strong)UILabel *titLab;
@property(nonatomic,strong)UILabel *costLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)UIImageView *tipImg;
@end

NS_ASSUME_NONNULL_END
