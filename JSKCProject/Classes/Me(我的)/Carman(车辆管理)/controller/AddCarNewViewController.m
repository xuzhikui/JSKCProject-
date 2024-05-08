//
//  AddCarNewViewController.m
//  JSKCProject
//
//  Created by 王宾 on 2022/3/30.
//  Copyright © 2022 孟德峰. All rights reserved.
//

#import "AddCarNewViewController.h"
#import "CarNumView.h"
#import "DreCarAddVC.h"
#import "CardInfoVC.h"
#import "InfoSubmitSuccessViewController.h"

@interface AddCarNewViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>{
    
    UIButton *frontDrivingLicenseButton;
    UIButton *backDriverLicenseMainButton;
    UIButton *backDriverLicenseButton;
    UIButton *frontTransportButton;
    UIButton *backTransportButton;
    UIButton *peopleVehiclesButton;
}

@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *bindButtton;
@property (nonatomic, strong) UIButton *reBindButtton;
@property (nonatomic, strong) UIButton *authButtton;
@property (nonatomic, strong) UIButton *mainButton;
@property (nonatomic, strong) UIButton *viceButton;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UIView *tableViewHeadView;
@property (nonatomic, assign) NSInteger roleType;

@property(nonatomic,strong)UIImage *frontDrivingLicenseImage;
@property(nonatomic,strong)UIImage *backDriverLicenseMainImage;
@property(nonatomic,strong)UIImage *backDriverLicenseImage;
@property(nonatomic,strong)UIImage *frontTransportImage;
@property(nonatomic,strong)UIImage *backTransportImage;
@property(nonatomic,strong)UIImage *peopleVehiclesImage;
@property(nonatomic,strong)UITextField *licensePlateTextField;

@property(nonatomic,strong)NSDictionary *carNumDic;
@property(nonatomic,strong)NSArray *dataArray;  //车牌数据
@property(nonatomic,strong)NSString *code;

@end

@implementation AddCarNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setConstraints];
    if (self.truckId != 0) {
        [self getCarInfo];
    }
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)setUI{
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"绑定车辆";
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.statusLabel];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.contentTableView];
    [self.headView addSubview:self.mainButton];
    [self.headView addSubview:self.viceButton];
    [self.headView addSubview:self.lineView];
    [self.bottomView addSubview:self.bindButtton];
    
}

- (void)setConstraints{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0.0f);
        make.top.mas_equalTo(NavaBarHeight);
    }];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(NavaBarHeight);
        make.height.mas_equalTo(30.0f);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.height.mas_equalTo(0.0f);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0.0f);
        make.bottom.mas_equalTo(0.0f);
        make.height.mas_equalTo(60+UISafeAreaBottomHeight);
    }];

    [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.statusLabel.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.bottomView.mas_top).offset(-10);
    }];
    CGFloat space = (Width - 245)*0.5f;
    [self.mainButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(space);
        make.centerY.mas_equalTo(self.headView.mas_centerY);
    }];
    [self.viceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self.mainButton);
        make.right.mas_equalTo(-space);
        make.centerY.mas_equalTo(self.headView.mas_centerY);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(0.0f);
        make.centerX.mas_equalTo(self.mainButton.mas_centerX);
    }];
    [self.bindButtton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(10);
    }];
    if (self.truckId == 0) {
        self.mainButton.userInteractionEnabled = YES;
        self.viceButton.userInteractionEnabled = YES;
    }else{
        self.mainButton.userInteractionEnabled = NO;
        self.viceButton.userInteractionEnabled = NO;
    }
}

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = COLOR2(245);
    }
    return _bgView;
}

- (UIView *)headView{
    if (_headView == nil) {
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = UIColor.whiteColor;
    }
    return _headView;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = COLOR(255, 78, 70);
    }
    return _lineView;
}

- (UIButton *)mainButton{
    if (_mainButton == nil) {
        _mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mainButton setTitle:@"我是主驾" forState:UIControlStateNormal];
        [_mainButton setTitleColor:COLOR2(153) forState:UIControlStateNormal];
        [_mainButton setTitleColor:COLOR(255, 78, 70) forState:UIControlStateSelected];
        [_mainButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_mainButton addTarget:self action:@selector(mainFuction) forControlEvents:UIControlEventTouchUpInside];
        _mainButton.selected = YES;
    }
    return _mainButton;
}

- (UIButton *)viceButton{
    if (_viceButton == nil) {
        _viceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_viceButton setTitle:@"我是副驾" forState:UIControlStateNormal];
        [_viceButton setTitleColor:COLOR2(153) forState:UIControlStateNormal];
        [_viceButton setTitleColor:COLOR(255, 78, 70) forState:UIControlStateSelected];
        [_viceButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_viceButton addTarget:self action:@selector(viceFuction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _viceButton;
}

- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = UIColor.whiteColor;
    }
    return _bottomView;
}

