//
//  PhoneLoginController.h
//  JSKCProject
//
//  Created by XHJ on 2020/9/15.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhoneLoginController : UIViewController
@property(nonatomic,strong)NSString *code;
@property (nonatomic, assign) BOOL logOut;
@property (nonatomic, assign) BOOL oneclickLoginInto;
@property (nonatomic, assign) BOOL showIdentityButton;

@end

NS_ASSUME_NONNULL_END
