//
//  SettlementController.m
//  JSKCProject
//
//  Created by XHJ on 2020/9/17.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "SettlementController.h"
#import "SettlementCell.h"
#import "SettlementDetController.h"
#import "SetteCommContCell.h"
#import "CommDetController.h"
@interface SettlementController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIButton *settlementBut;
@property(nonatomic,strong)UIButton *PaymentBut;
@property(nonatomic,strong)UIButton *SettledBut;
@property(nonatomic,strong)UIButton *evaluateBut;
@property(nonatomic,assign)NSInteger butCode;
@property(nonatomic,strong)UIImageView *driverButImage;
@property(nonatomic,strong)UIImageView *brokerButImage;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *distanceArray;
@property(nonatomic,strong)NSString *mjCode;
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)UIImageView *imageVC;
@property(nonatomic,strong)UIImageView *backImg;
@property(nonatomic,strong)UIView *driverTopView;
@property(nonatomic,strong)UIView *brokerTopView;
@end

@implementation SettlementController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
        [self.navigationController setNavigationBarHidden:YES animated:YES];
          self.tabBarController.tabBar.hidden = NO;
    
    if (UserModel.shareInstance.type == 1 || [NSUserDefaults.standardUserDefaults integerForKey:LoginIdentityKey] == 1) {
        self.brokerTopView.hidden = NO;
        self.driverTopView.hidden = YES;
    }else{
        self.brokerTopView.hidden = YES;
        self.driverTopView.hidden = NO;
    }

//    if ([self.postCode isEqualToString:@"1"] && [UserModel shareInstance].accessToken != nil) {
//
//        [self postData];
//        self.postCode = @"2";
//    }
//
//
//    if ([UserModel shareInstance].accessToken == nil){
//
//        [self.distanceArray removeAllObjects];
//        [self.table reloadData];
//
//        self.imageVC.hidden =NO;
//
//
//    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.distanceArray = [NSMutableArray array];
    self.butCode = 0;
    self.code = @"1";
    self.mjCode = @"1";
    [self setUI];
    if (UserModel.shareInstance.type == 2) {
        [self postData];
    }else
        self.imageVC.hidden = NO;

}

