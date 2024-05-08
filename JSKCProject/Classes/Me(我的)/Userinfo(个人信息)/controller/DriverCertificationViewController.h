//
//  DriverCertificationViewController.h
//  JSKCProject
//
//  Created by 王宾 on 2022/3/28.
//  Copyright © 2022 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DriverCertificationViewController : UIViewController

@property(nonatomic,strong)UITableView *table;
@property(nonatomic,weak) UIViewController *viewController;
@property(nonatomic,strong)UIImage *frontDriverImage;
@property(nonatomic,strong)UIImage *backDriverMainImage;
@property(nonatomic,strong)UIImage *backDriverImage;
@property(nonatomic,strong)UIImage *frontQualificationImage;
@property(nonatomic,strong)UIImage *backQualificationImage;
@property(nonatomic,copy) void (^reloadBlock)(void);
@property (nonatomic, weak) NSString *cyrVerify;
@property (nonatomic, weak) id info;

@end

NS_ASSUME_NONNULL_END
