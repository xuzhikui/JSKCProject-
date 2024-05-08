//
//  SuppMoenyController.m
//  JSKCProject
//
//  Created by 孟德峰 on 2020/12/29.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "SuppMoenyController.h"
#import "SuppMoneyCell.h"
#import "EndSuppController.h"
@interface SuppMoenyController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)NSString *mjCode;
@property(nonatomic,strong)NSMutableArray *selectArray;
@property(nonatomic,strong)UILabel *payLab;
@property(nonatomic,assign)CGFloat  totalAmount;

@end

@implementation SuppMoenyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mjCode = @"1";
    self.totalAmount = 0.0;
    self.dataArray = [NSMutableArray array];
    self.title = @"余额提现";
    self.view.backgroundColor = [UIColor whiteColor];
    self.selectArray = [NSMutableArray array];
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, NavaBarHeight + 80, Width, Height - NavaBarHeight - 160) style:(UITableViewStylePlain)];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[SuppMoneyCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.table];
    self.table.backgroundColor = COLOR2(240);
    self.table.scrollEnabled = NO;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        [self postData];
        
    }];
    
   
   
}


///提现
-(void)suppAction{
    
   
    
    if (self.selectArray.count == 0) {
        
        return [self.view addSubview:[Toast makeText:@"请选择提现订单"]];
    }

    NSString *wayStr = @"";
    
    for (int i = 0 ; i < self.selectArray.count; i++) {
        
        if (i == 0) {
            
            wayStr  = self.selectArray[i][@"waybillId"];
            
        }else{
            
            wayStr = [NSString stringWithFormat:@"%@,%@",wayStr,self.selectArray[i][@"waybillId"]];
        }
        
        
    }
    
    
    
     NSDictionary *dic = @{
        @"amount":[NSString stringWithFormat:@"%.2f",self.totalAmount],
        @"waybillIds":wayStr,
    };
    
    
    [AFN_DF POST:@"/system/wallet/withdrawal" Parameters:dic success:^(NSDictionary *responseObject) {
        
        
        EndSuppController *endVC = [EndSuppController new];
        endVC.dic = responseObject[@"data"];
        [self.navigationController pushViewController:endVC animated:YES];
        
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

///全选
-(void)selectAllAction{
    
    /*
     cell.addBlock = ^(NSDictionary * _Nonnull dic) {
         [self.selectArray addObject:dic];
         NSString *code = dic[@"withdrawalAmount"];
         self.totalAmount = self.totalAmount + code.floatValue;
         self.payLab.text = [NSString stringWithFormat:@"¥%.2f",self.totalAmount];
     };
     cell.removeBlock = ^(NSDictionary * _Nonnull dic) {
         [self.selectArray removeObject:dic];
         NSString *code = dic[@"withdrawalAmount"];
         self.totalAmount = self.totalAmount - code.floatValue;
         self.payLab.text = [NSString stringWithFormat:@"¥%.2f",self.totalAmount];
         
     };
     */
    CGFloat  totalAmount = self.totalAmount;

    if (self.selectArray.count == self.dataArray.count) {
        for (int i = 0 ; i < self.dataArray.count; i++) {
            id item = self.dataArray[i];
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:item];
            [params setValue:@(NO) forKey:@"selected"];
            [self.dataArray replaceObjectAtIndex:i withObject:params];
        }
        [self.selectArray removeAllObjects];
        totalAmount = 0.0f;
    }else{
        
        for (int i = 0 ; i < self.dataArray.count; i++) {
            id item = self.dataArray[i];
            NSInteger wid = [item[@"id"] integerValue];
            BOOL Exit = NO;
            for (id selectedItem in self.selectArray) {
                if ([selectedItem[@"id"] integerValue] == wid) {
                    Exit = YES;
                    break;
                }
            }
            
            if (!Exit) {
                NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:item];
                [params setValue:@(YES) forKey:@"selected"];
                [self.dataArray replaceObjectAtIndex:i withObject:params];
                [self.selectArray addObject:params];
                NSString *code = params[@"withdrawalAmount"];
                totalAmount = totalAmount + code.floatValue;
            }
        }
    }

    [self.table reloadData];
    self.totalAmount = totalAmount;
    self.payLab.text = [NSString stringWithFormat:@"¥%.2f",self.totalAmount];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = YES;
        [self postData];
}

-(void)postData{
    
    [AFN_DF POST:@"/system/wallet/withdrawalList" Parameters:@{@"pageNum":self.mjCode,@"pageSize":@"15"} success:^(NSDictionary *responseObject) {
                 
       
        self.dic  = responseObject[@"data"];
      
         NSArray *arr = responseObject[@"data"][@"pageInfo"][@"list"];

         for (int i = 0; i < arr.count; i++) {
             NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:arr[i]];
             [params setValue:@(i+1) forKey:@"id"];
             [params setValue:@(NO) forKey:@"selected"];
             [self.dataArray addObject:params];
         }

         if (arr.count < 15) {
              
              [self.table.mj_footer endRefreshingWithNoMoreData];

         }else{

              self.mjCode = [NSString stringWithFormat:@"%d",self.mjCode.intValue + 1];
             [self.table.mj_footer endRefreshing];

         }

        [self.table reloadData];
        
        
            [self setUI];
        
      
        
    } failure:^(NSError *error) {
            
        
    }];
    
}

