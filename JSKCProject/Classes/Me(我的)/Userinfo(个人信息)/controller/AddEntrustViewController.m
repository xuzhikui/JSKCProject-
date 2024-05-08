//
//  AddEntrustViewController.m
//  JSKCProject
//
//  Created by 王宾 on 2022/3/31.
//  Copyright © 2022 孟德峰. All rights reserved.
//

#import "AddEntrustViewController.h"
#import "EntrustDetailViewController.h"
#import "EntrustListViewController.h"
@interface AddEntrustViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic,strong) UITextField *searchTF;
@property (nonatomic, strong) UIView *botttomView;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property(nonatomic,strong)UIImageView *imageVC;

@end

@implementation AddEntrustViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增委托收款人";
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.tableViewHeaderView];
    [self.view addSubview:self.contentTableView];
    [self.view addSubview:self.imageVC];
    [self.view addSubview:self.botttomView];
    [self.botttomView addSubview:self.confirmButton];
    [self.botttomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(60+UISafeAreaBottomHeight);
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(40);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(NavaBarHeight+70);
        make.bottom.mas_equalTo(self.botttomView.mas_top);
    }];
    [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.bgView.mas_top);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-10);
    }];
    [self.imageVC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}

- (UIView *)tableViewHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, NavaBarHeight, Width, 70)];
    headerView.backgroundColor = COLOR2(240);
    UIView *textVC = [[UIView alloc]initWithFrame:CGRectMake(20, 15, Width - 40, 40)];
    textVC.layer.cornerRadius = 4;
    textVC.layer.borderWidth = 1;
    textVC.backgroundColor = UIColor.whiteColor;
    textVC.layer.borderColor = [COLOR2(153)CGColor];
    [headerView addSubview:textVC];
    
    UIImageView *searImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12.5, 15, 15)];
    searImg.image = [UIImage imageNamed:@"搜索-1"];
    [textVC addSubview:searImg];
    
    _searchTF = [[UITextField alloc]initWithFrame:CGRectMake(35, 10, Width - 100, 20)];
    _searchTF.keyboardType = UIKeyboardTypePhonePad;
    _searchTF.returnKeyType = UIReturnKeySearch;
    self.searchTF.font = [UIFont systemFontOfSize:14];
    self.searchTF.placeholder = @"请输入委托收款人手机号";
    [self.searchTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.searchTF.delegate = self;
    [textVC addSubview:self.searchTF];
    
    return headerView;
}
  
- (UITableView *)contentTableView{
    if (_contentTableView == nil) {
        _contentTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        self.contentTableView.delegate = self;
        self.contentTableView.dataSource = self;
        self.contentTableView.backgroundColor = UIColor.whiteColor;
        [self.contentTableView registerClass:[EntrustListTableViewCell class] forCellReuseIdentifier:@"EntrustListTableViewCell"];
        self.contentTableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
        self.contentTableView.layer.cornerRadius = 5;
        self.contentTableView.layer.masksToBounds = YES;
        self.contentTableView.hidden = YES;
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

- (UIButton *)confirmButton{
    if (_confirmButton == nil) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_confirmButton setBackgroundColor:COLOR(245, 12, 12)];
        [_confirmButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_confirmButton addTarget:self action:@selector(cofirmFunction) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.layer.cornerRadius = 5;
        _confirmButton.layer.masksToBounds = YES;
    }
    return _confirmButton;
}

- (UIImageView *)imageVC{
    if (_imageVC == nil) {
        _imageVC = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"暂无委托人"]];
    }
    return _imageVC;
}

- (NSMutableArray *)list{
    if (_list == nil) {
        _list = [NSMutableArray new];
    }
    return _list;
}

- (void)textFieldDidChange:(UITextField *)textField{
    NSString *text = textField.text;
    if (text.length>11) {
        NSString *tempText = [text substringToIndex:11];
        textField.text = tempText;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length == 11) {
        [self postData];
    }else{
        [self.list removeAllObjects];
        self.contentTableView.hidden = YES;
        self.imageVC.hidden = NO;
        [self.contentTableView reloadData];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EntrustListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(EntrustListTableViewCell.class) forIndexPath:indexPath];
    cell.info = self.list[indexPath.row];
    cell.selectedButton.selected = (self.indexPath && self.indexPath.row == indexPath.row);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return EntrustListTableViewCell_Height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.indexPath && self.indexPath.row == indexPath.row) {
        self.indexPath = nil;
    }else
        self.indexPath = indexPath;
    [tableView reloadData];
}

- (void)postData{
    WeakSelf
    [AFN_DF POST:@"/system/entrust/get" Parameters:@{@"phone":self.searchTF.text} success:^(NSDictionary *responseObject) {
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


- (void)cofirmFunction{
    if (self.indexPath == nil) {
        return [self.view addSubview:[Toast makeText:@"请选择委托人"]];
    }
    id info = self.list[self.indexPath.row];
    if ([info[@"trusted"] boolValue]) {
        return [self.view addSubview:[Toast makeText:@"已委托"]];
    }
    EntrustDetailViewController *entrustDetialVC = [EntrustDetailViewController new];
    entrustDetialVC.info = info;
    [self.navigationController pushViewController:entrustDetialVC animated:YES];
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
