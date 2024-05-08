//
//  AlertView.h
//  Yidian
//
//  Created by 王宾 on 2020/7/20.
//  Copyright © 2020 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^Handler)(NSInteger actionIndex);

@interface AlertView : UIView

@property (nonatomic, strong) id params;

//cancelButtonTitle default @"取消"；otherButtonTitle default @"确定"
- (instancetype)initWithTitle:(NSString * __nullable)title
                      message:(NSString * __nullable)message
            cancelButtonTitle:(NSString * __nullable)cancelButtonTitle
             otherButtonTitle:(NSString * __nullable)otherButtonTitle
                      handler:(Handler __nullable)handler;

+ (instancetype)alertWithTitle:(NSString * __nullable)title
                       message:(NSString * __nullable)message
             cancelButtonTitle:(NSString * __nullable)cancelButtonTitle
              otherButtonTitle:(NSString * __nullable)otherButtonTitle
                       handler:(Handler __nullable)handler;

- (void)show;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
