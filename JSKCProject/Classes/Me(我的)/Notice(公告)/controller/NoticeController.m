//
//  NoticeController.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "NoticeController.h"
#import "NoticeCell.h"
@interface NoticeController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIButton *oneBut;
@property(nonatomic,strong)UIButton *twoBut;
@property(nonatomic,strong)NSString *code;
@end

@implementation NoticeController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = YES;
   

    
}



- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.code = @"1";
    self.title = @"法律条款和公告";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self postData];
    
    
}

-(void)postData{
    
    
    [AFN_DF POST:@"/system/lawandnotice/getLawOrNotice" Parameters:@{@"type":self.code} success:^(NSDictionary *responseObject) {
        
        self.dataArray = responseObject[@"data"];
        
        [self.table reloadData];
        
        if (52 * self.dataArray.count >= Height - NavaBarHeight - 70) {
            
             self.table.frame = CGRectMake(10, NavaBarHeight + 70, Width - 20, Height -  NavaBarHeight - 70);
        }else{
            
             self.table.frame = CGRectMake(10, NavaBarHeight + 70, Width - 20, 52 *self.dataArray.count);
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

-(void)setUI{
    
    
     UIView *pageVC =[[UIView alloc]initWithFrame:CGRectMake((Width - 210)/2,NavaBarHeight + 30, 210,30)];
           pageVC.backgroundColor = [UIColor whiteColor];
           pageVC.layer.cornerRadius = 4;
           pageVC.layer.masksToBounds = YES;
            pageVC.layer.borderWidth = 1;
            pageVC.layer.borderColor = [[UIColor redColor]CGColor];
            [self.view addSubview:pageVC];
           
           
    _oneBut = [UIButton initWithFrame:CGRectMake(0, 0, pageVC.frame.size.width/2, 30) :@"法律条款" :15*Width1];
         _oneBut.backgroundColor = COLOR(245, 12, 12);
           [_oneBut addTarget:self action:@selector(oneButAction) forControlEvents:(UIControlEventTouchUpInside)];
           [_oneBut setTitleColor:[UIColor whiteColor] forState:0];
           [pageVC addSubview:_oneBut];
           
           _twoBut = [UIButton initWithFrame:CGRectMake(pageVC.frame.size.width/2, 0, pageVC.frame.size.width/2, 30) :@"公告通知" :15*Width1];
            _twoBut.backgroundColor = [UIColor whiteColor];
           [_twoBut addTarget:self action:@selector(twoButAction) forControlEvents:(UIControlEventTouchUpInside)];
              [_twoBut setTitleColor:[UIColor redColor] forState:0];
              [pageVC addSubview:_twoBut];
    
    
    
    [self addListView];
    
    
    
    
    
    
}

-(void)oneButAction{
    
    self.code = @"1";
    
    self.oneBut.backgroundColor = COLOR(245, 12, 12);
      [_oneBut setTitleColor:[UIColor whiteColor] forState:0];
    
    self.twoBut.backgroundColor = [UIColor whiteColor];
     [_twoBut setTitleColor:[UIColor redColor] forState:0];
    
    
    [self postData];
    
}

-(void)twoButAction{
    
    self.code =@"2";
    
    self.twoBut.backgroundColor = COLOR(245, 12, 12);
      [_twoBut setTitleColor:[UIColor whiteColor] forState:0];
    
    self.oneBut.backgroundColor = [UIColor whiteColor];
     [_oneBut setTitleColor:[UIColor redColor] forState:0];
    
    [self postData ];
}


-(void)addListView{
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, NavaBarHeight + 70, Width , Height -NavaBarHeight - 143) style:(UITableViewStylePlain)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor =COLOR2(240);
    [self.table registerClass:[NoticeCell class] forCellReuseIdentifier:@"cell"];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.dic = self.dataArray[indexPath.row];
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 52;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    WKController *wkVC = [WKController new];
    wkVC.urls = self.dataArray[indexPath.row][@"documentUrl"];
    wkVC.title =  self.dataArray[indexPath.row][@"title"];
    [self.navigationController pushViewController:wkVC animated:YES];
    
}


@end
