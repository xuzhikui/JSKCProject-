//
//  SetteCommContCell.h
//  JSKCProject
//
//  Created by 孟德峰 on 2020/12/27.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHRatingView.h"
NS_ASSUME_NONNULL_BEGIN

@interface SetteCommContCell : UITableViewCell
@property(nonatomic,strong)UIImageView *timeImg;
@property(nonatomic,strong)UIImageView *endImg;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *startLab;
@property(nonatomic,strong)UILabel *overLab;
@property(nonatomic,strong)UILabel *distLab;///距离
@property(nonatomic,strong)UILabel *consumingLab;///时间
@property(nonatomic,strong)UILabel *startTime;
@property(nonatomic,strong)UILabel *overTime;
@property(nonatomic,strong)UILabel *overareaLab;
@property(nonatomic,strong)UILabel *startareaLab;
@property(nonatomic,strong)UIImageView *jiantouImg;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)UIView *backVC;
@property(nonatomic,strong)UILabel *commLab;
@end

NS_ASSUME_NONNULL_END
