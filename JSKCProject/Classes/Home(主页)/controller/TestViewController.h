//
//  TestViewController.h
//  JSKCProject
//
//  Created by XHJ on 2020/12/7.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface TestViewController : UIViewController
@property (nonatomic, strong) AMapLocationManager *locationManager;
@end

NS_ASSUME_NONNULL_END
