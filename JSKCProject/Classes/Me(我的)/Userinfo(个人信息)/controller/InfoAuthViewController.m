//
//  InfoAuthViewController.m
//  JSKCProject
//
//  Created by 王宾 on 2022/3/29.
//  Copyright © 2022 孟德峰. All rights reserved.
//

#import "InfoAuthViewController.h"
#import "InfoController.h"
#import "DriverCertificationViewController.h"
#import "InfoSubmitSuccessViewController.h"
#import "UIOffsetButton.h"
#import "AlertView.h"
#import <HSFaceDetector/LiveHeader.h>
#import <HSFaceDetector/LiveDetectController.h>
#import <HSFaceDetector/LiveCamera.h>
#import "ResultViewController.h"

@interface InfoAuthViewController ()<LiveDetectControllerDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIOffsetButton *idCardButton;
@property (nonatomic, strong) UIOffsetButton *driverButton;
@property (nonatomic, strong) UIOffsetButton *statusButton;
@property (nonatomic, strong) UIView *idCardLineView;
@property (nonatomic, strong) UIView *driverLineView;
@property (nonatomic, strong) InfoController *idCardViewController;
@property (nonatomic, strong) DriverCertificationViewController *driverViewController;
@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, assign) NSInteger progress;//defualt 0
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) id info;
@property (nonatomic, strong) NSDictionary *shenfendic;
@property (nonatomic, strong)NSString *imgsign;
@property (nonatomic, strong)NSString *lvcode;
@end

@implementation InfoAuthViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
    if ([self.cyrVerify integerValue] == 2) {
        [self.scrollView setContentOffset:CGPointMake(Width, 0) animated:YES];
        self.title = @"驾驶信息认证";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self viewWillLoadUI];
    [self viewWillLoadConstraints];
    
    if ([self.cyrVerify integerValue] != 0) {
        WeakSelf
        [AFN_DF POST:@"/system/auth/getDetail" Parameters:nil success:^(NSDictionary *responseObject) {
            //验证成功
            weakSelf.info = [responseObject objectForKey:@"data"];
            weakSelf.idCardViewController.info = weakSelf.info;
            weakSelf.driverViewController.info = weakSelf.info;
            self.shenfendic = weakSelf.info;
            self.lvcode = [NSString stringWithFormat:@"%@",self.shenfendic[@"livingBodyAuth"]];
        } failure:^(NSError *error) {

        }];
    }
}

- (void)viewWillLoadUI{
    self.title = @"身份信息认证";
    UIView *navBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, NavaBarHeight)];
    navBgView.backgroundColor = UIColor.whiteColor;
    [self.view insertSubview:navBgView atIndex:0];
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.headView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.scrollView];
    [self.bottomView addSubview:self.submitButton];
    [self.scrollView addSubview:self.containerView];
    [self.headView addSubview:self.idCardButton];
    [self.headView addSubview:self.driverButton];
    [self.headView addSubview:self.statusButton];
    [self.headView addSubview:self.idCardLineView];
    [self.headView addSubview:self.driverLineView];
    [self.containerView addSubview:self.idCardViewController.view];
    [self.containerView addSubview:self.driverViewController.view];
}

