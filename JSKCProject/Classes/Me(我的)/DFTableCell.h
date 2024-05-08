//
//  DFTableCell.h
//  JSKCProject
//
//  Created by XHJ on 2020/9/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFTableCell : UITableViewCell
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)UILabel *lab;
@property(nonatomic,strong)UIButton *but;
@property(nonatomic,strong)UITextField *textTF;
@property(nonatomic,strong)UIButton *oneClideBut;
@property(nonatomic,strong)UIButton *twoClideBut;
@property(nonatomic,strong)NSString *str;
@end

NS_ASSUME_NONNULL_END
