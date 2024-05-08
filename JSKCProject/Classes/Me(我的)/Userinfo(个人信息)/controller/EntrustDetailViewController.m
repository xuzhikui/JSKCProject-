//
//  EntrustDetailViewController.m
//  JSKCProject
//
//  Created by 王宾 on 2022/3/31.
//  Copyright © 2022 孟德峰. All rights reserved.
//

#import "EntrustDetailViewController.h"
#import "EntrustResultViewController.h"
#import "UIOffsetButton.h"
#import "EntrustVerifyInfoView.h"

@interface EntrustDetailViewController ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *botttomView;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *meNameTitleLabel;
@property (nonatomic, strong) UILabel *mePhoneTitleLabel;
@property (nonatomic, strong) UILabel *meIdCardTitleLabel;
@property (nonatomic, strong) UILabel *itNameTitleLabel;
@property (nonatomic, strong) UILabel *itPhoneTitleLabel;
@property (nonatomic, strong) UILabel *itIdCardTitleLabel;

@property (nonatomic, strong) UILabel *meNameLabel;
@property (nonatomic, strong) UILabel *mePhoneLabel;
@property (nonatomic, strong) UILabel *meIdCardLabel;
@property (nonatomic, strong) UILabel *itNameLabel;
@property (nonatomic, strong) UILabel *itPhoneLabel;
@property (nonatomic, strong) UILabel *itIdCardLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *entrustTitleLabel;
@property (nonatomic, strong) UILabel *permissionTitleLabel;
@property (nonatomic, strong) UILabel *entrustLabel;
@property (nonatomic, strong) UILabel *permissionLabel;

@property (nonatomic, strong) UILabel *contentLabel1;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *protocolView;
@property (nonatomic, strong) UIOffsetButton *confirmButtton;
@end

@implementation EntrustDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收款委托授权书";
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.botttomView];
    [self.view addSubview:self.scrollView];
    [self.botttomView addSubview:self.nextButton];
    [self.botttomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(60+UISafeAreaBottomHeight);
    }];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(40);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(NavaBarHeight);
        make.bottom.mas_equalTo(self.botttomView.mas_top);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.bgView.mas_top).offset(10);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-10);
    }];
    [self addInfo];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = COLOR2(240);
    }
    return _bgView;
}

- (UIView *)botttomView{
    if (_botttomView == nil) {
        _botttomView = [[UIView alloc] init];
    }
    return _botttomView;
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_nextButton setBackgroundColor:COLOR(245, 12, 12)];
        [_nextButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_nextButton addTarget:self action:@selector(nextFunction) forControlEvents:UIControlEventTouchUpInside];
        _nextButton.layer.cornerRadius = 5;
        _nextButton.layer.masksToBounds = YES;
    }
    return _nextButton;
}

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = UIColor.whiteColor;
        _scrollView.layer.cornerRadius = 5;
        _scrollView.layer.masksToBounds = YES;
        _scrollView.scrollEnabled = YES;
    }
    return _scrollView;
}

- (UILabel *)meNameTitleLabel{
    if (_meNameTitleLabel == nil) {
        _meNameTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 60, 15)];
        _meNameTitleLabel.text = @"司机姓名";
        _meNameTitleLabel.font = [UIFont systemFontOfSize:11];
        _meNameTitleLabel.textColor = COLOR2(102);
    }
    return _meNameTitleLabel;
}

- (UILabel *)mePhoneTitleLabel{
    if (_mePhoneTitleLabel == nil) {
        _mePhoneTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 60, 15)];
        _mePhoneTitleLabel.text = @"手机号";
        _mePhoneTitleLabel.font = [UIFont systemFontOfSize:11];
        _mePhoneTitleLabel.textColor = COLOR2(102);
    }
    return _mePhoneTitleLabel;
}

- (UILabel *)meIdCardTitleLabel{
    if (_meIdCardTitleLabel == nil) {
        _meIdCardTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 80, 60, 15)];
        _meIdCardTitleLabel.text = @"身份证号";
        _meIdCardTitleLabel.font = [UIFont systemFontOfSize:11];
        _meIdCardTitleLabel.textColor = COLOR2(102);
    }
    return _meIdCardTitleLabel;
}

- (UILabel *)itNameTitleLabel{
    if (_itNameTitleLabel == nil) {
        _itNameTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 110, 60, 15)];
        _itNameTitleLabel.text = @"我自愿委托";
        _itNameTitleLabel.font = [UIFont systemFontOfSize:11];
        _itNameTitleLabel.textColor = COLOR2(102);
    }
    return _itNameTitleLabel;
}

- (UILabel *)itPhoneTitleLabel{
    if (_itPhoneTitleLabel == nil) {
        _itPhoneTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 140, 60, 15)];
        _itPhoneTitleLabel.text = @"手机号";
        _itPhoneTitleLabel.font = [UIFont systemFontOfSize:11];
        _itPhoneTitleLabel.textColor = COLOR2(102);
    }
    return _itPhoneTitleLabel;
}

