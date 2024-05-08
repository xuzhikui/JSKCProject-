//
//  UnBandController.m
//  JSKCProject
//
//  Created by 孟德峰 on 2020/12/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "UnBandController.h"
#import "AddBandCell.h"
#import "UIButton+ExtendedMethods.h"

@interface UnBandController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSArray *titArray;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)UIButton *codeButton;

@end

@implementation UnBandController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"解绑银行卡";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    
}


-(void)setUI{

    
    self.titArray = @[@"持卡人",@"身份证",@"银行卡号",@"开户银行",@"手机号码",@"短信验证",];
    self.dataArray = @[
        self.dic[@"name"],
        [NSString stringWithFormat:@"%@",self.dic[@"idCard"]],
       [NSString stringWithFormat:@"%@", self.dic[@"bankCardNum"]],
        [NSString stringWithFormat:@"%@",self.dic[@"bankSub"]],
        [NSString stringWithFormat:@"%@",self.dic[@"phone"]],
    ];
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, NavaBarHeight, Width,320) style:(UITableViewStylePlain)];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[AddBandCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.table];
    self.table.backgroundColor = COLOR2(240);
    self.table.scrollEnabled = NO;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    UIButton *suppBut = [UIButton initWithFrame:CGRectMake(20, NavaBarHeight +370, Width - 40, 40) :@"确认解绑" :16];
    suppBut.backgroundColor = [UIColor redColor];
    suppBut.layer.cornerRadius = 4;
    suppBut.layer.masksToBounds = YES;
    [suppBut addTarget:self action:@selector(bandAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:suppBut];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
  
        return 6;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddBandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
        cell.tit = self.titArray[indexPath.row];

    if (indexPath.row == 5) {
        cell.textTF.userInteractionEnabled = YES;
        cell.textTF.placeholder = @"请输入验证码";
        cell.textTF.keyboardType = UIKeyboardTypeNumberPad;
        if (self.codeButton == nil) {
            _codeButton = [UIButton initWithFrame:CGRectMake(Width - 120,10, 100, 20) :@"获取验证码":14*Width1];
            _codeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [_codeButton setTitleColor:[UIColor redColor] forState:0];
            [_codeButton addTarget:self action:@selector(codeButAction) forControlEvents:(UIControlEventTouchUpInside)];
            [cell.contentView addSubview:self.codeButton];
        }
        cell.textTF.placeholder = @"请输入验证码";
    }else{
        cell.textTF.userInteractionEnabled = NO;
        cell.textTF.text = self.dataArray[indexPath.row];

    }

    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 41;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 10, Width, 50)];
    back.backgroundColor = COLOR2(230);
    
    if (section == 0) {
        [UILabel initWithDFLable:CGRectMake(20, 0, 200, 50) :[UIFont systemFontOfSize:12*Width1] :[UIColor blackColor] :@"解绑后将无法提现，请尽快绑定新卡" :back :0];
    }
    
    
    return back;
    
}

-(void)codeButAction{
    
    AddBandCell *cell = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
   WeakSelf
    [AFN_DF POST:@"/system/wallet/sendsms" Parameters:@{@"phone":cell.textTF.text} success:^(NSDictionary *responseObject) {
        [weakSelf.codeButton startCountDownTime:60 withCountDownBlock:nil];
        [weakSelf.view addSubview:[Toast makeText:@"发送验证码成功"]];
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)bandAction{
    
   
    AddBandCell *cell = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    
    if ([cell.textTF.text isEqualToString:@""]) {
        
        return [self.view addSubview:[Toast makeText:@"请先输入验证码"]];
    }
    
    [self.codeButton stopCountDownTime];
    [AFN_DF POST:@"/system/wallet/unbind" Parameters:@{@"bankCardId":self.dic[@"id"],@"code":cell.textTF.text} success:^(NSDictionary *responseObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

- (void)dealloc{
    [self.codeButton stopCountDownTime];
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
