//
//  EntrustVerifyInfoView.m
//  JSKCProject
//
//  Created by 王宾 on 2022/4/2.
//  Copyright © 2022 孟德峰. All rights reserved.
//

#import "EntrustVerifyInfoView.h"
#import "UIButton+ExtendedMethods.h"

@interface EntrustVerifyInfoView ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *codeButton;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *bottomLineView;
@end

@implementation EntrustVerifyInfoView

- (instancetype)init{
    if (self = [super init]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    self.frame = CGRectMake(0, 0, Width, Height);
    [self addSubview:self.bgView];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.phoneTextField];
    [self.contentView addSubview:self.codeButton];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.codeTextField];
    [self.contentView addSubview:self.bottomLineView];
    [self.contentView addSubview:self.cancelButton];
    [self.contentView addSubview:self.confirmButton];
    [self setConstraints];
}

- (void)setConstraints{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(25);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.bottom.mas_equalTo(-18);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(28);
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-25);
        make.width.height.and.bottom.mas_equalTo(self.cancelButton);
    }];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-25);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(65);
    }];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(self.codeButton.mas_left).offset(-10);
        make.top.mas_equalTo(self.codeButton);
        make.height.mas_equalTo(35);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.codeButton.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(self.lineView.mas_bottom);
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.codeTextField.mas_bottom);
        make.height.mas_equalTo(1);
    }];
}

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.frame = self.bounds;
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.5;
        UITapGestureRecognizer *TapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapGR)];
        [_bgView addGestureRecognizer:TapGR];
    }
    return _bgView;
}

- (UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake((Width - 270)*0.5f, 205, 270, 195.0f)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = 10;
    }
    return _contentView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"验证码验证";
        _titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        _titleLabel.textColor = COLOR2(51);
    }
    return _titleLabel;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = COLOR2(241);
    }
    return _lineView;
}

- (UIView *)bottomLineView{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = COLOR2(241);
    }
    return _bottomLineView;
}

- (UIButton *)codeButton{
    if (_codeButton == nil) {
        _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeButton setTitleColor:COLOR(245, 12, 12) forState:UIControlStateNormal];
        [_codeButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_codeButton addTarget:self action:@selector(getCodeFunction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeButton;
}

- (UIButton *)cancelButton{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:COLOR(245, 12, 12) forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_cancelButton addTarget:self action:@selector(cancelFunction) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.layer.cornerRadius = 4;
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.borderWidth = 1;
        _cancelButton.layer.borderColor = COLOR(245, 12, 12).CGColor;
    }
    return _cancelButton;
}

- (UIButton *)confirmButton{
    if (_confirmButton == nil) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_confirmButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_confirmButton addTarget:self action:@selector(confirmFunction) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.layer.cornerRadius = 4;
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.backgroundColor = COLOR(245, 12, 12);
    }
    return _confirmButton;
}

- (UITextField *)phoneTextField{
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.placeholder = @"请输入手机号码";
        _phoneTextField.font = [UIFont systemFontOfSize:12];
        _phoneTextField.textColor = COLOR2(51);
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.delegate = self;
        _phoneTextField.text = UserModel.shareInstance.username;
        [_phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneTextField;
}

- (UITextField *)codeTextField{
    if (_codeTextField == nil) {
        _codeTextField = [[UITextField alloc] init];
        _codeTextField.placeholder = @"请输入验证码";
        _codeTextField.font = [UIFont systemFontOfSize:12];
        _codeTextField.textColor = COLOR2(51);
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.delegate = self;
        [_codeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _codeTextField;
}

- (void)cancelFunction{
    [self onTapGR];
}

-(void)onTapGR{
    [self removeFromSuperview];
}

- (void)confirmFunction{
    [self.codeButton stopCountDownTime];
    WeakSelf
    [AFN_DF POST:@"/system/entrust/trust" Parameters:@{@"code":self.codeTextField.text,@"truckerId":@(self.truckerId)} success:^(NSDictionary *responseObject) {
        if (weakSelf.confirmBlock) {
            weakSelf.confirmBlock();
        }
        [weakSelf onTapGR];
    } failure:^(NSError *error) {
    }];
}

- (void)getCodeFunction{
    WeakSelf
    [AFN_DF POST:@"/system/entrust/getCode" Parameters:@{@"phone":self.phoneTextField.text} success:^(NSDictionary *responseObject) {
        [weakSelf.codeButton startCountDownTime:60 withCountDownBlock:nil];
    } failure:^(NSError *error) {
    }];
}

- (void)textFieldDidChange:(UITextField *)textField{
    NSString *text = textField.text;
    if ([textField isEqual:self.phoneTextField]) {
        if (text.length>11) {
            NSString *tempText = [text substringToIndex:11];
            textField.text = tempText;
        }
    }else if ([textField isEqual:self.codeTextField]){
        if (text.length>6) {
            NSString *tempText = [text substringToIndex:6];
            textField.text = tempText;
            
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)dealloc{
    [self.codeButton stopCountDownTime];
}

@end