- (UILabel *)itIdCardTitleLabel{
    if (_itIdCardTitleLabel == nil) {
        _itIdCardTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 170, 60, 15)];
        _itIdCardTitleLabel.text = @"身份证号";
        _itIdCardTitleLabel.font = [UIFont systemFontOfSize:11];
        _itIdCardTitleLabel.textColor = COLOR2(102);
    }
    return _itIdCardTitleLabel;
}

- (UILabel *)meNameLabel{
    if (_meNameLabel == nil) {
        _meNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, self.meNameTitleLabel.y, Width-135, 15)];
        _meNameLabel.text = UserModel.shareInstance.name;
        _meNameLabel.font = [UIFont systemFontOfSize:11];
        _meNameLabel.textColor = COLOR2(51);
    }
    return _meNameLabel;
}

- (UILabel *)mePhoneLabel{
    if (_mePhoneLabel == nil) {
        _mePhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, self.mePhoneTitleLabel.y, Width-135, 15)];
        _mePhoneLabel.text = UserModel.shareInstance.username;
        _mePhoneLabel.font = [UIFont systemFontOfSize:11];
        _mePhoneLabel.textColor = COLOR2(51);
    }
    return _mePhoneLabel;
}

- (UILabel *)meIdCardLabel{
    if (_meIdCardLabel == nil) {
        _meIdCardLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, self.meIdCardTitleLabel.y, Width-135, 15)];
        _meIdCardLabel.text = UserModel.shareInstance.idcard;
        _meIdCardLabel.font = [UIFont systemFontOfSize:11];
        _meIdCardLabel.textColor = COLOR2(51);
    }
    return _meIdCardLabel;
}

- (UILabel *)itNameLabel{
    if (_itNameLabel == nil) {
        _itNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, self.itNameTitleLabel.y, Width-135, 15)];
        _itNameLabel.text = self.info[@"name"];
        _itNameLabel.font = [UIFont systemFontOfSize:11];
        _itNameLabel.textColor = COLOR2(51);
    }
    return _itNameLabel;
}

- (UILabel *)itPhoneLabel{
    if (_itPhoneLabel == nil) {
        _itPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, self.itPhoneTitleLabel.y, Width-135, 15)];
        _itPhoneLabel.text = self.info[@"phone"];
        _itPhoneLabel.font = [UIFont systemFontOfSize:11];
        _itPhoneLabel.textColor = COLOR2(51);
    }
    return _itPhoneLabel;
}

- (UILabel *)itIdCardLabel{
    if (_itIdCardLabel == nil) {
        _itIdCardLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, self.itIdCardTitleLabel.y, Width-135, 15)];
        _itIdCardLabel.text = self.info[@"idcard"];
        _itIdCardLabel.font = [UIFont systemFontOfSize:11];
        _itIdCardLabel.textColor = COLOR2(51);
    }
    return _itIdCardLabel;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.itIdCardLabel.frame)+15, Width - 50, 40)];
        _contentLabel.numberOfLines = 0;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"代表我本人在宜兴市交运物流信息科技有限公司网络货运平台上完成运输业务后的收款结算事宜。"];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 12.5f; // 调整行间距
        paragraphStyle.headIndent = 0.0f;
        paragraphStyle.firstLineHeadIndent = 22.0f;
        [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:COLOR2(51),NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0,  [attributedString length])];
        _contentLabel.attributedText = attributedString;
    }
    return _contentLabel;
}

- (UILabel *)entrustTitleLabel{
    if (_entrustTitleLabel == nil) {
        _entrustTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.contentLabel.frame)+15, 60, 15)];
        _entrustTitleLabel.text = @"委托权限";
        _entrustTitleLabel.font = [UIFont systemFontOfSize:11];
        _entrustTitleLabel.textColor = COLOR2(102);
    }
    return _entrustTitleLabel;
}

- (UILabel *)permissionTitleLabel{
    if (_permissionTitleLabel == nil) {
        _permissionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.entrustTitleLabel.frame)+15, 60, 15)];
        _permissionTitleLabel.text = @"委托时限";
        _permissionTitleLabel.font = [UIFont systemFontOfSize:11];
        _permissionTitleLabel.textColor = COLOR2(102);
    }
    return _permissionTitleLabel;
}

- (UILabel *)entrustLabel{
    if (_entrustLabel == nil) {
        _entrustLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, self.entrustTitleLabel.y, Width - 135, 15)];
        _entrustLabel.text = @"全权委托";
        _entrustLabel.font = [UIFont systemFontOfSize:11];
        _entrustLabel.textColor = COLOR2(51);
    }
    return _entrustLabel;
}

- (UILabel *)permissionLabel{
    if (_permissionLabel == nil) {
        _permissionLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, self.permissionTitleLabel.y, Width-135, 15)];
        _permissionLabel.text = @"与使用平台同期";
        _permissionLabel.font = [UIFont systemFontOfSize:11];
        _permissionLabel.textColor = COLOR2(51);
    }
    return _permissionLabel;
}

