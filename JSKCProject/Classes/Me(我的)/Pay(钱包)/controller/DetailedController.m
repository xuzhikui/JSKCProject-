//
//  DetailedController.m
//  JSKCProject
//
//  Created by 孟德峰 on 2020/12/29.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "DetailedController.h"
#import "DetledCell.h"
#import "SWCenterDatePickerView.h"
#import "DetledTwoCell.h"
@interface DetailedController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSString *timeStr;
@property(nonatomic,strong)NSString *mjCode;
@property(nonatomic,strong)UIButton *timeBut;
@property(nonatomic,strong)UILabel *srLab;
@property(nonatomic,strong)UILabel *txLab;
@end

@implementation DetailedController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.mjCode = @"1";
    
    self.timeStr = [self getDateYearMonth];
    
   
    self.title = @"交易明细";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self postData];
    [self postheadData];
    [self setUI];
}


-(void)postheadData{
    
    [AFN_DF POST:@"/system/wallet/tradeDetailsHead" Parameters:@{@"month":self.timeStr} success:^(NSDictionary *responseObject) {
        
       
        NSDictionary *dic = responseObject[@"data"];
        self.srLab.text = [NSString stringWithFormat:@"收入¥%@",dic[@"allProfit"]];
        self.txLab.text = [NSString stringWithFormat:@"提现¥%@",dic[@"allWithdrawal"]];
        
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}
-(void)postData{
    
    
    NSDictionary  *dic = @{
        @"month":self.timeStr,
        @"pageNum":self.mjCode,
        @"pageSize":@"15",
        
        
    };
    
    [AFN_DF POST:@"/system/wallet/tradeDetails" Parameters:dic success:^(NSDictionary *responseObject) {
        
//        self.dataArray = responseObject[@"data"][@"list"];
        NSArray *arr =responseObject[@"data"][@"list"];

        for (int i = 0; i < arr.count; i++) {

            [self.dataArray addObject:arr[i]];
        }

        if (arr.count < 15) {
             
             [self.table.mj_footer endRefreshingWithNoMoreData];

        }else{

             self.mjCode = [NSString stringWithFormat:@"%d",self.mjCode.intValue + 1];
            [self.table.mj_footer endRefreshing];

        }

       [self.table reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)setUI{
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStyleDone) target:self action:@selector(back)];
    
    
    UIView *navVC = [[UIView alloc]initWithFrame:CGRectMake(0, NavaBarHeight, Width, 50)];
    navVC.backgroundColor = COLOR2(240);
    [self.view addSubview:navVC];
    
    self.timeBut = [UIButton initWithFrame:CGRectMake(20, 12.5, 80, 25) :[self getDateYearMonth] :11*Width1];
    [_timeBut setTitleColor:[UIColor blackColor] forState:0];
    _timeBut.backgroundColor = [UIColor whiteColor];
    _timeBut.layer.cornerRadius = 12.5;
    [_timeBut addTarget:self action:@selector(timeAction) forControlEvents:(UIControlEventTouchUpInside)];
    [navVC addSubview:_timeBut];
    
   self.srLab = [UILabel initWithDFLable:CGRectMake(Width - 150, 10, 140, 15) :[UIFont systemFontOfSize:11*Width1] :COLOR2(153) :@"收入¥0" :navVC :2];
    
   self.txLab = [UILabel initWithDFLable:CGRectMake(Width - 150, 25, 140, 15) :[UIFont systemFontOfSize:11*Width1] :COLOR2(153) :@"提现¥0" :navVC :2];
    
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, NavaBarHeight + 50, Width, Height - NavaBarHeight - 50) style:(UITableViewStylePlain)];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[DetledCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.table];
    self.table.backgroundColor = COLOR2(240);
    self.table.scrollEnabled = NO;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.table registerClass:[DetledTwoCell class] forCellReuseIdentifier:@"cellID"];
    _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        [self postData];
        
    }];
    
}


-(void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    NSString *type = [NSString stringWithFormat:@"%@",dic[@"type"]];
    if ([type isEqualToString:@"0"]) {
        DetledCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor =[UIColor whiteColor];
        cell.dic = self.dataArray[indexPath.row];
        return cell;
    }else{
        
        DetledTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor =[UIColor whiteColor];
        cell.dic = self.dataArray[indexPath.row];
        return cell;
        
    }
    
    
    

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 101;
}


-(void)timeAction{
    
    SWCenterDatePickerView *view = [[SWCenterDatePickerView alloc] initDatePickerViewWithType:DatePickerViewType_YM Delegate:self];
//    view.currentTime = self.selectDateStr;
    
    [view showDatePickerView];
    
}

- (void)selectWithSelectTime:(NSString *)selectTime withYear:(NSString *)year withMonth:(NSString *)month{
    
    [self.dataArray removeAllObjects];
    self.timeStr = [NSString stringWithFormat:@"%@-%@",year,month];
    [self.timeBut setTitle:self.timeStr forState:0];
    [self postData];
    [self postheadData];
    
    
    
}

- (NSString *)getDateYearMonth {

    

    NSDate *newDate = [NSDate date];

    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;

    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:newDate];

    NSInteger year = [dateComponent year];

    NSInteger month = [dateComponent month];

    
    NSString *code = [NSString stringWithFormat:@"%ld",month];
    if (month < 10) {
        code = [NSString stringWithFormat:@"0%ld",month];
        
    }
    
    
    return [NSString stringWithFormat:@"%ld-%@",year,code];

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