- (void)viewWillLoadConstraints{
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0.0f);
        make.top.mas_equalTo(NavaBarHeight);
        make.height.mas_equalTo(50.0f);
    }];
    [self.idCardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(38);
        make.height.mas_equalTo(40.0f);
        make.centerY.mas_equalTo(self.headView.mas_centerY);
        make.left.mas_equalTo(30.0f);
    }];
    [self.driverButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(48);
        make.height.mas_equalTo(40.0f);
        make.centerY.mas_equalTo(self.headView.mas_centerY);
        make.centerX.mas_equalTo(self.headView.mas_centerX);
    }];
    [self.statusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(38);
        make.height.mas_equalTo(40.0f);
        make.centerY.mas_equalTo(self.headView.mas_centerY);
        make.right.mas_equalTo(-35.0f);
    }];
    [self.idCardLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.idCardButton.mas_right).offset(5.0f);
        make.right.mas_equalTo(self.driverButton.mas_left).offset(-5.0f);
        make.centerY.mas_equalTo(self.headView.mas_centerY).offset(-5.0f);
        make.height.mas_equalTo(1.5f);
    }];
    [self.driverLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.driverButton.mas_right).offset(5.0f);
        make.right.mas_equalTo(self.statusButton.mas_left).offset(-5.0f);
        make.centerY.mas_equalTo(self.headView.mas_centerY).offset(-5.0f);
        make.height.mas_equalTo(1.5f);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0.0f);
        make.bottom.mas_equalTo(0.0f);
        make.height.mas_equalTo(58.0f+UISafeAreaBottomHeight);
    }];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(10.0f);
        make.right.mas_equalTo(-10.0f);
        make.bottom.mas_equalTo(-10-UISafeAreaBottomHeight);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0.0f);
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
        make.height.mas_equalTo(self.scrollView);
    }];
    [self.idCardViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0.0f);
        make.top.bottom.mas_equalTo(0.0f);
        make.width.mas_equalTo(Width);
    }];
    [self.driverViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0.0f);
        make.width.mas_equalTo(Width);
        make.left.mas_equalTo(self.idCardViewController.view.mas_right);
    }];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.driverViewController.view.mas_right);
    }];
    [self.view layoutIfNeeded];
}

- (UIView *)headView{
    if (_headView == nil) {
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = UIColor.whiteColor;
    }
    return _headView;
}

- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = UIColor.whiteColor;
    }
    return _bottomView;
}

- (UIButton *)submitButton{
    if (_submitButton == nil) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
        [_submitButton.titleLabel setFont:[UIFont italicSystemFontOfSize:13]];
        [_submitButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(subaction) forControlEvents:UIControlEventTouchUpInside];
        _submitButton.layer.cornerRadius = 4.0f;
        _submitButton.layer.masksToBounds = YES;
        if ([self.cyrVerify integerValue] == 0) {
            _submitButton.enabled = NO;
            _submitButton.selected = NO;
            [_submitButton setBackgroundColor:COLOR2(238.0f)];
        }else{
            _submitButton.enabled = YES;
            _submitButton.selected = YES;
            [_submitButton setBackgroundColor:COLOR(219.0f,0,0)];
            if ([self.cyrVerify integerValue] == 2) {
                [_submitButton setTitle:@"重新认证" forState:UIControlStateNormal];
            }
        }
    }
    return _submitButton;
}

- (UIOffsetButton *)idCardButton{
    if (_idCardButton == nil) {
        _idCardButton = [UIOffsetButton buttonWithType:UIButtonTypeCustom];
        _idCardButton.imageFrame = CGRectMake(6.5f, 0.0f, 25, 25);
        _idCardButton.titleFrame = CGRectMake(0, 30.0f, 38.0f, 10.0f);
        [_idCardButton setTitleColor:COLOR(219, 0, 0) forState:UIControlStateSelected];
        [_idCardButton setTitleColor:COLOR2(51.0f) forState:UIControlStateNormal];
        [_idCardButton.titleLabel setFont:[UIFont italicSystemFontOfSize:9]];
        [_idCardButton setTitle:@"身份信息" forState:UIControlStateNormal];
        [_idCardButton setImage:[UIImage imageNamed:@"身份证认证"] forState:UIControlStateNormal];
        [_idCardButton setImage:[UIImage imageNamed:@"身份证认证"] forState:UIControlStateSelected];
        _idCardButton.selected = YES;
    }
    return _idCardButton;
}

- (UIOffsetButton *)driverButton{
    if (_driverButton == nil) {
        _driverButton = [UIOffsetButton buttonWithType:UIButtonTypeCustom];
        _driverButton.imageFrame = CGRectMake(11.5f, 0.0f, 25, 25);
        _driverButton.titleFrame = CGRectMake(0, 30.0f, 48.0f, 10.0f);
        [_driverButton setTitleColor:COLOR(219, 0, 0) forState:UIControlStateSelected];
        [_driverButton setTitleColor:COLOR2(51.0f) forState:UIControlStateNormal];
        [_driverButton.titleLabel setFont:[UIFont italicSystemFontOfSize:9]];
        [_driverButton setTitle:@"驾驶证信息" forState:UIControlStateNormal];
        [_driverButton setImage:[UIImage imageNamed:@"驾驶证认证-灰"] forState:UIControlStateNormal];
        [_driverButton setImage:[UIImage imageNamed:@"驾驶证认证"] forState:UIControlStateSelected];
        _driverButton.selected = [self.cyrVerify integerValue] != 0;
    }
    return _driverButton;
}

