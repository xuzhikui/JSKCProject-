//
//  CarManListNewCell.m
//  JSKCProject
//
//  Created by 王宾 on 2022/3/31.
//  Copyright © 2022 孟德峰. All rights reserved.
//

#import "CarManListNewCell.h"

@implementation CarManListNewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = self.contentView.backgroundColor = UIColor.clearColor;
        [self setUI];
        [self setConstraints];
    }
    return self;
}

- (void)setUI{
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.tagView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.contentLabel];
    [self.bgView addSubview:self.bindImageView];
}

- (void)setConstraints{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.0f);
        make.right.mas_equalTo(-10.0f);
        make.top.mas_equalTo(0.0f);
        make.bottom.mas_equalTo(-2.0f);
    }];
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.mas_equalTo(5);
        make.height.mas_equalTo(20);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tagView.mas_right).offset(5);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(20);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
    }];
    [self.bindImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.0f);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
    }];
}

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = UIColor.whiteColor;
    }
    return _bgView;
}

- (UIView *)tagView{
    if (_tagView == nil) {
        _tagView = [[UIView alloc] init];
    }
    return _tagView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = COLOR2(51);
        _titleLabel.text = @"车牌";
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.textColor = COLOR2(51);
    }
    return _contentLabel;
}

- (UIImageView *)bindImageView{
    if (_bindImageView == nil) {
        _bindImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bind_icon"]];
        _bindImageView.hidden = YES;
    }
    return _bindImageView;
}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    NSInteger plateColor = [self.dic[@"plateColor"] integerValue];
    if (plateColor == 1) {
        self.tagView.backgroundColor = COLOR(255, 207, 39);
    }else if (plateColor == 2){
        self.tagView.backgroundColor = COLOR(82, 128, 242);
    }else if (plateColor == 3){
        self.tagView.backgroundColor = COLOR(134, 190, 1);
    }
    self.contentLabel.text = self.dic[@"plateNumber"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
