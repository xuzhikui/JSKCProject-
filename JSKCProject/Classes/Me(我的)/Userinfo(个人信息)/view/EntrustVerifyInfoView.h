//
//  EntrustVerifyInfoView.h
//  JSKCProject
//
//  Created by 王宾 on 2022/4/2.
//  Copyright © 2022 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EntrustVerifyInfoView : UIView
@property (nonatomic, assign) NSInteger truckerId;
@property (nonatomic, copy) void (^confirmBlock)(void);
@end

NS_ASSUME_NONNULL_END