- (UIButton *)bindButtton{
    if (_bindButtton == nil) {
        _bindButtton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bindButtton.layer.cornerRadius = 4;
        _bindButtton.layer.masksToBounds = YES;
        _bindButtton.layer.borderColor = COLOR(245, 12, 12).CGColor;
        _bindButtton.layer.borderWidth = 1;
        [_bindButtton setTitle:@"立即绑定" forState:UIControlStateNormal];
        [_bindButtton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _bindButtton.backgroundColor = COLOR(245, 12, 12);
        [_bindButtton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_bindButtton addTarget:self action:@selector(bindFunction) forControlEvents:UIControlEventTouchUpInside];
        _bindButtton.userInteractionEnabled = self.truckId == 0;
    }
    return _bindButtton;
}

- (UIButton *)reBindButtton{
    if (_reBindButtton == nil) {
        _reBindButtton = [UIButton buttonWithType:UIButtonTypeCustom];
        _reBindButtton.layer.cornerRadius = 4;
        _reBindButtton.layer.masksToBounds = YES;
        _reBindButtton.layer.borderColor = COLOR(245, 12, 12).CGColor;
        _reBindButtton.layer.borderWidth = 1;
        [_reBindButtton setTitle:@"重新认证" forState:UIControlStateNormal];
        [_reBindButtton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _reBindButtton.backgroundColor = COLOR(245, 12, 12);
        [_reBindButtton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_reBindButtton addTarget:self action:@selector(reBindFunction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reBindButtton;
}

- (UITableView *)contentTableView{
    if (_contentTableView == nil) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.backgroundColor = UIColor.clearColor;
        _contentTableView.tableHeaderView = self.tableViewHeadView;
        _contentTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0)];
        _contentTableView.layer.cornerRadius = 4;
        _contentTableView.layer.masksToBounds = YES;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.showsVerticalScrollIndicator = NO;
    }
    return _contentTableView;
}

- (UIView *)tableViewHeadView{
    if (_tableViewHeadView == nil) {
        _tableViewHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 50)];
        _tableViewHeadView.backgroundColor = UIColor.whiteColor;
        _tableViewHeadView.layer.masksToBounds = YES;
        _tableViewHeadView.layer.cornerRadius = 4;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, Width, 5.0f)];
        lineView.backgroundColor = COLOR2(241);
        [_tableViewHeadView addSubview:lineView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"车辆牌照";
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = COLOR2(51);
        [_tableViewHeadView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.tableViewHeadView.mas_centerY).offset(-2.5);
        }];
        
        [_tableViewHeadView addSubview:self.licensePlateTextField];
        [self.licensePlateTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10.0f);
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(titleLabel.mas_centerY);
            make.width.mas_equalTo(150.0f);
        }];
    }
    return _tableViewHeadView;
}

- (UITextField *)licensePlateTextField{
    if (_licensePlateTextField == nil) {
        _licensePlateTextField = [[UITextField alloc] init];
        _licensePlateTextField.placeholder = @"请输入车辆牌照";
        _licensePlateTextField.font = [UIFont systemFontOfSize:10];
        _licensePlateTextField.textColor = COLOR2(51);
        _licensePlateTextField.textAlignment = NSTextAlignmentRight;
        _licensePlateTextField.delegate = self;
        _licensePlateTextField.tag = 2;
        _licensePlateTextField.returnKeyType = UIReturnKeyDone;
        _licensePlateTextField.userInteractionEnabled = self.truckId == 0;
    }
    return _licensePlateTextField;
}

- (UILabel *)statusLabel{
    if (_statusLabel == nil) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.font = [UIFont systemFontOfSize:10];
    }
    return _statusLabel;
}

