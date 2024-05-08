//
//  CompLlistController.h
//  JSKCProject
//
//  Created by XHJ on 2020/10/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ComplistBlock)(NSDictionary *code);
@interface CompLlistController : UIViewController
@property(nonatomic,strong)ComplistBlock block;

@end

NS_ASSUME_NONNULL_END
