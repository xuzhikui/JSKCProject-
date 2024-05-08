//
//  AddCompController.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "AddCompController.h"
#import "CompLlistController.h"
#import "CompListCell.h"

@interface AddCompController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIButton *oneBut;
@property(nonatomic,strong)UIButton *twoBut;
@property(nonatomic,strong)UIButton *thereBut;
@property(nonatomic,strong)UITextView *textTF;
@property(nonatomic,strong)UILabel *tips;
@property(nonatomic,strong)PtoVC *ptovc;
@property(nonatomic,strong)NSString *code;

@end

@implementation AddCompController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
        [self.navigationController setNavigationBarHidden:NO animated:YES];
          self.tabBarController.tabBar.hidden = YES;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"我要投诉";
    self.code = @"0";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
}

-(void)setUI{
    
            self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, NavaBarHeight, Width, Height - NavaBarHeight) style:(UITableViewStylePlain)];
            self.table.delegate = self;
            self.table.dataSource = self;
            self.table.backgroundColor = [UIColor whiteColor];
            [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
     [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
     [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell3"];
     [self.table registerClass:[CompListCell class] forCellReuseIdentifier:@"cell4"];
            self.table.separatorStyle =UITableViewCellSeparatorStyleNone;
            [self.view addSubview:self.table];
    
    if (self.wayDic) {
        
//        [self];
        
    }
    
   
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

   
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
           cell.backgroundColor = [UIColor whiteColor];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [UILabel initWithDFLable:CGRectMake(20, 30, 120, 25) :[UIFont systemFontOfSize:15*Width1] :[UIColor blackColor] :@"投诉对象" :cell.contentView :0];
        
        
        self.oneBut = [UIButton initWithFrame:CGRectMake(25,  60, 70, 25) :@"托运人" :13*Width1];
        self.oneBut.layer.cornerRadius = 4;
        self.oneBut.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:self.oneBut];
        [self.oneBut addTarget:self action:@selector(oneAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        self.twoBut = [UIButton initWithFrame:CGRectMake(115,  60, 70, 25) :@"平台" :13*Width1];
             self.twoBut.layer.cornerRadius = 4;
             self.twoBut.backgroundColor = [UIColor whiteColor];
        self.twoBut.layer.borderColor = [COLOR2(203)CGColor];
        self.twoBut.layer.borderWidth = 1;
        [self.twoBut setTitleColor:COLOR2(203) forState:0];
        [self.twoBut addTarget:self action:@selector(twoAction) forControlEvents:(UIControlEventTouchUpInside)];
        [cell.contentView addSubview:self.twoBut];
  
        
        return cell;
        
    }else if(indexPath.section == 1) {
        
        
      
   
        /// 60
        
        if (self.wayDic) {
   
//            UIView *back = [[UIView alloc]initWithFrame:CGRectMake(25, 60, Width - 50, 170)];
//            back.backgroundColor = [UIColor whiteColor];
//            back.layer.cornerRadius = 4;
//            back.layer.borderWidth = 1;
//            back.layer.borderColor = COLOR2(203);
//            back.layer.masksToBounds = YES;
//            [cell.contentView addSubview:back];
            
           CompListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
            cell.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.layer.cornerRadius  = 4;
            cell.dic = self.wayDic;

            return cell;
            
            
            
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
                     cell.backgroundColor = [UIColor whiteColor];
                     cell.selectionStyle = UITableViewCellSelectionStyleNone;
                  
                  [UILabel initWithDFLable:CGRectMake(20, 20, 120, 25) :[UIFont systemFontOfSize:15*Width1] :[UIColor blackColor] :@"投诉对象" :cell.contentView :0];
    self.thereBut = [UIButton initWithFrame:CGRectMake(25,  60, 100, 25) :@"请选择投诉运单" :13*Width1];
        self.thereBut.layer.cornerRadius = 4;
        self.thereBut.layer.borderColor = [[UIColor redColor] CGColor];
        self.thereBut.layer.borderWidth = 1;
            [self.thereBut addTarget:self action:@selector(thereAction) forControlEvents:(UIControlEventTouchUpInside)];
            [self.thereBut setTitleColor:[UIColor redColor] forState:0];
            [cell.contentView addSubview:self.thereBut];
            
              return cell;
        }
        

        
      
    }else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
           cell.backgroundColor = [UIColor whiteColor];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
         [UILabel initWithDFLable:CGRectMake(20, 10, 200, 25) :[UIFont systemFontOfSize:15*Width1] :[UIColor blackColor] :@"投诉内容" :cell.contentView :0];
        
        self.textTF = [[UITextView alloc]initWithFrame:CGRectMake(20, 40, Width - 40, 200)];
          
          self.textTF.font = [UIFont systemFontOfSize:12*Width1];
          self.textTF.layer.cornerRadius = 4;
          self.textTF.delegate = self;
          self.textTF.zw_placeHolder = @"请在此输入您的宝贵意见，感谢您的支持!";
          self.textTF.layer.borderColor = [COLOR2(204)CGColor];
          self.textTF.layer.borderWidth = 1;
        [cell.contentView addSubview:self.textTF];
          
//          self.tips = [UILabel initWithDFLable:CGRectMake(Width - 100, 180,50, 20) :[UIFont systemFontOfSize:11*Width1] :[UIColor grayColor] :@"0/500" :self.textTF :2];
          
          
          
        [UILabel initWithDFLable:CGRectMake(20, 270, 200, 20) :[UIFont systemFontOfSize:17*Width1] :[UIColor blackColor] :@"上传截图(最多三张)" :cell.contentView :0];
          
          
          self.ptovc = [[PtoVC alloc]initWithFrame:CGRectMake(10, 310, Width - 20, 90)];
          self.ptovc.vc = self;
          self.ptovc.block = ^(UIImage * _Nonnull img) {
              
          };
        [cell.contentView addSubview:self.ptovc];
          
          
          UIButton *suppBut = [UIButton initWithFrame:CGRectMake(25, 430, Width - 50, 45) :@"提交反馈" :16];
          suppBut.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:suppBut];
          [suppBut addTarget:self action:@selector(suppButActrion) forControlEvents:(UIControlEventTouchUpInside)];
          suppBut.layer.cornerRadius = 4;

        
        
        return cell;
    }
    
}


