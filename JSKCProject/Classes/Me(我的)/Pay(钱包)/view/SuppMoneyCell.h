//
//  SuppMoneyCell.h
//  JSKCProject
//
//  Created by 孟德峰 on 2020/12/29.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^suppVCBlock)(NSIndexPath *indexPath);
@interface SuppMoneyCell : UITableViewCell
@property(nonatomic,strong)UIButton *selectBut;
@property(nonatomic,strong)UILabel *wayLab;
@property(nonatomic,strong)UILabel *cpLab;
@property(nonatomic,strong)UILabel *priceLab;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)suppVCBlock addBlock;
@property(nonatomic,strong)suppVCBlock removeBlock;
@property(nonatomic,weak) NSIndexPath *indexPath;
@end

NS_ASSUME_NONNULL_END
