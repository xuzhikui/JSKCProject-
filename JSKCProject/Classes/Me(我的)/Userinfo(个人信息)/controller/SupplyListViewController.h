//
//  SupplyListViewController.h
//  JSKCProject
//
//  Created by 王宾 on 2022/3/31.
//  Copyright © 2022 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define SupplyListTableViewCell_Height 48.0f

@interface SupplyListTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) id info;

@end

@interface SupplyListViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
