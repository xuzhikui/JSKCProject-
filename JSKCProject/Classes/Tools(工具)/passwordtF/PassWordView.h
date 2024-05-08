//
//  PassWordView.h
//  YbtPrject
//
//  Created by aaa on 2018/6/28.
//  Copyright © 2018年 mdfs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPasswordView.h"
typedef void(^PassBlock) (NSString *pass);

@interface PassWordView : UIView
@property (nonatomic, strong) SYPasswordView *pasView;
@property (nonatomic, strong)PassBlock block;

@end
