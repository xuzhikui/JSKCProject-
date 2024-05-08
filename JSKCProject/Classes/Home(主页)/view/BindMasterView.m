//
//  BindMasterView.m
//  JSKCProject
//
//  Created by XHJ on 2020/9/22.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "BindMasterView.h"
#import "BindMasterCell.h"
#import "AddDriverController.h"
@implementation BindMasterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

-(void)layoutSubviews{

[self setUI];

}

-(void)setUI{

   
    if ([self.codes isEqualToString:@"1"]) {
        
        return;;
    }
    
 
    [UILabel initWithDFLable:CGRectMake(22, 15 , Width, 30) :[UIFont boldSystemFontOfSize:22*Width1]:[UIColor blackColor] :
     @"绑定主驾":self:0];
    
    UIView *tfVC = [[UIView alloc]initWithFrame:CGRectMake(20, 60, Width - 40, 40)];
    tfVC.layer.cornerRadius = 4;
    tfVC.layer.borderWidth  = 1;
    tfVC.layer.borderColor = [COLOR2(203)CGColor];
    [self addSubview:tfVC];
    
    
    UIImageView *tfImg = [[UIImageView alloc]initWithFrame:CGRectMake(14, 13.5, 13, 13)];
    tfImg.image = [UIImage imageNamed:@"搜索-1"];
    [tfVC addSubview:tfImg];

    UIView *seleCarVC = [[UIView alloc]initWithFrame:CGRectMake(0, 132, Width, 33)];
    seleCarVC.backgroundColor = COLOR2(245);
    [self addSubview:seleCarVC];
    
    self.searchTF = [[UITextField alloc]initWithFrame:CGRectMake(35, 10, Width - 100, 20)];
    self.searchTF.font = [UIFont systemFontOfSize:15*Width1];
    self.searchTF.placeholder = @"请输入车牌号";
    [self.searchTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.searchTF.delegate = self;
    [tfVC addSubview:self.searchTF];
    
 
    
    UIImageView *seleImg = [[UIImageView alloc]initWithFrame:CGRectMake(22, 10, 13, 13)];
       seleImg.image = [UIImage imageNamed:@"货车-1"];
       [seleCarVC addSubview:seleImg];
 
    [UILabel initWithDFLable:CGRectMake(42, 1.5 , Width, 30) :[UIFont systemFontOfSize:13*Width1]:[UIColor grayColor] :
       @"可选司机":seleCarVC:0];
    
        self.table = [[UITableView alloc]initWithFrame:CGRectMake(0,165, Width,self.frame.size.height  - 80 - 165) style:(UITableViewStylePlain)];
            self.table.delegate = self;
            self.table.dataSource = self;
            self.table.backgroundColor = [UIColor clearColor];
            [self.table registerClass:[BindMasterCell class] forCellReuseIdentifier:@"cell"];
            self.table.separatorStyle =  UITableViewCellSeparatorStyleNone;
            [self addSubview:self.table];
    
    if (self.dataArray.count == 0) {
           self.backImg = [[UIImageView alloc]initWithFrame:CGRectMake((Width - 169)/2, 190, 169, 166)];
              self.backImg.image = [UIImage imageNamed:@"无司机-01-1"];
              [self addSubview:self.backImg];
           
        self.backTitle = [UILabel initWithDFLable:CGRectMake(0, 380, Width, 20) :[UIFont systemFontOfSize:14*Width1] :[UIColor blackColor] :@"暂无绑定司机" :self :1];

           }
    
    
    
    
        UIButton *seleCarBut = [UIButton initWithFrame:CGRectMake(30, self.frame.size.height - 70, self.frame.size.width - 60, 40) :@"添加司机" :16*Width1];
        [seleCarBut setTitleColor:[UIColor redColor] forState:0];
        seleCarBut.layer.cornerRadius = 4;
        seleCarBut.layer.borderColor = [[UIColor redColor]CGColor];
        [seleCarBut addTarget:self action:@selector(seleAction) forControlEvents:(UIControlEventTouchUpInside)];
        seleCarBut.layer.borderWidth = 1;
        [self addSubview:seleCarBut];
    
    
    self.codes = @"1";
}


///添加司机
-(void)seleAction{
    
    
    
    AddDriverController *addDricerVC = [AddDriverController new];
    addDricerVC.addType = @"1";
    addDricerVC.block = ^(NSDictionary * _Nonnull code) {
        
        [self gettranslateList];
    };
    [[AFN_DF topViewController].navigationController pushViewController:addDricerVC animated:YES];
    
//    self.block(@{@"":@""});
//    [self removeFromSuperview];
    
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
  BindMasterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    NSDictionary *dic;
    
    if (self.searArray.count != 0 || ![self.searchTF.text isEqualToString:@""]) {
        
        dic =  self.searArray[indexPath.row];
        
    }else{
        
        dic =  self.dataArray[indexPath.row];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dic = dic;
    cell.block = ^(NSDictionary * _Nonnull dic) {
     
        self.block(dic);
        [self removeFromSuperview];
        
    };
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 50;
    
}

///获取司机列表
-(void)gettranslateList{
    
    [AFN_DF POST:@"/system/driver/drivers" Parameters:nil success:^(NSDictionary *responseObject) {
          
          self.dataArray = responseObject[@"data"];
          
            if (self.dataArray.count !=  0) {
                   [self.backImg removeFromSuperview];
                   [self.backTitle removeFromSuperview];
                   
               }
        
            [self.table reloadData];
        
      } failure:^(NSError *error) {
          
      }];
    
    
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


@end
