//
//  CarManController.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/27.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "CarManController.h"
#import "CarManListCell.h"
#import "CarManListNewCell.h"
#import "AddCarController.h"
#import "AddCarNewViewController.h"

#import "TwoAddressController.h"
@interface CarManController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITextField *searchTF;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *searArray;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end

@implementation CarManController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = YES;
   
    [self.dataArray removeAllObjects];
    [self postData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *navBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, NavaBarHeight)];
    navBgView.backgroundColor = UIColor.whiteColor;
    [self.view insertSubview:navBgView atIndex:0];
    self.title = @"主驾绑定记录";
    self.dataArray = [NSMutableArray array];
    self.searArray = [NSMutableArray array];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setUI];
    
  
}

-(void)postData{
    
    WeakSelf
    [AFN_DF POST:@"/system/truck/trucks" Parameters:nil success:^(NSDictionary *responseObject) {
        
        NSArray *arr = responseObject[@"data"];
        for (NSDictionary *dic in arr) {
            
            [weakSelf.dataArray addObject:dic];
        }
        
        [weakSelf.table reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)setUI{
    
    UIView *tabbarVC  = [[UIView alloc]initWithFrame:CGRectMake(0, Height - 60-  ScreenBottom , Width, 60)];
       tabbarVC.backgroundColor = [UIColor whiteColor];
       [self.view addSubview:tabbarVC];
       
    if (UserModel.shareInstance.bandTruckCount != 0) {
        CGFloat width = (Width - 60)*0.5f;
        ;
        UIButton *unbindButton = [UIButton initWithFrame:CGRectMake(20, 10, width, 40) :@"新增车辆" :16*Width1];
        unbindButton.backgroundColor = UIColor.clearColor;
        [unbindButton setTitleColor:COLOR(245, 12, 12) forState:0];
        unbindButton.layer.cornerRadius = 4;
        unbindButton.layer.borderWidth = 1;
        unbindButton.layer.borderColor = COLOR(245, 12, 12).CGColor;
        [unbindButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [unbindButton addTarget:self action:@selector(addcarAction:) forControlEvents:(UIControlEventTouchUpInside)];
        unbindButton.layer.borderColor = [[UIColor redColor]CGColor];
        unbindButton.tag = 2;
        [tabbarVC addSubview:unbindButton];
        
        UIButton *addCarBut = [UIButton initWithFrame:CGRectMake(Width - width - 20, 10, width, 40) :@"重新绑定" :16*Width1];
        [addCarBut setTitleColor:UIColor.whiteColor forState:0];
        addCarBut.layer.cornerRadius = 4;
        [addCarBut.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [addCarBut addTarget:self action:@selector(addcarAction:) forControlEvents:(UIControlEventTouchUpInside)];
        addCarBut.tag = 1;
        addCarBut.backgroundColor = COLOR(245, 12, 12);
        [tabbarVC addSubview:addCarBut];
        
    }else{
        UIButton *addCarBut = [UIButton initWithFrame:CGRectMake(20, 10, Width - 40, 40) :@"绑定车辆" :16*Width1];
        [addCarBut setTitleColor:[UIColor redColor] forState:0];
        addCarBut.layer.cornerRadius = 4;
        addCarBut.layer.borderWidth = 1;
        [addCarBut addTarget:self action:@selector(addcarAction:) forControlEvents:(UIControlEventTouchUpInside)];
        addCarBut.layer.borderColor = [[UIColor redColor]CGColor];
        addCarBut.tag = 1;
        [tabbarVC addSubview:addCarBut];
    }

    [self addListView];

}

///添加车辆
-(void)addcarAction:(UIButton *)sender{
    if (sender.tag == 2) {
        AddCarNewViewController *addVC = [AddCarNewViewController new];
        addVC.title = @"绑定车辆";
        addVC.addType = @"1";
        [self.navigationController pushViewController:addVC animated:YES];
    }else{
        if (self.indexPath == nil) {
            [self.view  addSubview:[Toast makeText:@"请选择车辆"]];
            return;
        }
        id params = [NSMutableDictionary dictionary];
        NSDictionary *dic = self.dataArray[self.indexPath.row];
        [params setValue:dic[@"plateNumber"] forKey:@"plateNumber"];
        [params setValue:dic[@"plateColor"] forKey:@"plateType"];
        [params setValue:@"1" forKey:@"driverType"];
        WeakSelf
        [AFN_DF POST:@"/system/truck/driectAddDriver" Parameters:params success:^(NSDictionary *responseObject) {
            NSInteger truckId = [responseObject[@"data"][@"truckId"]integerValue];
            UserModel.shareInstance.bandTruckId = @(truckId);
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            id userInfo = [user objectForKey:@"user"];
            if (userInfo && [userInfo count] > 0) {
                NSMutableDictionary *userInfoParams = [NSMutableDictionary dictionaryWithDictionary:userInfo];
                [userInfoParams setObject:@(truckId) forKey:@"bandTruckId"];
                [user setObject:userInfoParams forKey:@"user"];
                [user synchronize];
            }
            [[AFN_DF topViewController].view addSubview:[Toast makeText:@"提交成功"]];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            if (UserModel.shareInstance.hasBankCard == nil || [UserModel.shareInstance.hasBankCard integerValue] == 0) {
                CardInfoVC *vc =  [[CardInfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                vc.tag = 1;
                [UIApplication.sharedApplication.keyWindow addSubview:vc];
                return;
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

-(void)addListView{

    _table = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor =COLOR2(240);
    [self.table registerClass:[CarManListNewCell class] forCellReuseIdentifier:@"cell"];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.tableHeaderView = self.tableViewHeaderView;
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0.0f);
        make.top.mas_equalTo(NavaBarHeight);
        make.bottom.mas_equalTo(-ScreenBottom-60);
    }];
}

- (UIView *)tableViewHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 72)];
    headerView.backgroundColor = COLOR2(240);

    
    UIView *searchVC  = [[UIView alloc]initWithFrame:CGRectMake(10, 10, Width - 20, 60)];
    searchVC.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:searchVC];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CGRect bounds = CGRectMake(0, 0, Width-20 , 60.0f);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(4, 4)];
    layer.frame = bounds;
    layer.path = maskPath.CGPath;
    searchVC.layer.mask = layer;
    
    UIView *textVC = [[UIView alloc]initWithFrame:CGRectMake(10, 10, Width - 40, 40)];
    textVC.layer.cornerRadius = 4;
    textVC.layer.borderWidth = 1;
    textVC.layer.borderColor = [COLOR2(204)CGColor];
    [searchVC addSubview:textVC];
    
    UIImageView *searImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12.5, 15, 15)];
    searImg.image = [UIImage imageNamed:@"搜索-1"];
    [textVC addSubview:searImg];
    
    _searchTF = [[UITextField alloc]initWithFrame:CGRectMake(35, 10, Width - 100, 20)];
    _searchTF.returnKeyType = UIReturnKeySearch;
    self.searchTF.font = [UIFont systemFontOfSize:15*Width1];
    self.searchTF.placeholder = @"请输入车牌号";
    [self.searchTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
      self.searchTF.delegate = self;
    [textVC addSubview:self.searchTF];
    return headerView;
}
    

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.searArray.count != 0 || ![self.searchTF.text isEqualToString:@""]) {
        
      return self.searArray.count;
    }else{
        
        return self.dataArray.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSArray *arr;
    
    if (self.searArray.count != 0 || ![self.searchTF.text isEqualToString:@""]) {
          
        arr = self.searArray;
    }else{
        
        arr = self.dataArray;
    }
    
    CarManListNewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.dic = arr[indexPath.row];
    cell.bindImageView.hidden = !(self.indexPath && self.indexPath.row == indexPath.row);
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CarManListNewCell_Height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.indexPath && self.indexPath.row == indexPath.row) {
        self.indexPath = nil;
    }else
        self.indexPath = indexPath;
    [tableView reloadData];
//    NSDictionary *dic = self.dataArray[indexPath.row];
//    NSInteger verify = [[NSString stringWithFormat:@"%@",dic[@"verify"]]integerValue];
//
//       if (verify == 1) {
//
//           TwoAddressController *twoVC = [TwoAddressController new];
//           twoVC.dic =  dic;
//           twoVC.codedic = dic;
//           [self.navigationController pushViewController:twoVC animated:YES];
//
//       }else{
//
//            AddCarController *addvc = [AddCarController new];
//            addvc.dic = self.dataArray[indexPath.row];
//            addvc.title = @"车辆信息";
//            [self.navigationController pushViewController:addvc animated:YES];
//
//       }
//
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
            return YES;
}
//2
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}
//3
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
        return @"删除";
}
//4
//点击删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //在这里实现删除操作
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    WeakSelf
    [AFN_DF POST:@"/system/truck/delete" Parameters:@{@"truckId":dic[@"truckId"]} success:^(NSDictionary *responseObject) {
              
            [weakSelf.dataArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        if (weakSelf.dataArray.count == 0) {
            AddCarNewViewController *addVC = [AddCarNewViewController new];
            addVC.title = @"绑定车辆";
            addVC.addType = @"1";
            [weakSelf.navigationController pushViewController:addVC animated:YES];
        }
          } failure:^(NSError *error) {
              
          }];
    
    
    //删除数据，和删除动画
  
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.searchTF.isFirstResponder) {
        [self.searchTF resignFirstResponder];
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
  
    
     NSString *search =  textField.text;
    self.searArray  = [NSMutableArray array];
    for (NSDictionary *dic in self.dataArray) {
        
       NSString *dataStr = dic[@"plateNumber"];
        
        if ([dataStr  containsString:search]) {
            
            [self.searArray addObject:dic];
        }
        
        
    }
    
    
        [self.table reloadData];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
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
