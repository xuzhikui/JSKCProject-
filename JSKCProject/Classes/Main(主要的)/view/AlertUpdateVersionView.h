//
//  AlertUpdateVersionView.h
//  JSKCProject
//
//  Created by 王宾 on 2022/4/10.
//  Copyright © 2022 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertView.h"
NS_ASSUME_NONNULL_BEGIN

@interface AlertUpdateVersionView : UIView
- (instancetype)initWithVersion:(NSString * __nullable)version
                        message:(NSArray * __nullable)messages
                        handler:(Handler __nullable)handler;

+ (instancetype)alertWithVersion:(NSString * __nullable)version
                         message:(NSArray * __nullable)messages
                         handler:(Handler __nullable)handler;

- (void)show;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
