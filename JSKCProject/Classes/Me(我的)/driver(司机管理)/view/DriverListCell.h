//
//  DriverListCell.h
//  JSKCProject
//
//  Created by XHJ on 2020/10/27.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DriverListCell : UITableViewCell
@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,strong)UILabel *userLab;
@property(nonatomic,strong)UILabel *numLab;
@property(nonatomic,strong)UILabel *startLab;
@property(nonatomic,strong)UIImageView *startImg;
@property(nonatomic,strong)NSDictionary *dic;
@end

NS_ASSUME_NONNULL_END
