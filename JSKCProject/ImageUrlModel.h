//
//  ImageUrlModel.h
//  JSKCProject
//
//  Created by 孟德峰 on 2021/4/30.
//  Copyright © 2021 孟德峰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageUrlModel : NSObject
///初始化方法
+(instancetype) shareInstance;
//关于我们logo
@property(nonatomic,strong)NSString *aboutUsLogo;
//服务投诉电话
@property(nonatomic,strong)NSString *csPhone;
//闪屏页
@property(nonatomic,strong)NSString *cyrFlashpage;
//注销确认框提示
@property(nonatomic,strong)NSString *logoffConfirmTips;
//注销提示
@property(nonatomic,strong)NSString *logoffTips;
//一键登录页logo
@property(nonatomic,strong)NSString *yjdlLogo;
//验证码登录页logo
@property(nonatomic,strong)NSString *yzmdlLogo;
@end

NS_ASSUME_NONNULL_END
