//
//  DreCarAddVC.h
//  JSKCProject
//
//  Created by XHJ on 2020/10/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^drecarAddBlock)(NSDictionary *dic);
@interface DreCarAddVC : UIView
@property(nonatomic,strong)UIView *backVC;
@property(nonatomic,strong)NSString *plateNumber;
@property(nonatomic,strong)NSString *plateType;
@property(nonatomic,strong)NSString *driverType;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)drecarAddBlock block;


@end

NS_ASSUME_NONNULL_END