-(void)setUI{
 
    _driverTopView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 120)];
    _driverTopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.driverTopView];
    
    _brokerTopView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 120)];
    _brokerTopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.brokerTopView];
       
       [UILabel initWithDFLable:CGRectMake(22, 43 , Width, 30) :[UIFont boldSystemFontOfSize:22*Width1]:[UIColor blackColor] :
        @"结算":self.view :0];
    
    self.PaymentBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.SettledBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.evaluateBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.settlementBut = [UIButton buttonWithType:UIButtonTypeCustom];

    NSArray *datasuArray1 = nil;
    NSArray *butArray1 = nil;

    datasuArray1 = @[@"待付款",@"已结清",@"已评价"];
    butArray1 = @[_PaymentBut,_SettledBut,_evaluateBut];
    
    for (int i = 0 ; i < butArray1.count; i ++) {
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake(8 + (Width/butArray1.count * i), 80, Width/butArray1.count - 16, 30);
            [but setTitle:datasuArray1[i] forState:0];
            [self.driverTopView addSubview:but];
            but.titleLabel.font = [UIFont systemFontOfSize:14*Width1];
            [but setTitleColor:COLOR2(51) forState:0];
            but.tag = 1001 + i;
            [but addTarget:self action:@selector(butAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
            UIImageView *fg = [[UIImageView alloc]initWithFrame:CGRectMake(Width/butArray1.count * i, 85, 1, 20)];
            fg.image  = [UIImage imageNamed:@"矩形 8"];
            [self.driverTopView addSubview:fg];
    }
    
    self.driverButImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 116, Width/butArray1.count - 40, 3)];
    self.driverButImage.backgroundColor = [UIColor redColor];
    self.driverButImage.layer.cornerRadius = 1.5;
    [self.driverTopView addSubview:self.driverButImage];
    
    
    NSArray *datasuArray2 = nil;
    NSArray *butArray2 = nil;

    datasuArray2 = @[@"待付款",@"已结清",@"已评价"];
    butArray2 = @[_PaymentBut,_SettledBut,_evaluateBut];
    
    
    for (int i = 0 ; i < butArray2.count; i ++) {
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake(8 + (Width/butArray2.count * i), 80, Width/butArray2.count - 16, 30);
            [but setTitle:datasuArray2[i] forState:0];
            [self.brokerTopView addSubview:but];
            but.titleLabel.font = [UIFont systemFontOfSize:14*Width1];
            [but setTitleColor:COLOR2(51) forState:0];
            but.tag = 1001 + i;
            [but addTarget:self action:@selector(butAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
            UIImageView *fg = [[UIImageView alloc]initWithFrame:CGRectMake(Width/butArray2.count * i, 85, 1, 20)];
            fg.image  = [UIImage imageNamed:@"矩形 8"];
            [self.brokerTopView addSubview:fg];
    }
    
    self.brokerButImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 116, Width/3 - 40, 3)];
    self.brokerButImage.backgroundColor = [UIColor redColor];
    self.brokerButImage.layer.cornerRadius = 1.5;
    [self.brokerTopView addSubview:self.brokerButImage];
    
    
    if (UserModel.shareInstance.type == 1 || [NSUserDefaults.standardUserDefaults integerForKey:LoginIdentityKey] == 1) {
        self.brokerTopView.hidden = NO;
        self.driverTopView.hidden = YES;
    }else{
        self.brokerTopView.hidden = YES;
        self.driverTopView.hidden = NO;
    }

    
    self.imageVC = [[UIImageView alloc]initWithFrame:CGRectMake((Width - 250)/2, Height/2 - 85, 250, 170)];
      [self.view addSubview:self.imageVC];
      
      self.backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 250, 170)];
      self.backImg.image = [UIImage imageNamed:@"结算-待付款-空窗"];
      [self.imageVC addSubview:self.backImg];
      self.imageVC.hidden = YES;
    
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 130, Width, Height - 120) style:(UITableViewStylePlain)];
       self.table.delegate = self;
       self.table.dataSource = self;
       self.table.backgroundColor = [UIColor clearColor];
       [self.table registerClass:[SettlementCell     class] forCellReuseIdentifier:@"cell"];
        [self.table registerClass:[SetteCommContCell class] forCellReuseIdentifier:@"cellID"];
       self.table.separatorStyle =UITableViewCellSeparatorStyleNone;
       [self.view addSubview:self.table];
    self.table.userInteractionEnabled = YES;
    WeakSelf
       _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
           if (UserModel.shareInstance.type == 1) {
               [weakSelf.table.mj_footer endRefreshing];
               return;
           }
           [self postData];
           
       }];
    
    _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (UserModel.shareInstance.type == 1) {
            [weakSelf.table.mj_header endRefreshing];
            return;
        }
        self.mjCode = @"0";
        self.distanceArray =[NSMutableArray array];
        [self  postData];
    }];
    
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
   
        return self.distanceArray.count;
  
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.butCode == 3) {
        
        
                 SetteCommContCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
                      cell.backgroundColor = [UIColor whiteColor];
                 
          
                      if (indexPath.row < self.distanceArray.count) {

                              cell.dic = self.distanceArray[indexPath.row];
                      }
                      cell.selectionStyle = UITableViewCellSelectionStyleNone;

                 return cell;
        
    }else{
        
        
                 SettlementCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                      cell.backgroundColor = [UIColor whiteColor];
                 
          
                      if (indexPath.row < self.distanceArray.count) {

                              cell.dic = self.distanceArray[indexPath.row];
                          }

                          cell.code = self.code;
                      cell.selectionStyle = UITableViewCellSelectionStyleNone;

                 return cell;
        
    }
   
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.butCode == 3) {
        
        CommDetController *commvC = [CommDetController new];
        commvC.dic = self.distanceArray[indexPath.row];
        [self.navigationController pushViewController:commvC animated:YES];
        
        
        
    }else{
        
        SettlementDetController *detVC = [SettlementDetController new];
         detVC.dic = self.distanceArray[indexPath.row];
         detVC.code = self.butCode;
         [self.navigationController pushViewController:detVC animated:YES];
    }
    
  
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.butCode == 3) {
        
        NSDictionary *dic = self.distanceArray[indexPath.row];
        NSString *str = dic[@"content"];
       
        
      CGSize widSize =  [self sizeWithFont:[UIFont systemFontOfSize:14*Width1] maxWidth:Width - 80 maxStr:str];
        
        return 193 + widSize.height;
        
        
       
        
    }else{
        return 223;
        
        
    }
   
}



