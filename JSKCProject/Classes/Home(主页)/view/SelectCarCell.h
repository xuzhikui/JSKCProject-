//
//  SelectCarCell.h
//  JSKCProject
//
//  Created by XHJ on 2020/9/22.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectCarCellBlock)(NSDictionary *dic);
@interface SelectCarCell : UITableViewCell
@property(nonatomic,strong)UILabel *carLab;
@property(nonatomic,strong)UILabel *zlLab;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UIButton *selectBut;
@property(nonatomic,strong)UIView *fg1;
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)SelectCarCellBlock block;
@property(nonatomic,strong)SelectCarCellBlock bdblock;
@property(nonatomic,strong)NSDictionary *dic;
@end

NS_ASSUME_NONNULL_END
