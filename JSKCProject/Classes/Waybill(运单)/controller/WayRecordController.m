//
//  WayRecordController.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/26.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "WayRecordController.h"
#import "WayRecordCell.h"
@interface WayRecordController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSArray *dataArray;
@end

@implementation WayRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.title = @"运单记录";
    self.view.backgroundColor = COLOR2(240);
    [self setUI];
    
    [self postData];
    
}

-(void)setUI{
//    CGRectMake(10, 10, Width - 20, 40)
        UIView *numVC =  [[UIView alloc]initWithFrame:CGRectMake(10, NavaBarHeight + 10, Width - 20, 40)];
      numVC.backgroundColor = [UIColor whiteColor];
      [self.view addSubview:numVC];
      
      UIImageView *timeImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39, Width - 20, 1)];
       timeImg.image = [UIImage imageNamed:@"线 拷贝"];
      [numVC addSubview:timeImg];
      

      UILabel *timeLab = [UILabel initWithDFLable:CGRectMake(10,10,Width - 50, 20) :[UIFont systemFontOfSize:15*Width1] :[UIColor redColor] :[NSString stringWithFormat:@"订单号: %@",self.dic[@"waybillId"]] :numVC :0];
          [self setfwb:timeLab];
    

    UIView *backVC = [[UIView alloc]initWithFrame:CGRectMake(10, NavaBarHeight + 50, Width - 20, 30)];
    backVC.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backVC];
    
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(10, NavaBarHeight +  80, Width - 20, Height - 80 - NavaBarHeight) style:(UITableViewStylePlain)];
      self.table.delegate = self;
      self.table.dataSource = self;
      self.table.backgroundColor = [UIColor whiteColor];
      [self.table registerClass:[WayRecordCell class] forCellReuseIdentifier:@"cell"];
      self.table.separatorStyle =UITableViewCellSeparatorStyleNone;
//    self.table.userInteractionEnabled = NO;
      [self.view addSubview:self.table];
    
}


#pragma mark ------UItableviewDelegate ------


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WayRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dic = self.dataArray[indexPath.row];
    if (indexPath.row == 0) {
        
        cell.code = @"0";
    }else {
        
     cell.code = @"1";
    }
    
    if (self.dataArray.count - 1 == indexPath.row) {
        
        cell.code = @"3";
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 150;
    
}


-(void)postData{
    

    [AFN_DF POST:@"/tsmanage/waybill/getWaybillRecord" Parameters:@{@"waybillId":self.dic[@"waybillId"]} success:^(NSDictionary *responseObject) {
        
        
        NSLog(@"%@",responseObject);
        self.dataArray = responseObject[@"data"];
        [self.table reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)setfwb:(UILabel *)las{
    
    NSString *str = las.text;
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    //给富文本添加属性1-字体大小
//        [attributedStr addAttribute:NSFontAttributeName
//                              value:[UIFont systemFontOfSize:14*Width1]
//                              range:NSMakeRange(0, 3)];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor blackColor]
                          range:NSMakeRange(0, 4)];
    
    
    las.attributedText = attributedStr;
//    las.textAlignment = YES;
    
   
    
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
