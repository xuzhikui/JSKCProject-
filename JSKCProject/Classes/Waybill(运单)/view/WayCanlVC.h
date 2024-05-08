//
//  WayCanlVC.h
//  JSKCProject
//
//  Created by XHJ on 2020/10/22.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^WayCanlVCBlock)(NSString *code);
@interface WayCanlVC : UIView
@property(nonatomic,strong)UIView *backVC;
@property(nonatomic,strong)UIView *viewVC;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)WayCanlVCBlock bolock;
@property(nonatomic,strong)NSString *code;
@end

NS_ASSUME_NONNULL_END
