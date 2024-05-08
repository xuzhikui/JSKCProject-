//
//  InfoSubmitSuccessViewController.m
//  JSKCProject
//
//  Created by 王宾 on 2022/3/29.
//  Copyright © 2022 孟德峰. All rights reserved.
//

#import "InfoSubmitSuccessViewController.h"
#import "UIOffsetButton.h"
#import "AddCarNewViewController.h"
#import "AddBandCarController.h"
#import "CardInfoVC.h"

@interface InfoSubmitSuccessViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *bindVehicleButton;
@property (nonatomic, strong) UIButton *bindCardButton;

@end

@implementation InfoSubmitSuccessViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;

}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIOffsetButton *closeButton = [UIOffsetButton buttonWithType:UIButtonTypeCustom];
    closeButton.imageFrame = CGRectMake(5, 12.5, 15, 15);
    [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    closeButton.frame = CGRectMake(0, 0, 40, 40);
    [closeButton addTarget:self action:@selector(backFunction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
    negativeSpacer.width = -25;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,backButtonItem];
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.contentLabel];
    [self.view addSubview:self.bindVehicleButton];
    [self.view addSubview:self.bindCardButton];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(66+NavaBarHeight);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(35);
    }];
    CGFloat space = (Width - 260)*0.5f;
    [self.bindVehicleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(space);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(50);
        make.width.mas_equalTo(122.5);
        make.height.mas_equalTo(32);
    }];
    [self.bindCardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-space);
        make.centerY.mas_equalTo(self.bindVehicleButton.mas_centerY);
        make.width.height.mas_equalTo(self.bindVehicleButton);
    }];
    // Do any additional setup after loading the view.
}

- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"infoSubmitSuccess_icon"]];
    }
    return _imageView;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.text = @"提交成功，请等待审核！";
        _contentLabel.textColor = COLOR2(51);
    }
    return _contentLabel;
}

- (UIButton *)bindVehicleButton{
    if (_bindVehicleButton == nil) {
        _bindVehicleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bindVehicleButton setTitle:@"绑定车辆" forState:UIControlStateNormal];
        [_bindVehicleButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_bindVehicleButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        _bindVehicleButton.layer.cornerRadius = 4.0f;
        _bindVehicleButton.layer.masksToBounds = YES;
        _bindVehicleButton.backgroundColor = COLOR2(204);
        [_bindVehicleButton addTarget:self action:@selector(bindVehicleFunction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bindVehicleButton;
}

- (UIButton *)bindCardButton{
    if (_bindCardButton == nil) {
        _bindCardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bindCardButton setTitle:@"绑定银行卡" forState:UIControlStateNormal];
        [_bindCardButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_bindCardButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        _bindCardButton.layer.cornerRadius = 4.0f;
        _bindCardButton.layer.masksToBounds = YES;
        _bindCardButton.backgroundColor = COLOR(228, 23, 23);
        [_bindCardButton addTarget:self action:@selector(bindCardFunction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bindCardButton;
}

- (void)bindVehicleFunction{
    NSLog(@"绑定车辆");
    AddCarNewViewController *addCarNew = [AddCarNewViewController new];
    addCarNew.addType = @"1";
    [self.navigationController pushViewController:addCarNew animated:YES];
}

- (void)bindCardFunction{
    NSLog(@"绑定银行卡");
    AddBandCarController *addVC = [AddBandCarController new];
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)backFunction{
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
