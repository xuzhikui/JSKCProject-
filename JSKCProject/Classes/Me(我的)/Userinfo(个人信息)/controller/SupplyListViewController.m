//
//  SupplyListViewController.m
//  JSKCProject
//
//  Created by 王宾 on 2022/3/31.
//  Copyright © 2022 孟德峰. All rights reserved.
//

#import "SupplyListViewController.h"
#import "AddSupplyViewController.h"

@implementation SupplyListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.selectedButton];
        [self.selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-35);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.height.mas_equalTo(18);
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(35);
            make.right.mas_equalTo(self.selectedButton.mas_left).offset(-10.0f);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
    }
    return self;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
    }
    return _contentLabel;
}

- (UIButton *)selectedButton{
    if (_selectedButton == nil) {
        _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectedButton.userInteractionEnabled = NO;
        [_selectedButton setBackgroundImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        [_selectedButton setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        _selectedButton.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _selectedButton;
}

- (void)setInfo:(id)info{
    _info = info;
    self.contentLabel.text = _info[@"gcName"];
}


@end
@interface SupplyListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *botttomView;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) NSMutableArray *list;
@property(nonatomic,strong)UIImageView *imageVC;

@end

@implementation SupplyListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的货源公司";
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.contentTableView];
    [self.view addSubview:self.imageVC];
    [self.view addSubview:self.botttomView];
    [self.botttomView addSubview:self.addButton];
    [self.botttomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(60+UISafeAreaBottomHeight);
    }];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(40);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(NavaBarHeight);
        make.bottom.mas_equalTo(self.botttomView.mas_top);
    }];
    [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.bgView.mas_top).offset(10);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-10);
    }];
    [self.imageVC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
      self.imageVC.hidden = YES;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
    [self postData];
}

- (UITableView *)contentTableView{
    if (_contentTableView == nil) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_contentTableView registerClass:SupplyListTableViewCell.class forCellReuseIdentifier:NSStringFromClass(SupplyListTableViewCell.class)];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.backgroundColor = UIColor.whiteColor;
        _contentTableView.tableFooterView = ({
            UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 60)];
            UIView *contentView = [[UIView alloc] initWithFrame:footer.bounds];
            [footer addSubview:contentView];
            UILabel *tittleLabel = [[UILabel alloc] init];
            tittleLabel.text = @"没有更多数据了";
            tittleLabel.textColor = COLOR2(153);
            tittleLabel.font = [UIFont systemFontOfSize:12];
            [contentView addSubview:tittleLabel];
            UIView *leftLineView = [[UIView alloc] init];
            leftLineView.backgroundColor = COLOR2(230);
            [contentView addSubview:leftLineView];
            UIView *rightLineView = [[UIView alloc] init];
            rightLineView.backgroundColor = COLOR2(230);
            [contentView addSubview:rightLineView];
            
            [tittleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(contentView.mas_centerX);
                make.centerY.mas_equalTo(contentView.mas_centerY);
            }];
            [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(contentView.mas_centerY);
                make.left.mas_equalTo(68);
                make.right.mas_equalTo(tittleLabel.mas_left).offset(-8.0f);
                make.height.mas_equalTo(1.0f);
            }];
            [rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(contentView.mas_centerY);
                make.right.mas_equalTo(-68);
                make.left.mas_equalTo(tittleLabel.mas_right).offset(8.0f);
                make.height.mas_equalTo(1.0f);
            }];
            footer;
        });
        _contentTableView.layer.cornerRadius = 5;
        _contentTableView.layer.masksToBounds = YES;
        _contentTableView.hidden = YES;
        self.contentTableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    }
    return _contentTableView;
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

- (UIButton *)addButton{
    if (_addButton == nil) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setTitle:@"新增货源公司" forState:UIControlStateNormal];
        [_addButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_addButton setBackgroundColor:COLOR(245, 12, 12)];
        [_addButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_addButton addTarget:self action:@selector(addEntrustFunc) forControlEvents:UIControlEventTouchUpInside];
        _addButton.layer.cornerRadius = 5;
        _addButton.layer.masksToBounds = YES;
    }
    return _addButton;
}

- (UIImageView *)imageVC{
    if (_imageVC == nil) {
        _imageVC = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"无货源"]];
    }
    return _imageVC;
}

- (NSMutableArray *)list{
    if (_list == nil) {
        _list = [NSMutableArray new];
    }
    return _list;
}

- (void)addEntrustFunc{
    [self.navigationController pushViewController:AddSupplyViewController.new animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SupplyListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SupplyListTableViewCell.class) forIndexPath:indexPath];
    cell.info = self.list[indexPath.row];
    cell.selectedButton.hidden = YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SupplyListTableViewCell_Height;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeakSelf
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"取消委托" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        if (indexPath.row >= 0 && indexPath.row < weakSelf.list.count) {
            id info = weakSelf.list[indexPath.row];
            StrongSelf
            [AFN_DF POST:@"/system/source/cancel" Parameters:@{@"gcId":info[@"gcId"]} success:^(NSDictionary *responseObject) {
                [weakSelf.list removeObjectAtIndex:indexPath.row];
                [strongSelf.contentTableView beginUpdates];
                [strongSelf.contentTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [strongSelf.contentTableView endUpdates];
                strongSelf.contentTableView.hidden = !strongSelf.list.count;
                if (strongSelf.list.count == 0) {
                    strongSelf.imageVC.hidden = NO;
                }else{
                    strongSelf.imageVC.hidden = YES;
                }
            } failure:^(NSError *error) {
            }];
        }
    }];
    deleteAction.backgroundColor = COLOR(245, 12, 12);
    return @[deleteAction];
}

- (void)postData{
    WeakSelf
    [AFN_DF POST:@"/system/source/get" Parameters:nil success:^(NSDictionary *responseObject) {
        [weakSelf.list removeAllObjects];
        if (responseObject[@"data"] && [responseObject[@"data"] isKindOfClass:NSArray.class]) {
            [weakSelf.list addObjectsFromArray:responseObject[@"data"]];
            weakSelf.contentTableView.hidden = !weakSelf.list.count;
            [weakSelf.contentTableView reloadData];
        }else
            weakSelf.contentTableView.hidden = YES;
        if (weakSelf.list.count == 0) {
            weakSelf.imageVC.hidden = NO;
        }else{
            weakSelf.imageVC.hidden = YES;
        }
    } failure:^(NSError *error) {
        
    }];
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
