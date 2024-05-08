//
//  CodeController.h
//  JSKCProject
//
//  Created by XHJ on 2020/9/15.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CodeController : UIViewController
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *sendCode;
@property(nonatomic,assign)BOOL identity;
@end

NS_ASSUME_NONNULL_END
