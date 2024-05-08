//
//  EntrustResultViewController.m
//  JSKCProject
//
//  Created by 王宾 on 2022/3/31.
//  Copyright © 2022 孟德峰. All rights reserved.
//

#import "EntrustResultViewController.h"
#import "EntrustListViewController.h"

@interface EntrustResultViewController ()

@end

@implementation EntrustResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"委托结果";
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"多边形 1 拷贝 2"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    UIImageView *successImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
    successImageView.contentMode = UIViewContentModeScaleAspectFill;
    successImageView.layer.masksToBounds = YES;
    [self.view addSubview:successImageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.textColor = UIColor.whiteColor;
    titleLabel.text = @"委托成功";
    [self.view addSubview:titleLabel];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = [UIFont systemFontOfSize:10];
    contentLabel.textColor = COLOR(254, 218, 218);
    contentLabel.text = @"您可以通过APP随时查看、新增或取消您的委托收款人。";
    [self.view addSubview:contentLabel];
    
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [finishButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [finishButton setBackgroundColor:COLOR(255, 160, 160)];
    finishButton.layer.cornerRadius = 12;
    finishButton.layer.borderWidth = 0.5f;
    finishButton.layer.borderColor = UIColor.whiteColor.CGColor;
    finishButton.layer.masksToBounds = YES;
    [finishButton addTarget:self action:@selector(backFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishButton];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0.0f);
        make.top.mas_equalTo(NavaBarHeight);
        make.height.mas_equalTo(190*(Width/375));
    }];
    [successImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView.mas_centerX);
        make.top.mas_equalTo(imageView.mas_top).offset(32*(Width/375));
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(successImageView.mas_centerX);
        make.top.mas_equalTo(successImageView.mas_bottom).offset(15.0f);
    }];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(successImageView.mas_centerX);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(18.0f);
    }];
    [finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(successImageView.mas_centerX);
        make.top.mas_equalTo(contentLabel.mas_bottom).offset(18.0f);
        make.width.mas_equalTo(80.0f);
        make.height.mas_equalTo(24.0f);
    }];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)backFunction{
    UIViewController *tempVC = nil;
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:EntrustListViewController.class]) {
            tempVC = vc;
            break;
        }
    }
    if (tempVC) {
        [self.navigationController popToViewController:tempVC animated:YES];
    }else
        [self.navigationController popToRootViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
