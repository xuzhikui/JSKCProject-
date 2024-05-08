//
//  InfoController.h
//  JSKCProject
//
//  Created by XHJ on 2020/10/29.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoController : UIViewController

@property(nonatomic,strong)UITableView *table;
@property(nonatomic,weak) UIViewController *viewController;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIImage *img1;
@property(nonatomic,strong)UIImage *img2;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,copy) void (^submitIdCardInfoBlock)(id info);
@property(nonatomic,copy) void (^submitSourceInfoBlock)(id info);
@property (nonatomic, weak) NSString *cyrVerify;
@property (nonatomic, strong) id info;

- (void)submitIdCardInfo;

@end

NS_ASSUME_NONNULL_END
