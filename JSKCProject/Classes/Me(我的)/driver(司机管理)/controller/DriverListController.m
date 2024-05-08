//
//  DriverListController.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/27.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "DriverListController.h"
#import "AddDriverController.h"
#import "DriverListCell.h"
#import "AddDriverController.h"
#import "TwoAddDriceController.h"
@interface DriverListController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITextField *searchTF;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *searArray;

@end

@implementation DriverListController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = YES;
   
      [self postData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"司机管理";
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = COLOR2(240);
    
    [self setUI];
    
  
}

-(void)postData{
    
 

    [AFN_DF POST:@"/system/driver/drivers" Parameters:nil success:^(NSDictionary *responseObject) {
        
        self.dataArray = responseObject[@"data"];
        
        [self.table reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

-(void)setUI{
    
    
    UIView *searchVC  = [[UIView alloc]initWithFrame:CGRectMake(10, NavaBarHeight + 10, Width - 20, 60)];
    searchVC.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchVC];
    
    
    UIView *textVC = [[UIView alloc]initWithFrame:CGRectMake(10, 10, Width - 40, 40)];
    textVC.layer.cornerRadius = 4;
    textVC.layer.borderWidth = 1;
    textVC.layer.borderColor = [COLOR2(204)CGColor];
    [searchVC addSubview:textVC];
    
    UIImageView *searImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    searImg.image = [UIImage imageNamed:@"搜索-1"];
    [textVC addSubview:searImg];
    
    self.searchTF = [[UITextField alloc]initWithFrame:CGRectMake(35, 10, Width - 100, 20)];
    self.searchTF.font = [UIFont systemFontOfSize:15*Width1];
    self.searchTF.placeholder = @"请输入司机姓名";
    [textVC addSubview:self.searchTF];
    [self.searchTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        self.searchTF.delegate = self;
    [self addListView];
    
    
    
    
    
    UIView *tabbarVC  = [[UIView alloc]initWithFrame:CGRectMake(0, Height - 60 - ScreenBottom , Width, 60)];
       tabbarVC.backgroundColor = [UIColor whiteColor];
       [self.view addSubview:tabbarVC];
       
       
    UIButton *addCarBut = [UIButton initWithFrame:CGRectMake(20, 10, Width - 40, 40) :@"添加司机" :16*Width1];
    [addCarBut setTitleColor:[UIColor redColor] forState:0];
    addCarBut.layer.cornerRadius = 4;
    addCarBut.layer.borderWidth = 1;
    [addCarBut addTarget:self action:@selector(adddevAction) forControlEvents:(UIControlEventTouchUpInside)];
    addCarBut.layer.borderColor = [[UIColor redColor]CGColor];
    [tabbarVC addSubview:addCarBut];
    
   
      
    
    

}

///添加车辆
-(void)adddevAction{
    
    AddDriverController *addVC = [ AddDriverController new];
    [self.navigationController pushViewController:addVC animated:YES];
    
}



-(void)addListView{
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(10, NavaBarHeight + 73, Width - 20, Height -NavaBarHeight - 143) style:(UITableViewStylePlain)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor =COLOR2(240);
    [self.table registerClass:[DriverListCell class] forCellReuseIdentifier:@"cell"];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    
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
    
    DriverListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.dic = arr[indexPath.row];
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 87;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     NSDictionary *dic = self.dataArray[indexPath.row];
    NSInteger verify = [[NSString stringWithFormat:@"%@",dic[@"verify"]]integerValue];
       
//
    
   
//    
       if (verify ==2) {

           TwoAddDriceController *twovc = [TwoAddDriceController new];
              twovc.dic = dic;
              [self.navigationController pushViewController:twovc animated:YES];


       }else{

            AddDriverController *addVC = [AddDriverController new];
               addVC.dic = self.dataArray[indexPath.row];
               [self.navigationController pushViewController:addVC animated:YES];

       }

    
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
    
    
    [AFN_DF POST:@"/system/driver/delete" Parameters:@{@"dId":dic[@"id"]} success:^(NSDictionary *responseObject) {
              
              
               [self.dataArray removeObjectAtIndex:indexPath.row];
                       [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationTop];

          } failure:^(NSError *error) {
              
          }];
    
  
    
    //删除数据，和删除动画
  
}

- (void)textFieldDidChange:(UITextField *)textField {
  
    
     NSString *search =  textField.text;
    self.searArray  = [NSMutableArray array];
    for (NSDictionary *dic in self.dataArray) {
        
       NSString *dataStr = dic[@"name"];
        
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
