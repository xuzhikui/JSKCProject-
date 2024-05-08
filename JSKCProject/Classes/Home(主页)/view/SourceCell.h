//
//  SourceCell.h
//  JSKCProject
//
//  Created by XHJ on 2020/9/21.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SourceCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *costLab;
@property(nonatomic,strong)UIView *backVC;
@property(nonatomic,strong)NSDictionary *dic;
@end

NS_ASSUME_NONNULL_END
