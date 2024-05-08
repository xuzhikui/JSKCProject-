//
//  AlertView.m
//  Yidian
//
//  Created by 王宾 on 2020/7/20.
//  Copyright © 2020 tencent. All rights reserved.
//

#import "AlertView.h"
#import "AppDelegate.h"

@interface AlertView ()

@property (nonatomic, copy) Handler handler;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *messageTextView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *otherButton;

@property (nonatomic, strong) UIView *centerHorizontalLineView;
@property (nonatomic, strong) UIView *centerVerticalLineView;

@property (nonatomic, strong) UIWindow *alertWindow;

@end

@implementation AlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle handler:(Handler)handler{
    if (self = [super init]) {
        _handler = [handler copy];
        if (cancelButtonTitle && cancelButtonTitle.length!=0) {
            [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
        }
        if (otherButtonTitle && otherButtonTitle.length!=0) {
            [self.otherButton setTitle:otherButtonTitle forState:UIControlStateNormal];
        }
        if (otherButtonTitle && cancelButtonTitle == nil) {
            [self.otherButton setTitle:otherButtonTitle forState:UIControlStateNormal];
        }else if (cancelButtonTitle && otherButtonTitle == nil){
            [self.otherButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
        }
        self.titleLabel.text = title;
        self.messageTextView.text = message;
        [self setUI];
        [self setConstraints];
    }
    return self;
}

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle handler:(Handler)handler{
    AlertView *alertView = nil;
    @autoreleasepool {
        alertView = [[AlertView alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle handler:handler];
    }
     return alertView;
}

- (void)setUI{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 16.0f;
    
    if (self.titleLabel.text.length!=0 && self.messageTextView.text.length!=0) {
        self.titleLabel.numberOfLines = 1;
        [self addSubview:self.titleLabel];
        [self addSubview:self.messageTextView];
    }else if (self.titleLabel.text.length!=0 || self.messageTextView.text.length!=0){
        if (self.messageTextView.text.length !=0) {
            self.titleLabel.text = self.messageTextView.text;
        }
        [self addSubview:self.titleLabel];
        _messageTextView = nil;
    }else{
        _titleLabel = nil;
        _messageTextView = nil;
    }
    [self addSubview:self.centerHorizontalLineView];
    [self addSubview:self.centerVerticalLineView];
    [self addSubview:self.cancelButton];
    [self addSubview:self.otherButton];
}

- (void)setConstraints{
    [self.centerHorizontalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-54);
        make.height.mas_equalTo(1.0);
    }];

    if (self.cancelButton.titleLabel.text.length == 0 || self.otherButton.titleLabel.text.length == 0) {
        [self.otherButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.and.bottom.mas_equalTo(0);
            make.top.mas_equalTo(self.centerHorizontalLineView.mas_bottom);
        }];
    }else{
        [self.centerVerticalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(1);
            make.top.mas_equalTo(self.centerHorizontalLineView.mas_bottom).offset(0.0f);
            make.bottom.mas_equalTo(0.0);
        }];
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.bottom.mas_equalTo(0);
            make.right.mas_equalTo(self.centerVerticalLineView.mas_left);
            make.top.mas_equalTo(self.centerHorizontalLineView.mas_bottom);
        }];
        [self.otherButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.and.bottom.mas_equalTo(0);
            make.left.mas_equalTo(self.centerVerticalLineView.mas_right);
            make.top.mas_equalTo(self.cancelButton);
        }];
    }
      
      if (self.titleLabel.text.length!=0 && self.messageTextView.text.length!=0) {
          [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.mas_equalTo(20);
              make.right.mas_equalTo(-20);
              make.top.mas_equalTo(25);
              make.height.mas_equalTo(25);
          }];
          [self.messageTextView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.mas_equalTo(15);
              make.right.mas_equalTo(-15);
              make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10.0f);
              make.bottom.mas_equalTo(self.centerHorizontalLineView.mas_top).offset(-10);
          }];
      }else if (self.titleLabel.text.length!=0 || self.messageTextView.text.length!=0){
          self.titleLabel.numberOfLines = 0;
          [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.mas_equalTo(20);
              make.right.mas_equalTo(-20);
              make.top.mas_equalTo(15);
              make.bottom.mas_equalTo(self.centerHorizontalLineView.mas_top).offset(-10);
          }];
      }
    if (_messageTextView && _messageTextView.text.length > 0) {
        [_messageTextView sizeToFit];
    }
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = COLOR2(51);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UITextView *)messageTextView{
    if (_messageTextView == nil) {
        _messageTextView = [[UITextView alloc] init];
        _messageTextView.font = [UIFont systemFontOfSize:12];
        _messageTextView.textAlignment = NSTextAlignmentCenter;
        _messageTextView.textColor = COLOR2(51);
        _messageTextView.userInteractionEnabled = NO;
        _messageTextView.selectable = NO;
        _messageTextView.editable = NO;
    }
    return _messageTextView;
}

