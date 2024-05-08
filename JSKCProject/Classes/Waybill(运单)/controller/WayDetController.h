//
//  WayDetController.h
//  JSKCProject
//
//  Created by XHJ on 2020/10/23.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^WayDetBlock)(NSDictionary *dic, BOOL isCancel);
@interface WayDetController : UIViewController
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)WayDetBlock block;
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,strong)WayDetBlock delectblock;
@property(nonatomic,strong)NSString *types;
    @end

NS_ASSUME_NONNULL_END
