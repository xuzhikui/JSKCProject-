//
//  CompLlistController.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "CompLlistController.h"
#import "WaybilCell.h"

@interface CompLlistController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSString *mjCode;
@property(nonatomic,strong)UIView *imageVC;
@end

@implementation CompLlistController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = YES;
   
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = COLOR2(240);
    
    
      self.imageVC = [[UIImageView alloc]initWithFrame:CGRectMake((Width - 250)/2, Height/2 - 85, 250, 170)];
        [self.view addSubview:self.imageVC];
        
        UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 250, 170)];
        backImg.image = [UIImage imageNamed:@"暂无订单"];
        [self.imageVC addSubview:backImg];
        self.imageVC.hidden = YES;
    
    self.dataArray = [NSMutableArray array];
    self.title = @"选择运单";
    self.mjCode = @"1";
    [self postList];
    [self setUI];
}



-(void)postList{
    
    NSDictionary *dic = @{
        @"pageNum":self.mjCode,
        @"pageSize":@"15",
        @"state":@"6",
    };

    [AFN_DF POST:@"/tsmanage/waybillsettle/get" Parameters:dic success:^(NSDictionary *responseObject) {
        
        [self.table.mj_footer endRefreshing];

         NSArray *arr = responseObject[@"data"][@"list"];

         for (int i = 0; i < arr.count; i++) {

             [self.dataArray addObject:arr[i]];
         }

         if (arr.count < 15) {

              [self.table.mj_footer endRefreshingWithNoMoreData];
             
          

         }else{

              self.mjCode = [NSString stringWithFormat:@"%d",self.mjCode.intValue + 1];

         }

    if (self.dataArray.count == 0) {
         
         self.imageVC.hidden = NO;
     }else{
          self.imageVC.hidden = YES;
     }
     
        [self.table reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

//-(void)postData{
//
//
//    NSDictionary *dic = @{
//        @"localItude":[NSString stringWithFormat:@"%@,%@",[LoactionModel shareInstance].lat,[LoactionModel shareInstance].lo],
//        @"pageNum":self.mjCode,
//        @"pageSize":@"15",
//        @"state":@"6",
//    };
//
//    [AFN_DF POST:@"/tsmanage/waybill/get" Parameters:dic success:^(NSDictionary *responseObject) {
//
//
//    } failure:^(NSError *error) {
//
//    }];
//
//}



-(void)setUI{
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, NavaBarHeight + 10, Width, Height - NavaBarHeight - 10) style:(UITableViewStylePlain)];
          self.table.delegate = self;
          self.table.dataSource = self;
          self.table.backgroundColor = [UIColor clearColor];
          [self.table registerClass:[WaybilCell class] forCellReuseIdentifier:@"cell"];
          self.table.separatorStyle =UITableViewCellSeparatorStyleNone;
          [self.view addSubview:self.table];
    
            _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
             
                    [self postList];
              
                }];
  

  
    
    
}

-(void)addAction{
    
    
  
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
                    WaybilCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                    cell.backgroundColor = [UIColor whiteColor];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.dic = self.dataArray[indexPath.row];
                    cell.type  = @"comps";
                cell.endBlock = ^(NSDictionary * _Nonnull code) {
                        
                    self.block(code);
                    [self.navigationController popViewControllerAnimated:YES];
            };
                return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 223;
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
