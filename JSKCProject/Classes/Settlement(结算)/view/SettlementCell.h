//
//  SettlementCell.h
//  JSKCProject
//
//  Created by XHJ on 2020/12/25.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettlementCell : UITableViewCell
@property(nonatomic,strong)UIImageView *timeImg;
@property(nonatomic,strong)UIImageView *endImg;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *startLab;
@property(nonatomic,strong)UILabel *overLab;
@property(nonatomic,strong)UILabel *distLab;///距离
@property(nonatomic,strong)UILabel *consumingLab;///时间
@property(nonatomic,strong)UILabel *startTime;
@property(nonatomic,strong)UILabel *overTime;
@property(nonatomic,strong)UIImageView *oneImg;
@property(nonatomic,strong)UIImageView *twoImg;
@property(nonatomic,strong)UIImageView *thereImg;
@property(nonatomic,strong)UIImageView *forImg;
@property(nonatomic,strong)UILabel *overareaLab;
@property(nonatomic,strong)UILabel *startareaLab;
@property(nonatomic,strong)UIImageView *jiantouImg;
@property(nonatomic,strong)UIImageView *fgImg;
@property(nonatomic,strong)UILabel *oneLab;
@property(nonatomic,strong)UILabel *twoLab;
@property(nonatomic,strong)UILabel *thereLab;
@property(nonatomic,strong)UILabel *priceLab;
@property(nonatomic,strong)UIButton *phoneBut;
@property(nonatomic,strong)UIButton *tsBut;
@property(nonatomic,strong)UIImageView *backVC;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *type;
@end

NS_ASSUME_NONNULL_END
