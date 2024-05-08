//
//  DirectAddVC.h
//  JSKCProject
//
//  Created by XHJ on 2020/10/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DirectAddBlock)(NSDictionary *dic);
NS_ASSUME_NONNULL_BEGIN
@interface DirectAddVC : UIView
@property(nonatomic,strong)UIView *backVC;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)DirectAddBlock block;
@end

NS_ASSUME_NONNULL_END