-(void)thereAction{
    
       
    CompLlistController *listVC = [CompLlistController new];
    listVC.block = ^(NSDictionary * _Nonnull code) {
      
        self.wayDic = code;
        
        [self.table reloadData];
        
    };
    [self.navigationController pushViewController:listVC animated:YES];
    
    
}

-(void)oneAction{
    
    
            self.code = @"0";
       self.oneBut.backgroundColor = [UIColor redColor];
       [self.oneBut setTitleColor:[UIColor whiteColor] forState:0];
        self.oneBut.layer.borderWidth = 0;
    
    
    
        self.twoBut.backgroundColor = [UIColor whiteColor];
        [self.twoBut setTitleColor:COLOR2(203) forState:0];
            self.twoBut.layer.borderWidth = 1;
        self.twoBut.layer.borderColor = [COLOR2(203)CGColor];
    
    
}

-(void)twoAction{
    
    
            self.code = @"1";
            self.twoBut.backgroundColor = [UIColor redColor];
            [self.twoBut setTitleColor:[UIColor whiteColor] forState:0];
             self.twoBut.layer.borderWidth = 0;
         
         
         
                self.oneBut.backgroundColor = [UIColor whiteColor];
                [self.oneBut setTitleColor:COLOR2(203) forState:0];
                 self.oneBut.layer.borderWidth = 1;
                self.oneBut.layer.borderColor = [COLOR2(203)CGColor];
    
    
}





-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 100;
    }else if (indexPath.section == 1) {
        
        if (self.wayDic) {
            return 150;
        }else{
              return 100;
        }
        
    }else if (indexPath.section == 2) {
        
        return 600;
    }else{
        
        return 0;
    }
    
    
}


-(void)suppButActrion{
    
    
    
    if (!self.wayDic) {
        
        return [self.view addSubview:[Toast makeText:@"请选择运单"]];
    }
    
    
    
    NSDictionary *dic = @{
        
        @"content":self.textTF.text,
        @"cpobject":self.code,
        @"waybillId":self.wayDic[@"waybillId"],
    };
    NSMutableArray *files = [NSMutableArray array];
    for (int i = 0; i < _ptovc.dataArray.count; i++) {
        [files addObject:@"files"];
    }
    [AFN_DF POST:@"/system/complaint/add" Parameters:dic File:files ImageArr:_ptovc.dataArray ContVC:self success:^(NSDictionary *responseObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
        [[AFN_DF topViewController].view addSubview:[Toast makeText:@"提交成功"]];
        
        
    } failure:^(NSError *error) {
        
        
        
    }];
    
    
       
    
    
    
    
    
}


- (void)textViewDidChange:(UITextView *)textView
{
   
    if (textView.text.length <= 500) {
        self.tips.text  = [NSString stringWithFormat:@"%ld/500",self.textTF.text.length];
    }else{
        
        [self.view addSubview:[Toast makeText:@"您最多输入500字反馈内容"]];
        
    }
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

        if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
                [self.view endEditing: YES];
//在这里做你响应return键的代码

                return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行

}

            return YES;

}


@end
