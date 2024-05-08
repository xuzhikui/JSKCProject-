//
//  AddDriverController.h
//  JSKCProject
//
//  Created by XHJ on 2020/10/27.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^AddDriBlock)(NSDictionary *code);
@interface AddDriverController : UIViewController
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)NSString *codes;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *addType;
@property(nonatomic,strong)AddDriBlock block;
@property(nonatomic,strong)AddDriBlock soublock;
@end

NS_ASSUME_NONNULL_END
