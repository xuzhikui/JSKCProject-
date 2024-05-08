//
//  ComplaintController.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "ComplaintController.h"
#import "CompCell.h"
#import "AddCompController.h"
#import "compDetController.h"
@interface ComplaintController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSString *mjcode;
@property(nonatomic,strong)UIView *imageVC;

@end

@implementation ComplaintController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = YES;
   
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.imageVC = [[UIImageView alloc]initWithFrame:CGRectMake((Width - 250)/2, Height/2 - 85, 250, 170)];
      [self.view addSubview:self.imageVC];
      
      UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 250, 170)];
      backImg.image = [UIImage imageNamed:@"投诉记录占位"];
      [self.imageVC addSubview:backImg];
      self.imageVC.hidden = YES;
    
    self.view.backgroundColor = COLOR2(240);
    self.dataArray = [NSMutableArray array];
    self.title = @"我的投诉";
    self.mjcode = @"1";
 
        
  
        
        [self posData];
        
   
    
    [self setUI];
}








-(void)posData{
    
    
    
    
    [AFN_DF POST:@"/system/complaint/getAll" Parameters:@{@"pageNum":self.mjcode,@"pageSize":@"15"} success:^(NSDictionary *responseObject) {
        
        [self.table.mj_footer endRefreshing];
     
     NSArray *arr = responseObject[@"data"][@"list"];
     
     for (int i = 0; i < arr.count; i++) {
         
         [self.dataArray addObject:arr[i]];
     }
     
     
     if (arr.count < 15) {
         
          [self.table.mj_footer endRefreshingWithNoMoreData];
       
     }else{
         
          self.mjcode = [NSString stringWithFormat:@"%d",self.mjcode.intValue + 1];
         
     }
     
     

     [self.table reloadData];
     
     if (self.dataArray.count == 0) {
         
         self.imageVC.hidden = NO;
     }else{
          self.imageVC.hidden = YES;
     }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}




-(void)setUI{
    
            self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, NavaBarHeight + 10, Width, Height - 80) style:(UITableViewStylePlain)];
          self.table.delegate = self;
          self.table.dataSource = self;
          self.table.backgroundColor = [UIColor clearColor];
          [self.table registerClass:[CompCell class] forCellReuseIdentifier:@"cell"];
          self.table.separatorStyle =UITableViewCellSeparatorStyleNone;
          [self.view addSubview:self.table];
    _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{

            [self posData];
    
        
    }];
//
    
    

    UIView *tab = [[UIView alloc]initWithFrame:CGRectMake(0, Height - 60 - ScreenBottom , Width, 60)];
    tab.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tab];
    

    UIButton *endBut = [UIButton initWithFrame:CGRectMake(20, 10, Width - 40, 40) :@"我要投诉" :16*Width1];
                        endBut.layer.cornerRadius = 4;
                    endBut.layer.borderColor = [[UIColor redColor]CGColor];
                    [endBut setTitleColor:[UIColor redColor] forState:0];
                    endBut.layer.borderWidth = 1;
                [endBut addTarget:self action:@selector(addAction) forControlEvents:(UIControlEventTouchUpInside)];
               [tab addSubview:endBut];
    
    
    
}

-(void)addAction{
    
    
    AddCompController *addVC = [AddCompController new];
    [self.navigationController pushViewController:addVC animated:YES];
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
                CompCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                 cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                 cell.dic = self.dataArray[indexPath.row];
              
               
    
                return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 170;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    compDetController *compVC = [compDetController new];
    compVC.dic = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:compVC animated:YES];
    
    
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
