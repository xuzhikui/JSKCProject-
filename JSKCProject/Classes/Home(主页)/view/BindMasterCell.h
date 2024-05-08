//
//  BindMasterCell.h
//  JSKCProject
//
//  Created by XHJ on 2020/9/22.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^BindCellBlock)(NSDictionary *dic);
@interface BindMasterCell : UITableViewCell
@property(nonatomic,strong)UILabel *phoneLab;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UIButton *selectBut;
@property(nonatomic,strong)UIView *fg1;
@property(nonatomic,strong)BindCellBlock block;
@property(nonatomic,strong)NSDictionary *dic;
@end

NS_ASSUME_NONNULL_END