-(void)setUI{
    
    self.mjCode = @"1";
    UIView *backVC = [[UIView alloc]initWithFrame:CGRectMake(0, NavaBarHeight, Width, 80)];
    backVC.backgroundColor = COLOR2(240);
    [self.view addSubview:backVC];
    
    [UILabel initWithDFLable:CGRectMake(20, 20, 80, 20) :[UIFont systemFontOfSize:14*Width1] :[UIColor blackColor] :@"到账银行卡" :backVC :0];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(100, 20, 20, 20)];
    [img sd_setImageWithURL:[NSURL URLWithString:self.dic[@"logo"]]];
//    img.backgroundColor =[UIColor yellowColor];
    [backVC addSubview:img];
    
    [UILabel initWithDFLable:CGRectMake(125, 20,Width - 160, 20) :[UIFont systemFontOfSize:14] :[UIColor blackColor] :[NSString stringWithFormat:@"到账银行卡(%@)",self.dic[@"bankCardNum"]] :backVC :0];
    
    
    [UILabel initWithDFLable:CGRectMake(125, 45,Width - 160, 20) :[UIFont systemFontOfSize:14] :[UIColor blackColor] :@"2小时内到账" :backVC :0];

    
    UIView *tabvc = [[UIView alloc]initWithFrame:CGRectMake(0, Height - 80, Width, 80)];
    tabvc.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabvc];
    
    
    CGFloat  totalAmount = 0.0;
    
    for (int i = 0 ; i < self.dataArray.count; i++) {
        
        NSDictionary *dic = self.dataArray[i];
        NSString *code = dic[@"withdrawalAmount"];
        totalAmount = totalAmount + code.floatValue;

    }
    
    
    
    [UILabel initWithDFLable:CGRectMake(20, 5, 100, 15) :[UIFont systemFontOfSize:12*Width1] :[UIColor blackColor] :@"提现金额" :tabvc :0];
    
  self.payLab = [UILabel initWithDFLable:CGRectMake(20, 30, 100, 20) :[UIFont systemFontOfSize:20*Width1] :[UIColor orangeColor] :@"¥0.00" :tabvc :0];
    
    [UILabel initWithDFLable:CGRectMake(20, 55, 140, 15) :[UIFont systemFontOfSize:12*Width1] :[UIColor blackColor] :[NSString stringWithFormat:@"可以提现余额¥%.2f",totalAmount] :tabvc :0];
    
    
    UIButton *suppBut = [UIButton initWithFrame:CGRectMake(Width - 100, 25, 80,30 ) :@"提现" :15*Width1];
    suppBut.layer.cornerRadius = 4;
    [suppBut addTarget:self action:@selector(suppAction) forControlEvents:(UIControlEventTouchUpInside)];
    suppBut.backgroundColor = [UIColor redColor];
    [tabvc addSubview:suppBut];
    
    
    UIButton *allBut = [UIButton initWithFrame:CGRectMake(140, 50, 140, 25) :@"全选当前运单" :13*Width1];
    [allBut setTitleColor:[UIColor orangeColor] forState:0];
    [allBut addTarget:self action:@selector(selectAllAction) forControlEvents:(UIControlEventTouchUpInside)];
    [tabvc addSubview:allBut];
    
    
   
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SuppMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor =[UIColor whiteColor];
    cell.dic = self.dataArray[indexPath.row];
    cell.indexPath = indexPath;
    WeakSelf
    cell.addBlock = ^(NSIndexPath *indexPath) {
        NSDictionary *dic = weakSelf.dataArray[indexPath.row];
        NSInteger wid = [dic[@"id"] integerValue];
        BOOL Exit = NO;
        for (id item in weakSelf.selectArray) {
            if ([item[@"id"] integerValue] == wid) {
                Exit = YES;
                break;
            }
        }
        if (!Exit) {
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
            [params setValue:@(YES) forKey:@"selected"];
            [weakSelf.selectArray addObject:params];
            [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:params];
            NSString *code = params[@"withdrawalAmount"];
            weakSelf.totalAmount = self.totalAmount + code.floatValue;
            weakSelf.payLab.text = [NSString stringWithFormat:@"¥%.2f",weakSelf.totalAmount];
            [weakSelf.table beginUpdates];
            [weakSelf.table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [weakSelf.table endUpdates];
        }
    };
    cell.removeBlock = ^(NSIndexPath *indexPath) {
        NSDictionary *dic = weakSelf.dataArray[indexPath.row];
        NSInteger wid = [dic[@"id"] integerValue];
        NSInteger index = -1;
        for (id item in weakSelf.selectArray) {
            if ([item[@"id"] integerValue] == wid) {
                index = [weakSelf.selectArray indexOfObject:item];
                break;
            }
        }
        if (index != -1) {
            [weakSelf.selectArray removeObjectAtIndex:index];
            NSString *code = dic[@"withdrawalAmount"];
            weakSelf.totalAmount = weakSelf.totalAmount - code.floatValue;
            weakSelf.payLab.text = [NSString stringWithFormat:@"¥%.2f",weakSelf.totalAmount];
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
        [params setValue:@(NO) forKey:@"selected"];
        [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:params];
        [weakSelf.table beginUpdates];
        [weakSelf.table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [weakSelf.table endUpdates];
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 81;
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
