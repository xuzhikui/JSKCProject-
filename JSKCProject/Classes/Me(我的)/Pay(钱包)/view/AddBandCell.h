//
//  AddBandCell.h
//  JSKCProject
//
//  Created by 孟德峰 on 2020/12/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddBandCell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UITextField *textTF;
@property(nonatomic,strong)NSString *tit;
@property(nonatomic,strong)NSString *data;
@end

NS_ASSUME_NONNULL_END