- (UIOffsetButton *)statusButton{
    if (_statusButton == nil) {
        _statusButton = [UIOffsetButton buttonWithType:UIButtonTypeCustom];
        _statusButton.imageFrame = CGRectMake(6.5f, 0.0f, 25, 25);
        _statusButton.titleFrame = CGRectMake(0, 30.0f, 38.0f, 10.0f);
        [_statusButton setTitleColor:COLOR(219, 0, 0) forState:UIControlStateSelected];
        [_statusButton setTitleColor:COLOR2(51.0f) forState:UIControlStateNormal];
        [_statusButton.titleLabel setFont:[UIFont italicSystemFontOfSize:9]];
        switch ([self.cyrVerify integerValue]) {
            case 0:{
                [_statusButton setTitle:@"审核中" forState:UIControlStateNormal];
                _statusButton.selected = NO;
            }
                break;
            case 5:{
                [_statusButton setTitle:@"审核中" forState:UIControlStateNormal];
                _statusButton.selected = NO;
            }
                break;
            case 1:{
                [_statusButton setTitle:@"审核成功" forState:UIControlStateNormal];
                _statusButton.selected = YES;
            }
                break;
            case 2:
            case 3:
            case 4:{
                [_statusButton setTitle:@"审核失败" forState:UIControlStateNormal];
                _statusButton.selected = NO;
            }
                break;
            default:
                break;
        }
        [_statusButton setImage:[UIImage imageNamed:@"待审核-灰"] forState:UIControlStateNormal];
        [_statusButton setImage:[UIImage imageNamed:@"待审核"] forState:UIControlStateSelected];
        [_statusButton setContentHorizontalAlignment:0];
        _statusButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusButton;
}

- (UIView *)idCardLineView{
    if (_idCardLineView == nil) {
        _idCardLineView = [[UIView alloc] init];
        _idCardLineView.backgroundColor = COLOR(219, 0, 0);
    }
    return _idCardLineView;
}

- (UIView *)driverLineView{
    if (_driverLineView == nil) {
        _driverLineView = [[UIView alloc] init];
        if ([self.cyrVerify integerValue] == 0) {
            _driverLineView.backgroundColor = COLOR2(216);
        }else
            _driverLineView.backgroundColor = COLOR(219,0,0);
    }
    return _driverLineView;
}

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = COLOR2(240);
    }
    return _scrollView;
}

- (UIView *)containerView{
    if (_containerView == nil) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = COLOR2(240);
    }
    return _containerView;
}

- (InfoController *)idCardViewController{
    if (_idCardViewController == nil) {
        _idCardViewController = [[InfoController alloc] init];
        _idCardViewController.viewController = self;
        _idCardViewController.cyrVerify = self.cyrVerify;
        WeakSelf
        [_idCardViewController setSubmitIdCardInfoBlock:^(id  _Nonnull info) {
            if (info) {
                weakSelf.progress = 1;
                [weakSelf.scrollView setContentOffset:CGPointMake(Width, 0.0f) animated:YES];
                weakSelf.submitButton.selected = NO;
                [weakSelf.submitButton setBackgroundColor:COLOR2(238.0f)];
                [weakSelf.submitButton setTitle:@"提交审核" forState:UIControlStateNormal];
                weakSelf.driverLineView.backgroundColor = COLOR(219.0f,0,0);
                weakSelf.submitButton.enabled = NO;
            }
        }];
        [_idCardViewController setSubmitSourceInfoBlock:^(id  _Nonnull info) {
            if (info) {
                weakSelf.shenfendic = info;
                weakSelf.lvcode = [NSString stringWithFormat:@"%@",weakSelf.shenfendic[@"livingBodyAuth"]];
                weakSelf.submitButton.enabled = YES;
                weakSelf.submitButton.selected = YES;
                [weakSelf.submitButton setBackgroundColor:COLOR(219.0f,0,0)];
                
            }
        }];
    }
    return _idCardViewController;
}