- (UIButton *)cancelButton{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitleColor:COLOR2(51) forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelButton addTarget:self action:@selector(_cancelFunction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)otherButton{
    if (_otherButton == nil) {
        _otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_otherButton setTitle:@"确认" forState:UIControlStateNormal];
        [_otherButton setTitleColor:COLOR(245, 12, 12) forState:UIControlStateNormal];
        _otherButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_otherButton addTarget:self action:@selector(_otherFunction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _otherButton;
}

- (UIView *)centerHorizontalLineView{
    if (_centerHorizontalLineView == nil) {
        _centerHorizontalLineView = [[UIView alloc] init];
        _centerHorizontalLineView.backgroundColor = COLOR2(204);
    }
    return _centerHorizontalLineView;
}

- (UIView *)centerVerticalLineView{
    if (_centerVerticalLineView == nil) {
        _centerVerticalLineView = [[UIView alloc] init];
        _centerVerticalLineView.backgroundColor = COLOR2(204);
    }
    return _centerVerticalLineView;
}

- (UIWindow *)alertWindow{
    if (_alertWindow == nil) {
        _alertWindow = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _alertWindow.windowLevel = UIWindowLevelAlert;
    }
    return _alertWindow;
}

- (void)show{
    for (UIWindow *window in UIApplication.sharedApplication.windows) {
        if (window.windowLevel == UIWindowLevelAlert) {
            return;
        }
    }
    [self.alertWindow addSubview:self];
    [self.titleLabel sizeToFit];
    CGSize size = [self.messageTextView sizeThatFits:CGSizeMake(270, CGFLOAT_MAX)];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.alertWindow.mas_centerX);
        make.centerY.mas_equalTo(self.alertWindow.mas_centerY);
        make.width.mas_equalTo(300);
        CGFloat height = MAX(158.0f, (102.0f+size.height + self.titleLabel.frame.size.height));
        make.height.mas_equalTo(height);
    }];
    self.alertWindow.hidden = NO;
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    self.alpha = 0.0;
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 1.0;
    }];
    self.alertWindow.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.4f];
    [self.alertWindow makeKeyAndVisible];
    [self.alertWindow makeKeyWindow];
}

- (void)dismiss{
    __weak typeof(self) wealSelf = self;
    [self.alertWindow resignKeyWindow];
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
        [appDelegate.window makeKeyWindow];
        wealSelf.alertWindow.windowLevel = -1000;
        wealSelf.alertWindow.hidden = YES;
        for (UIView *subview in wealSelf.subviews){
            [subview removeFromSuperview];
        }
        for (UIView *subview in wealSelf.alertWindow.subviews){
            [subview removeFromSuperview];
        }
        [wealSelf.alertWindow removeFromSuperview];
        wealSelf.alertWindow = nil;
        [wealSelf removeFromSuperview];
    }];
}

- (void)_cancelFunction{
    [self dismiss];
    if (self.handler) {
         self.handler(-1);
    }
}

- (void)_otherFunction{
    [self dismiss];
    if (self.handler) {
        self.handler(1);
    }
}

@end
