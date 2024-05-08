//
//  CanlWayView.h
//  JSKCProject
//
//  Created by XHJ on 2020/10/24.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CanlVCBlock)(NSDictionary *dic);
@interface CanlWayView : UIView
@property(nonatomic,strong)UIView *backVC;
@property(nonatomic,strong)UIView *viewVC;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)CanlVCBlock bolock;
@end

NS_ASSUME_NONNULL_END
