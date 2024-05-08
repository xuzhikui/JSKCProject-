//
//  AddCarController.h
//  JSKCProject
//
//  Created by XHJ on 2020/10/27.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^AddCarBlock)(NSDictionary *code);
@interface AddCarController : UIViewController
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)NSDictionary *codedic;
@property(nonatomic,strong)NSString *addType;
@property(nonatomic,strong)AddCarBlock block;
@end

NS_ASSUME_NONNULL_END