- (void)setRoleType:(NSInteger)roleType{
    _roleType = roleType;
    if (_roleType == 0) {
        self.viceButton.selected = NO;
        self.mainButton.selected = YES;
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(32);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(0.0f);
            make.centerX.mas_equalTo(self.mainButton.mas_centerX);
        }];
    }else{
        self.viceButton.selected = YES;
        self.mainButton.selected = NO;
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(32);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(0.0f);
            make.centerX.mas_equalTo(self.viceButton.mas_centerX);
        }];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.truckId == 0) {
        return 3;
    }else{
        if (((self.dic[@"idrtFront"] && [self.dic[@"idrtFront"] length] != 0) || (self.dic[@"idrtBack"] && [self.dic[@"idrtBack"] length] != 0)) && (self.dic[@"mancarPic"] && [self.dic[@"mancarPic"] length] != 0)) {
            return 3;
        }else
            return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return CGFLOAT_MIN;
    }else
        return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section != 2) {
        UIView *vc = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 10)];
        vc.backgroundColor = COLOR2(245);
        return vc;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = UIColor.whiteColor;
    if (indexPath.section == 0) {
        
        [UILabel initWithDFLable:CGRectMake(10, 17, 75, 13) :[UIFont systemFontOfSize:13] :COLOR2(51) :@"行驶证信息" :cell.contentView :0];
        [UILabel initWithDFLable:CGRectMake(85, 20, 150, 10) :[UIFont systemFontOfSize:10] :COLOR2(153) :@"上传清晰的证件照认证较快哦！" :cell.contentView :0];
        
        frontDrivingLicenseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        frontDrivingLicenseButton.frame = CGRectMake(15.0f,50, 145,90.0f);
        [frontDrivingLicenseButton addTarget:self action:@selector(selectedImageFunction:) forControlEvents:(UIControlEventTouchUpInside)];
        frontDrivingLicenseButton.contentMode = UIViewContentModeScaleAspectFill;
        frontDrivingLicenseButton.layer.masksToBounds = YES;
        frontDrivingLicenseButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        frontDrivingLicenseButton.imageView.layer.masksToBounds = YES;
        frontDrivingLicenseButton.tag = 1;
        if (self.truckId == 0) {
            frontDrivingLicenseButton.userInteractionEnabled = YES;
            [frontDrivingLicenseButton setImage:self.frontDrivingLicenseImage == nil ? [UIImage imageNamed:@"行驶证正"] : self.frontDrivingLicenseImage forState:UIControlStateNormal];
        }else{
            frontDrivingLicenseButton.userInteractionEnabled = NO;
            if (self.dic) {
                [frontDrivingLicenseButton sd_setImageWithURL:[NSURL URLWithString:self.dic[@"idTrvalFront"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"行驶证正"]];
            }else{
                [frontDrivingLicenseButton setImage:[UIImage imageNamed:@"行驶证正"] forState:UIControlStateNormal];
            }
        }
        [cell.contentView addSubview:frontDrivingLicenseButton];
        [UILabel initWithDFLable:CGRectMake((CGRectGetWidth(frontDrivingLicenseButton.frame) - 145)*0.5+frontDrivingLicenseButton.frame.origin.x, 150, 145, 15) :[UIFont systemFontOfSize:10] :COLOR2(68) :self.truckId == 0 ? @"点击拍摄/上传行驶证主页" : @"行驶证主页" :cell.contentView :1];

        if (self.truckId == 0) {
            UIButton *frontDrivingLicenseDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [frontDrivingLicenseDeleteButton setImage:[UIImage imageNamed:@"delete_small"] forState:UIControlStateNormal];
            frontDrivingLicenseDeleteButton.frame = CGRectMake(CGRectGetMaxX(frontDrivingLicenseButton.frame) - 10.0f, frontDrivingLicenseButton.frame.origin.y - 10.0f, 20, 20);
            frontDrivingLicenseDeleteButton.tag = 1;
            frontDrivingLicenseDeleteButton.hidden = self.frontDrivingLicenseImage == nil;
            [frontDrivingLicenseDeleteButton addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:frontDrivingLicenseDeleteButton];
        }
        
        
        backDriverLicenseMainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backDriverLicenseMainButton.frame = CGRectMake(Width - 180.0f,50.0f, 145,90);
        [backDriverLicenseMainButton addTarget:self action:@selector(selectedImageFunction:) forControlEvents:(UIControlEventTouchUpInside)];
        backDriverLicenseMainButton.contentMode = UIViewContentModeScaleAspectFill;
        backDriverLicenseMainButton.layer.masksToBounds = YES;
        backDriverLicenseMainButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        backDriverLicenseMainButton.imageView.layer.masksToBounds = YES;
        backDriverLicenseMainButton.tag = 2;
        if (self.truckId == 0) {
            backDriverLicenseMainButton.userInteractionEnabled = YES;
            [backDriverLicenseMainButton setImage:self.backDriverLicenseMainImage == nil ? [UIImage imageNamed:@"行驶证反"] : self.backDriverLicenseMainImage forState:UIControlStateNormal];
        }else{
            backDriverLicenseMainButton.userInteractionEnabled = NO;
            if (self.dic) {
                [backDriverLicenseMainButton sd_setImageWithURL:[NSURL URLWithString:self.dic[@"idTrvalBack"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"行驶证反"]];
            }else{
                [backDriverLicenseMainButton setImage:[UIImage imageNamed:@"行驶证反"] forState:UIControlStateNormal];
            }
        }
        [cell.contentView addSubview:backDriverLicenseMainButton];
        [UILabel initWithDFLable:CGRectMake((CGRectGetWidth(backDriverLicenseMainButton.frame) - 145)*0.5+backDriverLicenseMainButton.frame.origin.x, 150, 145, 15) :[UIFont systemFontOfSize:10] :COLOR2(68) :self.truckId == 0 ? @"点击拍摄/上传行驶证副页" : @"行驶证副页" :cell.contentView :1];

        if (self.truckId == 0) {
            UIButton *backDriverLicenseMainDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [backDriverLicenseMainDeleteButton setImage:[UIImage imageNamed:@"delete_small"] forState:UIControlStateNormal];
            backDriverLicenseMainDeleteButton.frame = CGRectMake(CGRectGetMaxX(backDriverLicenseMainButton.frame) - 10.0f, backDriverLicenseMainButton.frame.origin.y - 10.0f, 20, 20);
            backDriverLicenseMainDeleteButton.tag = 2;
            backDriverLicenseMainDeleteButton.hidden = self.backDriverLicenseMainImage == nil;
            [backDriverLicenseMainDeleteButton addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:backDriverLicenseMainDeleteButton];
        }
       
        if (self.truckId == 0 || (self.truckId != 0 && (self.dic[@"idTrvalBackBack"] && [self.dic[@"idTrvalBackBack"] length] != 0))) {
            backDriverLicenseButton = [UIButton buttonWithType:UIButtonTypeCustom];
            backDriverLicenseButton.frame = CGRectMake(15.0f,185.0f, 145,90);
            [backDriverLicenseButton addTarget:self action:@selector(selectedImageFunction:) forControlEvents:(UIControlEventTouchUpInside)];
            backDriverLicenseButton.contentMode = UIViewContentModeScaleAspectFill;
            backDriverLicenseButton.layer.masksToBounds = YES;
            backDriverLicenseButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
            backDriverLicenseButton.imageView.layer.masksToBounds = YES;
            backDriverLicenseButton.tag = 3;
            if (self.truckId == 0) {
                backDriverLicenseButton.userInteractionEnabled = YES;
                [backDriverLicenseButton setImage:self.backDriverLicenseImage == nil ? [UIImage imageNamed:@"行驶证反"] : self.backDriverLicenseImage forState:UIControlStateNormal];
            }else{
                backDriverLicenseButton.userInteractionEnabled = NO;
                if (self.dic) {
                    [backDriverLicenseButton sd_setImageWithURL:[NSURL URLWithString:self.dic[@"idTrvalBackBack"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"行驶证反"]];
                }else{
                    [backDriverLicenseButton setImage:[UIImage imageNamed:@"行驶证反"] forState:UIControlStateNormal];
                }
            }
            [cell.contentView addSubview:backDriverLicenseButton];
            [UILabel initWithDFLable:CGRectMake((CGRectGetWidth(backDriverLicenseButton.frame) - 145)*0.5+backDriverLicenseButton.frame.origin.x, 285.0f, 145, 15) :[UIFont systemFontOfSize:10] :COLOR2(68) :self.truckId == 0 ? @"点击拍摄/上传行驶证副页" : @"行驶证副页" :cell.contentView :1];
            if (self.truckId == 0) {
                UIButton *backDriverLicenseDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [backDriverLicenseDeleteButton setImage:[UIImage imageNamed:@"delete_small"] forState:UIControlStateNormal];
                backDriverLicenseDeleteButton.frame = CGRectMake(CGRectGetMaxX(backDriverLicenseButton.frame) - 10.0f, backDriverLicenseButton.frame.origin.y - 10.0f, 20, 20);
                backDriverLicenseDeleteButton.tag = 3;
                backDriverLicenseDeleteButton.hidden = self.backDriverLicenseImage == nil;
                [backDriverLicenseDeleteButton addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:backDriverLicenseDeleteButton];
            }
            
        }

    }else if (indexPath.section == 1){
        [UILabel initWithDFLable:CGRectMake(10, 17, 110, 13) :[UIFont systemFontOfSize:13] :COLOR2(51) :@"道路运输证信息" :cell.contentView :0];
        
        frontTransportButton = [UIButton buttonWithType:UIButtonTypeCustom];
        frontTransportButton.frame = CGRectMake(15.0f,50, 145,90.0f);
        [frontTransportButton addTarget:self action:@selector(selectedImageFunction:) forControlEvents:(UIControlEventTouchUpInside)];
        frontTransportButton.contentMode = UIViewContentModeScaleAspectFill;
        frontTransportButton.layer.masksToBounds = YES;
        frontTransportButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        frontTransportButton.imageView.layer.masksToBounds = YES;
        frontTransportButton.tag = 4;
        if (self.truckId == 0) {
            frontTransportButton.userInteractionEnabled = YES;
            [frontTransportButton setImage:self.frontTransportImage == nil ? [UIImage imageNamed:@"道路运输正"] : self.frontTransportImage forState:UIControlStateNormal];
        }else{
            frontTransportButton.userInteractionEnabled = NO;
            if (self.dic) {
                [frontTransportButton sd_setImageWithURL:[NSURL URLWithString:self.dic[@"idrtFront"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"道路运输正"]];
            }else{
                [frontTransportButton setImage:[UIImage imageNamed:@"道路运输正"] forState:UIControlStateNormal];
            }
        }
        [cell.contentView addSubview:frontTransportButton];
        [UILabel initWithDFLable:CGRectMake((CGRectGetWidth(frontTransportButton.frame) - 145)*0.5+frontTransportButton.frame.origin.x, 150, 145, 15) :[UIFont systemFontOfSize:10] :COLOR2(68) :self.truckId == 0 ? @"点击拍摄/上传道路运输证正面" : @"道路运输证正面" :cell.contentView :1];
            
        if (self.truckId == 0) {
            UIButton *frontTransportDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [frontTransportDeleteButton setImage:[UIImage imageNamed:@"delete_small"] forState:UIControlStateNormal];
            frontTransportDeleteButton.frame = CGRectMake(CGRectGetMaxX(frontTransportButton.frame) - 10.0f, frontTransportButton.frame.origin.y - 10.0f, 20, 20);
            frontTransportDeleteButton.tag = 4;
            frontTransportDeleteButton.hidden = self.frontTransportImage == nil;
            [frontTransportDeleteButton addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:frontTransportDeleteButton];
        }
        
        if (self.truckId == 0 || (self.dic[@"idrtBack"] && [self.dic[@"idrtBack"] length] != 0)) {
            backTransportButton = [UIButton buttonWithType:UIButtonTypeCustom];
            backTransportButton.frame = CGRectMake(Width - 180.0f,50.0f, 145,90);
            [backTransportButton addTarget:self action:@selector(selectedImageFunction:) forControlEvents:(UIControlEventTouchUpInside)];
            backTransportButton.contentMode = UIViewContentModeScaleAspectFill;
            backTransportButton.layer.masksToBounds = YES;
            backTransportButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
            backTransportButton.imageView.layer.masksToBounds = YES;
            backTransportButton.tag = 5;
            if (self.truckId == 0) {
                backTransportButton.userInteractionEnabled = YES;
                [backTransportButton setImage:self.backTransportImage == nil ? [UIImage imageNamed:@"道路运输反"] : self.backTransportImage forState:UIControlStateNormal];
            }else{
                backTransportButton.userInteractionEnabled = NO;
                if (self.dic) {
                    [backTransportButton sd_setImageWithURL:[NSURL URLWithString:self.dic[@"idrtBack"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"道路运输反"]];
                }else{
                    [backTransportButton setImage:[UIImage imageNamed:@"道路运输反"] forState:UIControlStateNormal];
                }
            }
            [cell.contentView addSubview:backTransportButton];
            [UILabel initWithDFLable:CGRectMake((CGRectGetWidth(backTransportButton.frame) - 145)*0.5+backTransportButton.frame.origin.x, 150, 145, 15) :[UIFont systemFontOfSize:10] :COLOR2(68) :self.truckId == 0 ? @"上传道路运输证副页（选填）" : @"道路运输证副页" :cell.contentView :1];
            if (self.truckId == 0) {
                UIButton *backTransportDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [backTransportDeleteButton setImage:[UIImage imageNamed:@"delete_small"] forState:UIControlStateNormal];
                backTransportDeleteButton.frame = CGRectMake(CGRectGetMaxX(backTransportButton.frame) - 10.0f, backTransportButton.frame.origin.y - 10.0f, 20, 20);
                backTransportDeleteButton.tag = 5;
                backTransportDeleteButton.hidden = self.backTransportImage == nil;
                [backTransportDeleteButton addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:backTransportDeleteButton];
            }
        }

      
    }else{
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        CGRect bounds = CGRectMake(0, 0, Width-20 , 185.0f);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(4, 4)];
        layer.frame = bounds;
        layer.path = maskPath.CGPath;
        cell.layer.mask = layer;
        
        [UILabel initWithDFLable:CGRectMake(10, 17, 110, 14) :[UIFont systemFontOfSize:14] :COLOR2(51) :@"人车合照(选填)" :cell.contentView :0];
        peopleVehiclesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        peopleVehiclesButton.frame = CGRectMake(15.0f,50, 145,90.0f);
        [peopleVehiclesButton addTarget:self action:@selector(selectedImageFunction:) forControlEvents:(UIControlEventTouchUpInside)];
        peopleVehiclesButton.contentMode = UIViewContentModeScaleAspectFill;
        peopleVehiclesButton.layer.masksToBounds = YES;
        peopleVehiclesButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        peopleVehiclesButton.imageView.layer.masksToBounds = YES;
        peopleVehiclesButton.tag = 6;
        if (self.truckId == 0) {
            peopleVehiclesButton.userInteractionEnabled = YES;
            [peopleVehiclesButton setImage:self.peopleVehiclesImage == nil ? [UIImage imageNamed:@"icon_defeat_image"] : self.peopleVehiclesImage forState:UIControlStateNormal];
        }else{
            peopleVehiclesButton.userInteractionEnabled = NO;
            if (self.dic) {
                [peopleVehiclesButton sd_setImageWithURL:[NSURL URLWithString:self.dic[@"mancarPic"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_defeat_image"]];
            }else{
                [peopleVehiclesButton setImage:[UIImage imageNamed:@"icon_defeat_image"] forState:UIControlStateNormal];
            }
        }
        [cell.contentView addSubview:peopleVehiclesButton];
        [UILabel initWithDFLable:CGRectMake((CGRectGetWidth(peopleVehiclesButton.frame) - 145)*0.5+peopleVehiclesButton.frame.origin.x, 150, 145, 15) :[UIFont systemFontOfSize:10] :COLOR2(68) :self.truckId == 0 ?@"点击拍摄/上传人车合照" : @"人车合照" :cell.contentView :1];
        if (self.truckId == 0) {
            UIButton *peopleVehiclesDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [peopleVehiclesDeleteButton setImage:[UIImage imageNamed:@"delete_small"] forState:UIControlStateNormal];
            peopleVehiclesDeleteButton.frame = CGRectMake(CGRectGetMaxX(peopleVehiclesButton.frame) - 10.0f, peopleVehiclesButton.frame.origin.y - 10.0f, 20, 20);
            peopleVehiclesDeleteButton.tag = 6;
            peopleVehiclesDeleteButton.hidden = self.peopleVehiclesImage == nil;
            [peopleVehiclesDeleteButton addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:peopleVehiclesDeleteButton];
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.truckId == 0) {
            return 320.0f;
        }else{
            if (self.truckId != 0 && (self.dic[@"idTrvalBackBack"] && [self.dic[@"idTrvalBackBack"] length] != 0)) {
                return 320.0f;
            }else
                return 185.0f;
        }
    }else{
        return 185.0f;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TFChangedValue:) name:@"carnum" object:nil];
   CarNumView *carVC = [[CarNumView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
   [self.view addSubview:carVC];
    return NO;
}

- (void)mainFuction{
    self.roleType = 0;
}

- (void)viceFuction{
    self.roleType = 1;
}

- (void)reBindFunction{
  
    NSInteger verifyStaus = [self.dic[@"verify"] integerValue];
    switch (verifyStaus) {
        case 0:
        case 1:
        {
            [self.bindButtton setTitle:@"立即绑定" forState:UIControlStateNormal];
            [self.bindButtton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            self.bindButtton.backgroundColor = COLOR(245, 12, 12);
        }
            break;
        case 2:
        {
            [self.reBindButtton removeFromSuperview];
            [self.bindButtton setTitle:@"立即绑定" forState:UIControlStateNormal];
            [self.bindButtton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            self.bindButtton.backgroundColor = COLOR(245, 12, 12);
            [self.bindButtton mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(20);
                make.right.mas_equalTo(-20);
                make.height.mas_equalTo(40);
                make.top.mas_equalTo(10);
            }];
        }
            break;
    }
    [self.statusLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.0f);
    }];
    self.truckId = 0;
    self.dic = nil;
    self.licensePlateTextField.userInteractionEnabled = YES;
    self.mainButton.userInteractionEnabled = YES;
    self.viceButton.userInteractionEnabled = YES;
    [self.contentTableView reloadData];
    
}

- (void)bindFunction{
    if (self.truckId == 0) {
        if (self.licensePlateTextField.text == nil || self.licensePlateTextField.text.length == 0) {
            return [self.view addSubview:[Toast makeText:@"请输入车牌照"]];
        }
        if (self.frontDrivingLicenseImage == nil) {
            return [self.view addSubview:[Toast makeText:@"请上传行驶证主页"]];
        }
        if (self.backDriverLicenseMainImage == nil) {
            return [self.view addSubview:[Toast makeText:@"请上传行驶证副页"]];
        }
        if (self.frontTransportImage == nil) {
            return [self.view addSubview:[Toast makeText:@"请上传道路运输证"]];
        }
         
           
        NSMutableArray *fileArray = [NSMutableArray array];
        NSMutableArray *imageArr = [NSMutableArray array];
        [fileArray addObject:@"idtravlFront"];
        [imageArr addObject:self.frontDrivingLicenseImage];
        [fileArray addObject:@"idtravlBack"];
        [imageArr addObject:self.backDriverLicenseMainImage];
        if (self.backDriverLicenseImage != nil) {
            [fileArray addObject:@"idtravlBackBack"];
            [imageArr addObject:self.backDriverLicenseImage];
        }
        [fileArray addObject:@"idrtFront"];
        [imageArr addObject:self.frontTransportImage];
        if (self.backTransportImage != nil) {
            [fileArray addObject:@"idrtBack"];
            [imageArr addObject:self.backTransportImage];
        }
        if (self.peopleVehiclesImage != nil) {
            [fileArray addObject:@"yearInspect"];
            [imageArr addObject:self.peopleVehiclesImage];
        }
    //
    //         NSDictionary *dic= @{
    //             @"length":self.loonDic[@"id"],
    //             @"plateNumber":self.carNumDic[@"num"],
    //              @"truckId":@"",
    //             @"type":self.typeDic[@"id"],
    //             @"plateType":self.carNumDic[@"color"],
    //
    //         };
    //
        

        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:self.carNumDic[@"num"] forKey:@"plateNumber"];
        [params setValue:self.carNumDic[@"color"] forKey:@"plateType"];
        [params setValue:@(self.roleType+1) forKey:@"driverType"];
WeakSelf
        [AFN_DF POST:@"/system/truck/addOrEdit" Parameters:params File:fileArray ImageArr:imageArr ContVC:self success:^(NSDictionary *responseObject) {
              
               
            if ([weakSelf.addType isEqualToString:@"1"]) {
                
                NSInteger info =  [responseObject[@"data"][@"state"]intValue];
                    if (info == 99) {
                        NSInteger truckId = [responseObject[@"data"][@"obj"][@"truckId"]integerValue];
                        UserModel.shareInstance.bandTruckId = @(truckId);
                        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                        id userInfo = [user objectForKey:@"user"];
                        if (userInfo && [userInfo count] > 0) {
                            NSMutableDictionary *userInfoParams = [NSMutableDictionary dictionaryWithDictionary:userInfo];
                            [userInfoParams setObject:@(truckId) forKey:@"bandTruckId"];
                            [user setObject:userInfoParams forKey:@"user"];
                            [user synchronize];
                        }
                        if (weakSelf.block) {
                            weakSelf.block(@{});
                        }
                        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                        
                        if (UserModel.shareInstance.hasBankCard == nil || [UserModel.shareInstance.hasBankCard integerValue] == 0) {
                            CardInfoVC *vc =  [[CardInfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                            vc.tag = 1;
                            [UIApplication.sharedApplication.keyWindow addSubview:vc];
                            return;
                        }else
                            [[AFN_DF topViewController].view addSubview:[Toast makeText:@"提交成功"]];
                    
                    }else if(info == 100){
                    
                        [weakSelf.view  addSubview:[Toast makeText:responseObject[@"data"][@"info"]]];
                    }else if(info == 101){
                    
                        ///直接添加弹窗
                    
                    DreCarAddVC *addVC = [[DreCarAddVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                    addVC.plateType = weakSelf.carNumDic[@"color"];
                    addVC.plateNumber = weakSelf.carNumDic[@"num"];
                    addVC.driverType = [NSString stringWithFormat:@"%ld",weakSelf.roleType+1];
                        addVC.dic = responseObject[@"data"];
                        StrongSelf
                        addVC.block = ^(NSDictionary * _Nonnull dic) {
                            if (strongSelf.block) {
                                strongSelf.block(dic);
                            }
                        };
                    [weakSelf.view addSubview:addVC];
                    
                }
                
             
            }else{
                
                NSInteger info =  [responseObject[@"data"][@"state"]intValue];
                    if (info == 99) {
                        NSInteger truckId = [responseObject[@"data"][@"obj"][@"truckId"]integerValue];
                        UserModel.shareInstance.bandTruckId = @(truckId);
                        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                        id userInfo = [user objectForKey:@"user"];
                        if (userInfo && [userInfo count] > 0) {
                            NSMutableDictionary *userInfoParams = [NSMutableDictionary dictionaryWithDictionary:userInfo];
                            [userInfoParams setObject:@(truckId) forKey:@"bandTruckId"];
                            [user setObject:userInfoParams forKey:@"user"];
                            [user synchronize];
                        }
                        
                        if ([weakSelf.navigationController.viewControllers.firstObject isEqual:InfoSubmitSuccessViewController.class]) {
                            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
                        }else
                            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                        
                        if (UserModel.shareInstance.hasBankCard == nil || [UserModel.shareInstance.hasBankCard integerValue] == 0) {
                            CardInfoVC *vc =  [[CardInfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                            vc.tag = 1;
                            [UIApplication.sharedApplication.keyWindow addSubview:vc];
                            return;
                        }else
                            [[AFN_DF topViewController].view addSubview:[Toast makeText:@"提交成功"]];
                    
                    }else if(info == 100){
                    
                        [weakSelf.view  addSubview:[Toast makeText:responseObject[@"data"][@"info"]]];
                    }else if(info == 101){
                    
                        ///直接添加弹窗
                    
                    DreCarAddVC *addVC = [[DreCarAddVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                    addVC.plateType = weakSelf.carNumDic[@"color"];
                    addVC.plateNumber = weakSelf.carNumDic[@"num"];
                    addVC.driverType = [NSString stringWithFormat:@"%ld",weakSelf.roleType+1];

                        addVC.dic = responseObject[@"data"];
                        StrongSelf
                        addVC.block = ^(NSDictionary * _Nonnull dic) {
                          
                            strongSelf.block(dic);
                            
                        };
                    [weakSelf.view addSubview:addVC];
                    
                }
     
            }
              
               
           } failure:^(NSError *error) {
               
           }];
    }else{
        [AFN_DF POST:@"/system/truck/unbind" Parameters:@{@"truckId":@(self.truckId)} success:^(NSDictionary *responseObject) {
            [[AFN_DF topViewController].navigationController popViewControllerAnimated:YES];
            [[AFN_DF topViewController].view addSubview:[Toast makeText:@"解绑成功"]];
        } failure:^(NSError *error) {
                
        }];
        
    }
}

- (void)selectedImageFunction:(UIButton *)sender{
    self.code = [NSString stringWithFormat:@"%ld",sender.tag];
    [self onTapGR];
}

#pragma make  avdelegate--
///选择相册
- (void)onTapGR{
    // 选择控制器
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    actionsheet.tag = 1000;
    [actionsheet showInView:[AFN_DF topViewController].view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) // 拍照
    {
        //先判断当前设备是否支持相机（模拟器不支持相机，如果强行打开程序会崩）
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            
            picker.allowsEditing = NO;//设置拍照后的图片可被编辑
            picker.sourceType = sourceType;
            //设置导航栏背景颜色
            
            //            picker.navigationBar.barTintColor =
            
            //设置右侧取消按钮的字体颜色
            
            picker.navigationBar.tintColor = [UIColor blackColor];
            [self presentViewController:picker animated:YES completion:nil];
        }else // 模拟器
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"当前设备不支持相机" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alert.tag = 1;
            [alert show];
        }
    }else if (buttonIndex == 1) // 相册
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        //指定打开相册
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = NO;//允许编辑（允许编辑才能选择图片）
        
        
        picker.navigationBar.tintColor = [UIColor  blackColor];
        [self presentViewController:picker animated:YES completion:nil];
    }
}
#pragma mark - 相册delegate
//协议中的方法，当用户选择某个图片时被调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
      [picker dismissViewControllerAnimated:YES completion:nil];
    ///可编辑为 UIImagePickerControllerEditedImage
    if (self.code) {
        switch ([self.code integerValue]) {
            case 1:
            {
                self.frontDrivingLicenseImage = image;
                [self getCardFrontInfo];
            }
                break;
            case 2:
            {
                self.backDriverLicenseMainImage = image;
            }
                break;
            case 3:
            {
                self.backDriverLicenseImage = image;
            }
                break;
            case 4:
            {
                self.frontTransportImage = image;
            }
                break;
            case 5:
            {
                self.backTransportImage = image;
            }
                break;
            case 6:
            {
                self.peopleVehiclesImage = image;
            }
                break;
        }
    }
    [self.contentTableView reloadData];
}

- (void)deleteImageAction:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            self.frontDrivingLicenseImage = nil;
        }
            break;
        case 2:
        {
            self.backDriverLicenseMainImage = nil;
        }
            break;
        case 3:
        {
            self.backDriverLicenseImage = nil;
        }
            break;
        case 4:
        {
            self.frontTransportImage = nil;
        }
            break;
        case 5:
        {
            self.backTransportImage = nil;
        }
            break;
        case 6:
        {
            self.peopleVehiclesImage = nil;
        }
            break;
    }
    [self.contentTableView reloadData];
}

- (void)getCardLicensePlateInfo{
    WeakSelf
    [AFN_DF POST:@"/system/truck/clickaddtruck" Parameters:nil success:^(NSDictionary *responseObject) {
        weakSelf.dataArray = responseObject[@"data"];
    } failure:^(NSError *error) {
    }];
}

- (void)getaddBeforeInfo{
    [AFN_DF POST:@"/system/truck/addBefore" Parameters:@{@"plateNumber":self.carNumDic[@"num"],@"plateType":self.carNumDic[@"color"]} success:^(NSDictionary *responseObject) {
        NSInteger info =  [responseObject[@"data"][@"state"]intValue];
               
               if (info == 99) {
                   
               }else if(info == 100){
                   
                       [self.view  addSubview:[Toast makeText:responseObject[@"data"][@"info"]]];
               }else if(info == 101){
                   
                       ///直接添加弹窗
                   
                   DreCarAddVC *addVC = [[DreCarAddVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                   addVC.plateType = self.carNumDic[@"color"];
                   addVC.plateNumber = self.carNumDic[@"num"];
                   addVC.driverType = [NSString stringWithFormat:@"%ld",self.roleType+1];
                   addVC.dic = responseObject[@"data"];
                   addVC.block = ^(NSDictionary * _Nonnull dic) {
                       self.block(dic);
                   };
                   [self.view addSubview:addVC];
               }
               
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)getCarInfo{
    WeakSelf
    [AFN_DF POST:@"/system/truck/getTruckByTruckId" Parameters:@{@"truckId":@(self.truckId)} success:^(NSDictionary *responseObject) {
        weakSelf.dic = responseObject[@"data"];
        StrongSelf
        dispatch_async(dispatch_get_main_queue(), ^{
            strongSelf.roleType = [strongSelf.dic[@"driverType"] integerValue] - 1;
            [strongSelf.contentTableView reloadData];
            strongSelf.licensePlateTextField.text = strongSelf.dic[@"plateNumber"];
            NSInteger verifyStaus = [strongSelf.dic[@"verify"] integerValue];
            strongSelf.bindButtton.userInteractionEnabled = YES;
            switch (verifyStaus) {
                case 0:
                case 2:
                {
                    [strongSelf.statusLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(30);
                    }];
                    if (verifyStaus == 0) {
                        strongSelf.statusLabel.text = @"审核中：车辆审核中，请耐心等待";
                        strongSelf.statusLabel.textColor = COLOR(204, 124, 19);
                        strongSelf.statusLabel.backgroundColor = COLOR(255, 236, 211);
                        [strongSelf.bindButtton setTitle:@"解绑车辆" forState:UIControlStateNormal];
                        [strongSelf.bindButtton setTitleColor:COLOR(245, 12, 12) forState:UIControlStateNormal];
                        strongSelf.bindButtton.backgroundColor = UIColor.clearColor;
                    }else{
                        strongSelf.statusLabel.text = [NSString stringWithFormat:@"审核失败：%@",(strongSelf.dic[@"failReason"] || [strongSelf.dic[@"failReason"] length] == 0) ? strongSelf.dic[@"failReason"] : @"请更新资料重新提交认证"];
                        strongSelf.statusLabel.textColor = COLOR(245, 12, 12);
                        strongSelf.statusLabel.backgroundColor = COLOR(255, 235, 235);
                        [strongSelf.bindButtton setTitle:@"解绑车辆" forState:UIControlStateNormal];
                        [strongSelf.bindButtton setTitleColor:COLOR(245, 12, 12) forState:UIControlStateNormal];
                        strongSelf.bindButtton.backgroundColor = UIColor.clearColor;
                        if (strongSelf.reBindButtton.superview == nil) {
                            [strongSelf.bottomView addSubview:strongSelf.reBindButtton];
                        }
                        [strongSelf.bindButtton mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(20);
                            make.top.mas_equalTo(10);
                            make.height.mas_equalTo(40);
                        }];
                        [strongSelf.reBindButtton mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.right.mas_equalTo(-20);
                            make.left.mas_equalTo(strongSelf.bindButtton.mas_right).offset(20);
                            make.top.mas_equalTo(strongSelf.bindButtton);
                            make.width.height.mas_equalTo(self.bindButtton);
                        }];
                    }
                }
                    break;
                case 1:
                {
                    [strongSelf.statusLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(0);
                    }];
                    [strongSelf.bindButtton setTitle:@"解绑车辆" forState:UIControlStateNormal];
                    [strongSelf.bindButtton setTitleColor:COLOR(245, 12, 12) forState:UIControlStateNormal];
                    strongSelf.bindButtton.backgroundColor = UIColor.clearColor;
                }
                    break;
            }
        });
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)getCardFrontInfo{
    WeakSelf
    [AFN_DF POST:@"/system/truck/ocr" Parameters:nil File:@[@"idtravlFront"] ImageArr:@[self.frontDrivingLicenseImage] ContVC:self success:^(NSDictionary *responseObject) {
        weakSelf.carNumDic = @{@"num":responseObject[@"data"][@"plateNumber"],@"color":responseObject[@"data"][@"plateType"]};
        weakSelf.licensePlateTextField.text = weakSelf.carNumDic[@"num"];

    } failure:^(NSError *error) {
        
    }];
}

- (void)TFChangedValue:(NSNotification*)notif{
//    NSLog(@"%@",notif.object);
    self.carNumDic = notif.object;
    self.licensePlateTextField.text = self.carNumDic[@"num"];
    [self getaddBeforeInfo];
}

- (void)dealloc{
    [NSNotificationCenter.defaultCenter removeObserver:self];
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