- (UILabel *)contentLabel1{
    if (_contentLabel1 == nil) {
        _contentLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.permissionLabel.frame)+15, Width-50, 15)];
        _contentLabel1.text = @"以上委托事项所产生的法律责任均由本人全部承担。";
        _contentLabel1.font = [UIFont systemFontOfSize:11];
        _contentLabel1.textColor = COLOR2(51);
    }
    return _contentLabel1;
}

- (UILabel *)dateLabel{
    if (_dateLabel == nil) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width - 135 , CGRectGetMaxY(self.contentLabel1.frame)+15, 100, 15)];
        _dateLabel.font = [UIFont systemFontOfSize:11];
        _dateLabel.textColor = COLOR2(51);
        _dateLabel.textAlignment = NSTextAlignmentRight;
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy.MM.dd"];
        NSString *dateStr = [formatter stringFromDate:date];
        formatter = nil;
        _dateLabel.text = dateStr;
    }
    return _dateLabel;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.dateLabel.frame)+110, Width - 50, 1)];
        _lineView.backgroundColor = COLOR2(245);
    }
    return _lineView;
}

- (UIView *)protocolView{
    if (_protocolView == nil) {
        _protocolView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lineView.frame)+1, Width-20, 48)];
    }
    return _protocolView;
}

- (UIOffsetButton *)confirmButtton{
    if (_confirmButtton == nil) {
        _confirmButtton = [UIOffsetButton buttonWithType:UIButtonTypeCustom];
        _confirmButtton.imageFrame = CGRectMake(0, 10, 15, 15);
        _confirmButtton.titleFrame = CGRectMake(23, 0, 135, 35);
        [_confirmButtton setImage:[UIImage imageNamed:@"protocolUnSelected"] forState:UIControlStateNormal];
        [_confirmButtton setImage:[UIImage imageNamed:@"protocolSelected"] forState:UIControlStateSelected];
        [_confirmButtton setTitle:@"我已阅读并同意以上协议" forState:UIControlStateNormal];
        [_confirmButtton setTitleColor:COLOR2(102) forState:UIControlStateNormal];
        [_confirmButtton.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_confirmButtton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        _confirmButtton.contentMode = UIViewContentModeScaleAspectFill;
        _confirmButtton.selected = YES;
        [_confirmButtton addTarget:self action:@selector(protocolFunction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButtton;
}

- (void)addInfo{
    [self.scrollView addSubview:self.meNameTitleLabel];
    [self.scrollView addSubview:self.mePhoneTitleLabel];
    [self.scrollView addSubview:self.meIdCardTitleLabel];
    [self.scrollView addSubview:self.itNameTitleLabel];
    [self.scrollView addSubview:self.itPhoneTitleLabel];
    [self.scrollView addSubview:self.itIdCardTitleLabel];
    [self.scrollView addSubview:self.meNameLabel];
    [self.scrollView addSubview:self.mePhoneLabel];
    [self.scrollView addSubview:self.meIdCardLabel];
    [self.scrollView addSubview:self.itNameLabel];
    [self.scrollView addSubview:self.itPhoneLabel];
    [self.scrollView addSubview:self.itIdCardLabel];
    
    [self.scrollView addSubview:self.contentLabel];
    [self.scrollView addSubview:self.entrustTitleLabel];
    [self.scrollView addSubview:self.permissionTitleLabel];
    [self.scrollView addSubview:self.entrustLabel];
    [self.scrollView addSubview:self.permissionLabel];
    [self.scrollView addSubview:self.contentLabel1];
    [self.scrollView addSubview:self.dateLabel];
    [self.scrollView addSubview:self.lineView];
    [self.scrollView addSubview:self.protocolView];
    [self.protocolView addSubview:self.confirmButtton];
    [self.scrollView setContentSize:CGSizeMake(Width-20, CGRectGetMaxY(self.protocolView.frame))];
    [self.confirmButtton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.protocolView.mas_centerY);
        make.centerX.mas_equalTo(self.protocolView.mas_centerX);
        make.width.mas_equalTo(158);
        make.height.mas_equalTo(35);
    }];
}

- (void)protocolFunction{
    self.confirmButtton.selected = !self.confirmButtton.selected;
}

- (void)nextFunction{
    if (self.confirmButtton.selected) {
        //弹窗
        EntrustVerifyInfoView *infoView = [EntrustVerifyInfoView new];
        infoView.truckerId = [self.info[@"truckerId"] integerValue];
        [self.view addSubview:infoView];
        WeakSelf
        [infoView setConfirmBlock:^{
            EntrustResultViewController *entrustResultVC = [EntrustResultViewController new];
            [weakSelf.navigationController pushViewController:entrustResultVC animated:YES];
        }];
    }else
        [self.view addSubview:[Toast makeText:@"请阅读并同意以上协议"]];
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
