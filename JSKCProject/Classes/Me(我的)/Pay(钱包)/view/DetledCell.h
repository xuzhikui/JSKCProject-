//
//  DetledCell.h
//  JSKCProject
//
//  Created by 孟德峰 on 2020/12/29.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetledCell : UITableViewCell
@property(nonatomic,strong)UILabel *wayLab;
@property(nonatomic,strong)UILabel *cpLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *priceLab;
@property(nonatomic,strong)NSDictionary *dic;
@end

NS_ASSUME_NONNULL_END
