//
//  MeassListController.m
//  JSKCProject
//
//  Created by 孟德峰 on 2021/2/3.
//  Copyright © 2021 孟德峰. All rights reserved.
//

#import "MeassListController.h"
#import "MeassListCell.h"
#import "MeassDetController.h"
@interface MeassListController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIButton *allBut;
@property(nonatomic,strong)NSString *mjCode;
@property(nonatomic,strong)UILabel *tipLab;
@end

@implementation MeassListController



-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = YES;
   

    [self postNUmmeass];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.mjCode = @"1";
    self.dataArray = [NSMutableArray array];
    self.title = @"我的消息";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
//    [self postData];
}





-(void)setUI{
    
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, NavaBarHeight, Width, 40)];
    back.backgroundColor = COLOR2(240);
    [self.view addSubview:back];
    
   self.tipLab = [UILabel initWithDFLable:CGRectMake(10, 10, 120, 20) :[UIFont systemFontOfSize:11*Width1] :COLOR2(119) :@"未读消息0条" :back :0];
    
    
    self.allBut = [UIButton initWithFrame:CGRectMake(Width - 80, 10, 70, 20) :@"全部已读" :11*Width1];
    [self.allBut setTitleColor:[UIColor redColor] forState:0];
    [back addSubview:self.allBut];
    self.allBut.layer.cornerRadius = 4;
    self.allBut.layer.masksToBounds = YES;
    [self.allBut addTarget:self action:@selector(allButAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.allBut.layer.borderWidth = 1;
    self.allBut.layer.borderColor = [[UIColor redColor]CGColor];
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, NavaBarHeight + 40, Width, Height) style:(UITableViewStylePlain)];
    self.table.dataSource = self;
    self.table.delegate = self;
    [self.table registerClass:[MeassListCell class] forCellReuseIdentifier:@"cell"];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        [self postData];
        
    }];
    
    _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.mjCode = @"1";
        self.dataArray =[NSMutableArray array];
        [self  postData];
    }];

    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MeassListCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor whiteColor];
    cell.dic = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 76;
}


-(void)postData{
    
    [AFN_DF POST:@"/system/mess/getAll" Parameters:@{@"pageNum":self.mjCode,@"pageSize":@"10"} success:^(NSDictionary *responseObject) {
        
        
        NSArray *arr = responseObject[@"data"][@"allMess"][@"list"];
     
        for (int i = 0; i < arr.count; i++) {
            
            [self.dataArray addObject:arr[i]];
        }
        
        
        if (arr.count < 15) {
            [self.table.mj_header endRefreshing];
            [self.table.mj_footer endRefreshing];
             [self.table.mj_footer endRefreshingWithNoMoreData];
//
        }else{
            
             self.mjCode = [NSString stringWithFormat:@"%d",self.mjCode.intValue + 1];
                [self.table.mj_header endRefreshing];
                [self.table.mj_footer endRefreshing];
        }
        
        
        
            [self.table reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MeassDetController *detvc = [MeassDetController new];
    detvc.dic = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:detvc animated:YES];
    
}


-(void)allButAction{
    
    
    
    [AFN_DF POST:@"/system/mess/allRead" Parameters:nil success:^(NSDictionary *responseObject) {
        
        UITabBarController *tabBarVC = self.tabBarController;
            //获取指定item
            UITabBarItem *item = [[[tabBarVC tabBar] items] objectAtIndex:3];
            //设置item角标数
            item.badgeValue=nil;
          
        self.mjCode = @"1";
        [self.dataArray removeAllObjects];
        
        [self postData];
        
        
    } failure:^(NSError *error) {
        
    }];
}


-(void)postNUmmeass{
    
    
    [AFN_DF POST:@"/system/mess/getUnreadCount" Parameters:nil success:^(NSDictionary *responseObject) {
        
        NSLog(@"%@",responseObject);
        
        
        NSString *tag = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"unread"]];
        
        self.tipLab.text = [NSString stringWithFormat:@"未读消息%@条",tag];
        
        UITabBarController *tabBarVC = self.tabBarController;
            //获取指定item
            UITabBarItem *item = [[[tabBarVC tabBar] items] objectAtIndex:3];
            //设置item角标数字
        if ([tag isEqualToString:@"0"]) {
            item.badgeValue=nil;
        }else{
            
            item.badgeValue=tag;
        }
           
        self.mjCode = @"1";
        [self.dataArray removeAllObjects];
        [self postData];
        
        
        
        
        
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
