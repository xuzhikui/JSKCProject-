//
//  WaybilController.m
//  JSKCProject
//
//  Created by XHJ on 2020/9/17.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "WaybilController.h"
#import "WaybilCell.h"
#import "WayDetController.h"
#import "EndINWayView.h"
@interface WaybilController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *butArray;
}
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *distanceArray;
@property(nonatomic,strong)NSString *mjCode;
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *postCode;
@property(nonatomic,strong)UIButton *waitForBut;///待发货
@property(nonatomic,strong)UIButton *transportBut;///运输中
@property(nonatomic,strong)UIButton *endBut;///已完成
@property(nonatomic,strong)UIButton *canlBut;///已取消
@property(nonatomic,strong)UIImageView *butImage;
@property(nonatomic,assign)NSInteger butCode;
@property(nonatomic,strong)UIView *kcVC;
@property(nonatomic,strong)UIView *imageVC;

@end

@implementation WaybilController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
          self.tabBarController.tabBar.hidden = NO;
    if ([self.postCode isEqualToString:@"1"] && [UserModel shareInstance].accessToken != nil) {
        
        [self postData];
        self.postCode = @"2";
    }
    
    
    if ([UserModel shareInstance].accessToken == nil){
        
        [self.distanceArray removeAllObjects];
        [self.table reloadData];
        
        self.imageVC.hidden =NO;
        
        
    }
    
    if (UserModel.shareInstance.type == 1) {
        [self.distanceArray removeAllObjects];
        self.imageVC.hidden = NO;
        [self.table reloadData];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_switchTitle) name:@"EndSendWayNotification" object:nil];
    self.butCode = 0;
    self.code = @"3";
    self.mjCode = @"0";
    self.postCode = @"1";
    self.distanceArray = [NSMutableArray array];
   
    

    [self setUI];
    
}

-(void)setUI{
    
   
    
    
    
//                [backImg  addGestureRecognizer:TapGR];
    
    
    
    UIView *backVC = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 120)];
       backVC.backgroundColor = [UIColor whiteColor];
       [self.view addSubview:backVC];
       
       [UILabel initWithDFLable:CGRectMake(22, 43 , Width, 30) :[UIFont boldSystemFontOfSize:22*Width1]:[UIColor blackColor] :
        @"运单":self.view :0];
    
    self.waitForBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.transportBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.endBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.canlBut = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    NSArray *datasuArray = @[@"待发货",@"运输中",@"已完成",@"已取消"];
    
    
    butArray = @[_waitForBut,_transportBut,_endBut,_canlBut];
    
    for (int i = 0 ; i < 4; i ++) {
        
        UIButton *but = butArray[i];
            but.frame = CGRectMake(8 + (Width/4 * i), 80, Width/4 - 16, 30);
            [but setTitle:datasuArray[i] forState:0];
            [backVC addSubview:but];
            but.titleLabel.font = [UIFont systemFontOfSize:14*Width1];
            [but setTitleColor:COLOR2(51) forState:0];
            but.tag = 1000 + i;
            [but addTarget:self action:@selector(butAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
            UIImageView *fg = [[UIImageView alloc]initWithFrame:CGRectMake(Width/4 * i, 85, 1, 20)];
            fg.image  = [UIImage imageNamed:@"矩形 8"];
            [backVC addSubview:fg];
           
    }
    
        self.butImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 116, Width/4 - 40, 3)];
        self.butImage.backgroundColor = [UIColor redColor];
        self.butImage.layer.cornerRadius = 1.5;
        [backVC addSubview:self.butImage];
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 130, Width, Height - 130-TabBarHeight) style:(UITableViewStylePlain)];
       self.table.delegate = self;
       self.table.dataSource = self;
       self.table.backgroundColor = [UIColor clearColor];
       [self.table registerClass:[WaybilCell class] forCellReuseIdentifier:@"cell"];
       self.table.separatorStyle =UITableViewCellSeparatorStyleNone;
       [self.view addSubview:self.table];
    self.table.userInteractionEnabled = NO;
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
    
    self.imageVC = [[UIImageView alloc]initWithFrame:CGRectMake((Width - 250)/2, Height/2 - 100, 250, 220)];
        [self.view addSubview:self.imageVC];
          self.imageVC.userInteractionEnabled = YES;
    

    
        UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 250, 170)];
        backImg.image = [UIImage imageNamed:@"暂无运单数据"];
        [self.imageVC addSubview:backImg];
      
        self.imageVC.hidden =NO;
    UIButton *xzBut = [UIButton initWithFrame:CGRectMake(70, 180, 110, 30) :@"找货源" :14*Width1];
 xzBut.backgroundColor = [UIColor whiteColor];
 [xzBut setTitleColor:COLOR(245, 12, 12) forState:0];
 xzBut.layer.cornerRadius = 4;
 xzBut.layer.borderWidth = 1;
 [xzBut addTarget:self action:@selector(onTapGR) forControlEvents:(UIControlEventTouchUpInside)];
 xzBut.layer.borderColor = [COLOR(245, 12, 12) CGColor];
 [self.imageVC addSubview:xzBut];
 
 
 UITapGestureRecognizer *TapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapGR)];
          backImg.userInteractionEnabled = YES;
           [backImg addGestureRecognizer:TapGR];
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
   
        return self.distanceArray.count;
  
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
            WaybilCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                cell.backgroundColor = [UIColor whiteColor];
           
    
                if (indexPath.row < self.distanceArray.count) {

                    cell.dic = self.distanceArray[indexPath.row];
                    }

                cell.code = self.code;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.removeBlock = ^(NSDictionary * _Nonnull code) {
                    ///删除运单
                        [self postDelegate:code];
                   
                    };
            cell.endBlock = ^(NSDictionary * _Nonnull code) {
              //确认到达
                self.tabBarController.tabBar.hidden = YES;
                [self endblock:code:indexPath.row];
              
                };
    cell.block = ^(NSDictionary * _Nonnull code) {
        ///确认发货
        if (indexPath.row >= 0 && indexPath.row < self.distanceArray.count) {
            [self.distanceArray removeObjectAtIndex:indexPath.row];
        }
        [self.table reloadData];
        [self butAction:self->_transportBut];

    };
    
   
        
           return cell;
   
}

