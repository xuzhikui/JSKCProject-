//
//  ResultViewController.h
//  faceDemo
//
//  Created by golang on 2022/4/6.
//  Copyright © 2022 hisign. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResultViewController : UIViewController

@property(nonatomic, assign)int errorCode;
@property(nonatomic, copy)NSString *errorMessage;
@property(nonatomic, copy)NSString *signImage;

@end

NS_ASSUME_NONNULL_END