- (DriverCertificationViewController *)driverViewController{
    if (_driverViewController == nil) {
        _driverViewController = [[DriverCertificationViewController alloc] init];
        _driverViewController.viewController = self;
        _driverViewController.cyrVerify = self.cyrVerify;
        WeakSelf
        [_driverViewController setReloadBlock:^{
            BOOL endabled = NO;
            if (weakSelf.driverViewController.frontDriverImage != nil) {
                if (weakSelf.driverViewController.backDriverMainImage != nil) {
                    if (weakSelf.driverViewController.frontQualificationImage != nil) {
                        endabled = YES;
                    }
                }
            }
            weakSelf.submitButton.enabled = endabled;
            if (endabled) {
                weakSelf.submitButton.selected = YES;
                [weakSelf.submitButton setBackgroundColor:COLOR(219.0f,0,0)];
            }
        }];
    }
    return _driverViewController;
}

- (void)setProgress:(NSInteger)progress{
    _progress = progress;
    switch (_progress) {
        case 0:
        {
            self.driverLineView.backgroundColor = COLOR2(216);
            self.driverButton.selected = NO;
            self.statusButton.selected = NO;
            self.title = @"身份信息认证";
            [self.statusButton setTitle:@"审核中" forState:UIControlStateNormal];
            [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.bottomView.mas_top).offset(0);
            }];
        }
            break;
        case 1:
        {
            self.driverLineView.backgroundColor = COLOR(219, 0, 0);
            self.driverButton.selected = YES;
            self.statusButton.selected = NO;
            self.title = @"驾驶信息认证";
        }
            break;
        default:
        {
            self.title = @"驾驶信息认证";
            self.driverLineView.backgroundColor = COLOR(219, 0, 0);
            self.driverButton.selected = YES;
            if ([self.cyrVerify integerValue] == 5) {
                self.statusButton.selected = NO;
            }else{
                self.statusButton.selected = [self.cyrVerify integerValue] == 1;
            }
            if ([self.cyrVerify integerValue] == 1) {
                [self.statusButton setTitle:@"审核成功" forState:UIControlStateNormal];
                [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(self.bottomView.mas_top).offset(58.0f+UISafeAreaBottomHeight);
                }];
            }else if ([self.cyrVerify integerValue] == 0){
                [self.statusButton setTitle:@"审核中" forState:UIControlStateNormal];
            }else if ([self.cyrVerify integerValue] == 5){
                [self.statusButton setTitle:@"审核中" forState:UIControlStateNormal];
                [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(self.bottomView.mas_top).offset(58.0f+UISafeAreaBottomHeight);
                }];
            }else{
                [self.statusButton setTitle:@"审核失败" forState:UIControlStateNormal];
                [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(self.bottomView.mas_top).offset(0);
                }];
            }
            if ([self.cyrVerify integerValue] == 0) {
                self.cyrVerify = @"5";
                self.idCardViewController.cyrVerify = self.cyrVerify;
                self.driverViewController.cyrVerify = self.cyrVerify;
                [self.idCardViewController.table reloadData];
                [self.driverViewController.table reloadData];
                [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(self.bottomView.mas_top).offset(58.0f+UISafeAreaBottomHeight);
                }];
            }
        }
            break;
    }
}


-(void)subaction{
//    [self submitFunction];
    if([self.lvcode isEqualToString:@"1"] && [self.cyrVerify integerValue] != 2 && [self.cyrVerify integerValue] != 5){
        //huoti
        [self startLive];
    }else{
        [self submitFunction];
    }
}