-(void)endblock:(NSDictionary *)code :(NSInteger )index{
    

    [[AFN_DF topViewController].navigationController setNavigationBarHidden:YES animated:YES];
               EndINWayView *inVC = [[EndINWayView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
               inVC.vc = self;
               inVC.dic = code;
                inVC.codes = @"1";
           inVC.block = ^(NSDictionary * _Nonnull dic) {
                [self.view addSubview: [Toast makeText:@"操作成功"]];
                            
                            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
                                dict[@"state"] = @"5";
                            
                            [self.distanceArray removeObject:dic];
                            [self.distanceArray insertObject:dict atIndex:index];
                            [self.table reloadData];
               
               [[AFN_DF topViewController].navigationController setNavigationBarHidden:YES animated:YES];
           };
    
   
               [self.view addSubview:inVC];
    
    

}

 ///删除运单
-(void)postDelegate:(NSDictionary *)code{
    
    
    [AFN_DF POST:@"/tsmanage/waybill/delete" Parameters:@{@"waybillId":code[@"waybillId"]} success:^(NSDictionary *responseObject) {
        
            [self.view addSubview:[Toast makeText:@"删除成功"]];
            [self.distanceArray removeObject:code];
            [self.table reloadData];
           
        
    } failure:^(NSError *error) {
        
    }];
    
  
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
       return 223;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//  [self.navigationController setNavigationBarHidden:NO animated:YES];
    WayDetController *detVC = [WayDetController new];
    detVC.dic = self.distanceArray[indexPath.row];
    detVC.code = self.butCode;
    WeakSelf
    detVC.block = ^(NSDictionary * _Nonnull dic, BOOL isCancel) {

        [AFN_DF topViewController].tabBarController.tabBar.hidden = NO;
        [[AFN_DF topViewController].navigationController setNavigationBarHidden:YES animated:YES];
        [weakSelf.view addSubview: [Toast makeText:@"操作成功"]];
        
       
        if (self.butCode  == 0) {
         
                   [weakSelf.distanceArray removeObject:dic];
                
            if (self.distanceArray.count == 0) {
                 self.table.userInteractionEnabled = YES;
                  self.imageVC.hidden = NO;
                
            }else{
                  self.imageVC.hidden = YES;
                self.table.userInteractionEnabled = YES;
            }
        }else{
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
                       dict[@"state"] = @"5";
                   
                   
        }
        
        [weakSelf.table reloadData];
        if (!isCancel) {
            [weakSelf butAction:self->_transportBut];
        }
    };
    
    detVC.delectblock = ^(NSDictionary * _Nonnull dic, BOOL isCancel) {
        [weakSelf.view addSubview:[Toast makeText:@"删除成功"]];
         [weakSelf.distanceArray removeObject:dic];
        [weakSelf.table reloadData];
        
    };
    
    [self.navigationController pushViewController:detVC animated:YES];
    
//        SourceGoodController *sourceVC = [SourceGoodController new];
//        sourceVC.dic = self.dataArray[indexPath.row];
//        [self.navigationController pushViewController:sourceVC animated:YES];
        

}

-(void)postData{
    
 
    if ([UserModel shareInstance].accessToken == nil) {
        
        return;
    }
    if ([UserModel shareInstance].type == 1) {
        
        return;
    }
    
    NSDictionary *dic = @{
        @"localItude":[NSString stringWithFormat:@"%@,%@",[LoactionModel shareInstance].lat,[LoactionModel shareInstance].lo],
        @"pageNum":self.mjCode,
        @"pageSize":@"15",
        @"state":self.code,
    };

    [AFN_DF POST:@"/tsmanage/waybill/get" Parameters:dic success:^(NSDictionary *responseObject) {
        
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
        
      
         
        
                [self.table reloadData];
        
        if (self.distanceArray.count == 0) {
             self.table.userInteractionEnabled = YES;
              self.imageVC.hidden = NO;
            
        }else{
              self.imageVC.hidden = YES;
            self.table.userInteractionEnabled = YES;
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


-(void)butAction:(UIButton *)but{
    
    self.mjCode = @"0";
    self.distanceArray = [NSMutableArray array];
    self.butImage.frame = CGRectMake(Width/4*(but.tag - 1000) + 20, 116, Width/4 - 40, 3);
     
    if (but.tag == 1000) {
        self.butCode = 0;
        self.code = @"3";
    }else if(but.tag == 1001){
          self.butCode = 1;
        self.code = @"4";
    }else if(but.tag == 1002){
          self.butCode = 2;
        self.code = @"6";
    }else if(but.tag == 1003){
          self.butCode = 3;
        self.code = @"7";
    }
    
    [self postData];
    
    
    
}


-(void)onTapGR{
    
    
    self.tabBarController.selectedIndex = 0;
    
    
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

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)_switchTitle{
    [self butAction:_waitForBut];
}

@end
