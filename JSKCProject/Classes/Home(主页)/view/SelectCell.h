//
//  SelectCell.h
//  JSKCProject
//
//  Created by XHJ on 2020/9/18.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectCell : UITableViewCell
@property(nonatomic,strong)UILabel *titles;
@property(nonatomic,strong)UIImageView *imgs;
@property(nonatomic,strong)NSString *titStr;
@property(nonatomic,strong)NSString *seleSt;
@property(nonatomic,strong)UIView *fg;
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSMutableArray *seleArray;
@end

NS_ASSUME_NONNULL_END