-(void)postData{
    
 
    if ([UserModel shareInstance].accessToken == nil) {
        
        return;
    }
    
    NSDictionary *dic = @{
        @"pageNum":self.mjCode,
        @"pageSize":@"15",
        @"state":self.code,
    };

    [AFN_DF POST:@"/tsmanage/waybillsettle/get" Parameters:dic success:^(NSDictionary *responseObject) {
        
                [self.table.mj_footer endRefreshing];
                [self.table.mj_header endRefreshing];
                 NSArray *arr = responseObject[@"data"][@"list"];
        
                 for (int i = 0; i < arr.count; i++) {
        
                     [self.distanceArray addObject:arr[i]];
                 }
        
                 if (arr.count < 15) {
        
                      [self.table.mj_footer endRefreshingWithNoMoreData];
                     
                  
        
                 }else{
        
                      self.mjCode = [NSString stringWithFormat:@"%d",self.mjCode.intValue + 1];
        
                 }
        
      
         
        if (self.distanceArray.count == 0) {
            
            self.imageVC.hidden = NO;
            
            if (self.butCode == 0) {
                
                self.backImg.image = [UIImage imageNamed:@"结算-待付款-空窗"];
            }else if (self.butCode == 1){
                self.backImg.image = [UIImage imageNamed:@"结算-结算中-空窗"];
                
            }else if (self.butCode == 2){
                
                self.backImg.image = [UIImage imageNamed:@"结算-已结清-空"];
            }else if (self.butCode == 3){
                
                self.backImg.image = [UIImage imageNamed:@"结算-已评价-空"];
            }
            
            
            
            
        }else{
             self.imageVC.hidden = YES;
        }
                [self.table reloadData];
        
       
        
        
    } failure:^(NSError *error) {
        
    }];
    
}










-(void)butAction:(UIButton *)but{
    self.mjCode = @"0";
    self.distanceArray = [NSMutableArray array];
    if (UserModel.shareInstance.type == 1) {
        self.brokerButImage.frame = CGRectMake(Width/3*(but.tag - 1001) + 20, 116, Width/3 - 40, 3);
    }else
        self.driverButImage.frame = CGRectMake(Width/3*(but.tag - 1001) + 20, 116, Width/3 - 40, 3);
     
    if (UserModel.shareInstance.type == 1) {
        return;
    }
    
    if (but.tag == 1000) {
        self.butCode = 0;
        self.code = @"1";
    }else if(but.tag == 1001){
          self.butCode = 1;
        self.code = @"2";
    }else if(but.tag == 1002){
          self.butCode = 2;
        self.code = @"3";
    }else if(but.tag == 1003){
          self.butCode = 3;
        self.code = @"4";
    }
    
    [self postData];
    
    
    
}



- (UIImage *)imageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0, 0, 1, 1);

    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);

    [color setFill];

    UIRectFill(rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return image;

}

- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth maxStr:(NSString *)maxStr
{
    // 获取文字样式
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    
    // 根据文字样式计算文字所占大小
    // 文本最大宽度
    CGSize maxSize = CGSizeMake(Width - 70, 60);
    
    // NSStringDrawingUsesLineFragmentOrigin -> 从头开始
    
    
    
    return [maxStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


//- (CGSize)sizeWithFont:(UIFont *)font
//{
//    return [self sizeWithFont:font maxWidth:Width - 60];
//}
@end