- (void)submitFunction{
    
    switch ([self.cyrVerify integerValue]) {
        case 0:
        {
            if (self.progress == 0) {
                //检测正反面
                [self.idCardViewController submitIdCardInfo];
            }else if (self.progress == 1){
                WeakSelf
                [[AlertView alertWithTitle:@"审核提示" message:@"请仔细核对您的信息，若信息有误，将影响您的审核时间和结果，是否确认提交？" cancelButtonTitle:@"返回修改" otherButtonTitle:@"确定提交" handler:^(NSInteger actionIndex) {
                    if (actionIndex > 0) {
                        [weakSelf submitInfo];
                    }
                }] show];
            }
        }
            break;
        case 1:
        {
            [self.scrollView setContentOffset:CGPointMake(Width, 0) animated:YES];
            self.progress = 2;
        }
            break;
        case 2:
        {
            self.progress = 0;
            self.cyrVerify = @"0";
            self.info = nil;
            self.idCardViewController.cyrVerify = self.cyrVerify;
            self.driverViewController.cyrVerify = self.cyrVerify;
            self.idCardViewController.info = self.info;
            self.driverViewController.info = self.info;
            [self.idCardViewController.table reloadData];
            [self.driverViewController.table reloadData];
            [self.submitButton setTitle:@"下一步" forState:UIControlStateNormal];
            self.submitButton.enabled = NO;
            self.submitButton.selected = NO;
            [self.submitButton setBackgroundColor:COLOR2(238.0f)];
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }
            break;
        case 3:
        case 4:
        {
            if (self.scrollView.contentOffset.x == 0.0f) {
                [self.scrollView setContentOffset:CGPointMake(Width, 0) animated:YES];
                self.progress = 2;
                [self.submitButton setTitle:@"重新认证" forState:UIControlStateNormal];
            }else{
                self.progress = 0;
                self.cyrVerify = @"0";
                self.info = nil;
                self.idCardViewController.cyrVerify = self.cyrVerify;
                self.driverViewController.cyrVerify = self.cyrVerify;
                self.idCardViewController.info = self.info;
                self.driverViewController.info = self.info;
                [self.idCardViewController.table reloadData];
                [self.driverViewController.table reloadData];
                [self.submitButton setTitle:@"下一步" forState:UIControlStateNormal];
                self.submitButton.enabled = NO;
                self.submitButton.selected = NO;
                [self.submitButton setBackgroundColor:COLOR2(238.0f)];
                [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            }
        }
            break;
        case 5:{
            [self.scrollView setContentOffset:CGPointMake(Width, 0) animated:YES];
            self.progress = 2;
        }
            break;
    }
}

- (void)submitInfo{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.idCardViewController.dic];
    [params setValue:params[@"num"] forKey:@"idcard"];
    [params removeObjectForKey:@"num"];
    NSMutableArray *fileKeyParams = [NSMutableArray array];
    NSMutableArray *fileParams = [NSMutableArray array];
    if (self.idCardViewController.img1) {
        [fileKeyParams addObject:@"idcardFront"];
        [fileParams addObject:self.idCardViewController.img1];
    }
    if (self.idCardViewController.img2) {
        [fileKeyParams addObject:@"idcardBack"];
        [fileParams addObject:self.idCardViewController.img2];
    }
    if (self.driverViewController.frontDriverImage) {
        [fileKeyParams addObject:@"iddriveFront"];
        [fileParams addObject:self.driverViewController.frontDriverImage];
    }
    if (self.driverViewController.backDriverMainImage) {
        [fileKeyParams addObject:@"iddriveBack"];
        [fileParams addObject:self.driverViewController.backDriverMainImage];
    }
    if (self.driverViewController.backDriverImage) {
        [fileKeyParams addObject:@"iddriveBackBack"];
        [fileParams addObject:self.driverViewController.backDriverImage];
    }
    if (self.driverViewController.frontQualificationImage) {
        [fileKeyParams addObject:@"qualificateFront"];
        [fileParams addObject:self.driverViewController.frontQualificationImage];
    }
    if (self.driverViewController.backQualificationImage) {
        [fileKeyParams addObject:@"qualificateBack"];
        [fileParams addObject:self.driverViewController.backQualificationImage];
    }
    
    WeakSelf
    [AFN_DF POST:@"/system/auth/submit" Parameters:params File:fileKeyParams ImageArr:fileParams ContVC:self success:^(NSDictionary *responseObject) {
        
        weakSelf.progress = 3;
        
        weakSelf.cyrVerify = @"5";
        
        weakSelf.idCardViewController.cyrVerify = weakSelf.cyrVerify;
        weakSelf.driverViewController.cyrVerify = weakSelf.cyrVerify;
        [weakSelf.idCardViewController.table reloadData];
        [weakSelf.driverViewController.table reloadData];
        [UserModel shareInstance].cyrVerify = @"5";
        [weakSelf getUserInfo];
        StrongSelf
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [strongSelf.navigationController pushViewController:[[InfoSubmitSuccessViewController alloc] init] animated:YES];

        });
      
    } failure:^(NSError *error) {

    }];
}

