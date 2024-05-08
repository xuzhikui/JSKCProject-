//
//  AlertUpdateVersionView.m
//  JSKCProject
//
//  Created by 王宾 on 2022/4/10.
//  Copyright © 2022 孟德峰. All rights reserved.
//

#import "AlertUpdateVersionView.h"

#define AlertUpdateVersionViewTop_height            135.0f
#define AlertUpdateVersionViewBottom_height         81.0f
#define AlertUpdateVersionViewContentCell_height    25.0f

@interface AlertUpdateVersionViewCell : UITableViewCell
@property (nonatomic, strong) UIView *tagView;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation AlertUpdateVersionViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.tagView];
        [self.contentView addSubview:self.contentLabel];
        [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(43.5f);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.height.mas_equalTo(4);
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_equalTo(self.tagView.mas_right).offset(5);
            make.right.mas_equalTo(-40.0f);
        }];
    }
    return self;
}

- (UIView *)tagView{
    if (_tagView == nil) {
        _tagView = [[UIView alloc] init];
        _tagView.backgroundColor = COLOR2(136);
        _tagView.layer.cornerRadius = 2;
        _tagView.layer.masksToBounds = YES;
    }
    return _tagView;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textColor = COLOR2(68);
    }
    return _contentLabel;
}

@end

@interface AlertUpdateVersionView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) Handler handler;

@property (nonatomic, strong) UIImageView *topView;
@property (nonatomic, strong) UIImageView *bottomView;
@property (nonatomic, strong) UITableView *contentTableView;

@property (nonatomic, strong) NSArray *messages;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, strong) UIWindow *alertWindow;

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *otherButton;
@property (nonatomic, strong) UIView *vesionBgView;
@property (nonatomic, strong) UILabel *vesionLabel;

@end

@implementation AlertUpdateVersionView

- (instancetype)initWithVersion:(NSString *)version message:(NSArray *)messages handler:(Handler)handler{
    if (self = [super init]) {
        _handler = [handler copy];
        self.messages = messages;
        [self setUI];
        [self setConstraints];
        self.vesionLabel.text = version;
    }
    return self;
}

+ (instancetype)alertWithVersion:(NSString *)version message:(NSArray *)messages handler:(Handler)handler{
    AlertUpdateVersionView *alertView = nil;
    @autoreleasepool {
        alertView = [[AlertUpdateVersionView alloc] initWithVersion:version message:messages handler:handler];
    }
     return alertView;
}

- (void)setUI{
    [self addSubview:self.topView];
    [self addSubview:self.contentTableView];
    [self addSubview:self.bottomView];
    [self.topView addSubview:self.vesionBgView];
    [self.vesionBgView addSubview:self.vesionLabel];
    [self.bottomView addSubview:self.otherButton];
    [self.bottomView addSubview:self.cancelButton];
}

- (void)setConstraints{
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.top.mas_equalTo(0.0f);
        make.height.mas_equalTo(AlertUpdateVersionViewTop_height);
    }];
    [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0.0f);
        make.top.mas_equalTo(self.topView.mas_bottom);
        CGFloat height = MIN(138, AlertUpdateVersionViewContentCell_height*self.messages.count+38);
        make.height.mas_equalTo(height);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.mas_equalTo(0.0f);
        make.height.mas_equalTo(AlertUpdateVersionViewBottom_height);
        make.top.mas_equalTo(self.contentTableView.mas_bottom);
    }];
    [self.otherButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bottomView.mas_centerX);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(25);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.otherButton.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.bottomView.mas_centerX);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(20);
    }];
    [self.vesionBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-40.0f);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(13);
    }];
    [self.vesionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.vesionBgView.mas_left).offset(5);
        make.right.mas_equalTo(self.vesionBgView.mas_right).offset(-5);
    }];
}

- (UIImageView *)topView{
    if (_topView == nil) {
        _topView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"versionUpdate_top"]];
    }
    return _topView;
}

- (UIImageView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"versionUpdate_bottom"]];
        _bottomView.userInteractionEnabled = YES;
    }
    return _bottomView;
}

- (UIView *)vesionBgView{
    if (_vesionBgView == nil) {
        _vesionBgView = [[UIView alloc] init];
        _vesionBgView.backgroundColor = COLOR(254, 71, 71);
        _vesionBgView.layer.cornerRadius = 6.5;
        _vesionBgView.layer.masksToBounds = YES;
    }
    return _vesionBgView;
}


- (UILabel *)vesionLabel{
    if (_vesionLabel == nil) {
        _vesionLabel = [[UILabel alloc] init];
        _vesionLabel.font = [UIFont systemFontOfSize:9];
        _vesionLabel.textColor = UIColor.whiteColor;
    }
    return _vesionLabel;
}


- (UITableView *)contentTableView{
    if (_contentTableView == nil) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.tableFooterView = [UIView.alloc initWithFrame:CGRectMake(0, 0, 260, 15.0f)];
        _contentTableView.tableHeaderView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, 260, 22.5f)];
        [_contentTableView registerClass:AlertUpdateVersionViewCell.class forCellReuseIdentifier:NSStringFromClass(AlertUpdateVersionViewCell.class)];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.backgroundColor = UIColor.whiteColor;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _contentTableView;
}


- (UIButton *)cancelButton{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitleColor:COLOR2(255) forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [_cancelButton setTitle:@"稍后升级" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(_cancelFunction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)otherButton{
    if (_otherButton == nil) {
        _otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_otherButton setTitle:@"立即升级" forState:UIControlStateNormal];
        [_otherButton setTitleColor:COLOR(255, 23, 23) forState:UIControlStateNormal];
        _otherButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_otherButton addTarget:self action:@selector(_otherFunction) forControlEvents:UIControlEventTouchUpInside];
        _otherButton.backgroundColor = UIColor.whiteColor;
        _otherButton.layer.cornerRadius = 5;
        _otherButton.layer.masksToBounds = YES;
    }
    return _otherButton;
}

- (UIWindow *)alertWindow{
    if (_alertWindow == nil) {
        _alertWindow = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _alertWindow.windowLevel = UIWindowLevelAlert;
    }
    return _alertWindow;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AlertUpdateVersionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AlertUpdateVersionViewCell.class) forIndexPath:indexPath];
    cell.contentLabel.text = self.messages[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AlertUpdateVersionViewContentCell_height;
}



- (void)show{
    for (UIWindow *window in UIApplication.sharedApplication.windows) {
        if (window.windowLevel == UIWindowLevelAlert) {
            return;
        }
    }
    [self.alertWindow addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.alertWindow.mas_centerX);
        make.centerY.mas_equalTo(self.alertWindow.mas_centerY);
        make.width.mas_equalTo(260);
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