-(void)getUserInfo{
    WeakSelf
    [AFN_DF POST:@"/system/account/getUserInfo" Parameters:nil success:^(NSDictionary *responseObject) {
        
        [[UserModel shareInstance]setValuesForKeysWithDictionary:responseObject[@"data"]];
        NSDictionary *dic = responseObject[@"data"];
        id info = [PNSBuildModelUtils deleteEmpty:dic];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:info forKey:@"user"];
        [user synchronize];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)startLive{
    [self beginDetect:NO];
}

- (void)beginDetect:(BOOL)isCameraBack{
    NSMutableArray *temp = [self randomArray:@[@2, @3, @4, @5] withRandomNum:2];
    [temp addObject:@1];
    LiveDetectController *liveVc = [[LiveDetectController alloc]init];
    liveVc.actionList = [temp copy];
    liveVc.delegate = self;
    liveVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:liveVc animated:YES completion:nil];
    
}

#pragma mark -
#pragma mark LiveDetectControllerDelegate

- (void)onFailed:(int)code withMessage:(NSString *)message{
    if (code != IV_ERROR_BREAK) {
        ResultViewController *resultVc = [[ResultViewController alloc]init];
        resultVc.errorCode = code;
        resultVc.errorMessage = message;
        [self.navigationController pushViewController:resultVc animated:YES];
    }else{
        [self.view addSubview:[Toast makeText:message]];
    }
}

- (void)onFinishWithSign:(NSString *)imageSign{
    self.imgsign = imageSign;
    [self performSelector:@selector(huotiyanzheng) withObject:nil afterDelay:0.2f];
    
}

-(void)huotiyanzheng{
    NSDictionary *dict = @{
        @"idcard":[NSString stringWithFormat:@"%@",self.shenfendic[@"num"]],
        @"name":[NSString stringWithFormat:@"%@",self.shenfendic[@"name"]],
        @"packageName":@"com.df.JSKCProjectD",
        @"signData":self.self.imgsign,
    };
    [LSProgressHUD show];
    [AFN_DF POST:@"/system/auth/livingBodyAuth" Parameters:dict success:^(NSDictionary *responseObject) {
        [LSProgressHUD hide];
        [LSProgressHUD hideForView:self.view];
        self.progress = 1;
        self.lvcode = 0;
        [self.scrollView setContentOffset:CGPointMake(Width, 0.0f) animated:YES];
        self.submitButton.selected = NO;
        [self.submitButton setBackgroundColor:COLOR2(238.0f)];
        [self.submitButton setTitle:@"提交审核" forState:UIControlStateNormal];
        
        self.driverLineView.backgroundColor = COLOR(219.0f,0,0);
        self.submitButton.enabled = NO;
    } failure:^(NSError *error) {
        [LSProgressHUD hide];
    }];
}

//随机数组
- (NSMutableArray *)randomArray:(NSArray *)array withRandomNum:(NSInteger)num {
    
    NSMutableArray *startArray = [[NSMutableArray alloc] initWithArray:array];
    //随机数产生结果
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:0];
    //随机数个数
    for (int i = 0; i < num; i++) {
        int t = arc4random() % startArray.count;
        resultArray[i] = startArray[t];
        startArray[t] = [startArray lastObject]; //为更好的乱序，故交换下位置
        [startArray removeLastObject];
    }
    return resultArray;
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

