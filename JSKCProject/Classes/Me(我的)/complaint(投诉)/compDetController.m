//
//  compDetController.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "compDetController.h"
#import "CompLlistController.h"
#import "CompListCell.h"
@interface compDetController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIButton *oneBut;
@property(nonatomic,strong)UIButton *twoBut;
@property(nonatomic,strong)UIButton *thereBut;
@property(nonatomic,strong)UITextView *textTF;
@property(nonatomic,strong)UILabel *tips;
@property(nonatomic,strong)PtoVC *ptovc;
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSDictionary *wayDic;
@property(nonatomic,strong)NSString *state;
@end

@implementation compDetController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"我要投诉";
    self.code = @"0";
    self.state = [NSString stringWithFormat:@"%@",self.dic[@"state"]];
//    self.state = @"1";
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self postData];
   
}

-(void)postData{
    
    
    [AFN_DF POST:@"/system/complaint/getById" Parameters:@{@"id":self.dic[@"id"]} success:^(NSDictionary *responseObject) {
        
        self.dic = responseObject[@"data"];
         [self setUI];
    } failure:^(NSError *error) {
        
    }];
    
    
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
        
        
        NSString *str = [NSString stringWithFormat:@"%@",self.dic[@"cpobject"]];
        
        if ([str isEqualToString:@"0"]) {
                
            str = @"托运人";
        }else{
            
             str = @"平台";
        }
        
        
        self.oneBut = [UIButton initWithFrame:CGRectMake(25,  60, 70, 25) :str :13*Width1];
        self.oneBut.layer.cornerRadius = 4;
        self.oneBut.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:self.oneBut];
        [self.oneBut addTarget:self action:@selector(oneAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.oneBut.userInteractionEnabled = NO;
        
        return cell;
        
    }else if(indexPath.section == 1) {
        

        NSDictionary *dic = @{
            
            @"waybillId":self.dic[@"waybillId"],
             @"loadCity":self.dic[@"loadCity"],
             @"unloadCity":self.dic[@"unloadCity"],
             @"loadArea":self.dic[@"loadArea"],
             @"unloadArea":self.dic[@"unloadArea"],
             @"distanceStr":self.dic[@"distanceStr"],
             @"durationStr":self.dic[@"durationStr"],
        };
        
            
           CompListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
            cell.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.layer.cornerRadius  = 4;
            cell.dic = dic;

            return cell;
   
        }else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
           cell.backgroundColor = [UIColor whiteColor];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
         [UILabel initWithDFLable:CGRectMake(20, 10, 200, 25) :[UIFont systemFontOfSize:15*Width1] :[UIColor blackColor] :@"投诉内容" :cell.contentView :0];
        
        self.textTF = [[UITextView alloc]initWithFrame:CGRectMake(20, 40, Width - 40, 200)];
          
          self.textTF.font = [UIFont systemFontOfSize:12*Width1];
          self.textTF.layer.cornerRadius = 4;
          self.textTF.delegate = self;
//          self.textTF.zw_placeHolder = @"请在此输入您的宝贵意见，感谢您对江苏快成的支持!";
          self.textTF.layer.borderColor = [COLOR2(204)CGColor];
          self.textTF.layer.borderWidth = 1;
            self.textTF.userInteractionEnabled = NO;
            self.textTF.text = self.dic[@"content"];
        [cell.contentView addSubview:self.textTF];
          
//          self.tips = [UILabel initWithDFLable:CGRectMake(Width - 100, 180,50, 20) :[UIFont systemFontOfSize:11*Width1] :[UIColor grayColor] :@"0/500" :self.textTF :2];
          
          
          
        [UILabel initWithDFLable:CGRectMake(20, 270, 200, 20) :[UIFont systemFontOfSize:17*Width1] :[UIColor blackColor] :@"凭证信息" :cell.contentView :0];
            
            NSString *urlstr = [NSString stringWithFormat:@"%@",self.dic[@"proof"]];
            
            NSArray *imageUrl = [urlstr componentsSeparatedByString:@","];;
            
            
            for (int i = 0; i < imageUrl.count; i++) {
                
                
                UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(20 + (90 * i),310, 80, 80)];
                [img sd_setImageWithURL:[NSURL URLWithString:imageUrl[i]] placeholderImage:[UIImage imageNamed:@"上传凭证"]];
               [cell.contentView addSubview:img];
            }
            
            
            if ([self.state isEqualToString:@"0"]) {
                
                UIButton *suppBut = [UIButton initWithFrame:CGRectMake(25, 430, Width - 50, 45) :@"撤销投诉" :16];
                       suppBut.backgroundColor = [UIColor redColor];
                     [cell.contentView addSubview:suppBut];
                       [suppBut addTarget:self action:@selector(canlAction) forControlEvents:(UIControlEventTouchUpInside)];
                       suppBut.layer.cornerRadius = 4;
            }else{
                
                [UILabel initWithDFLable:CGRectMake(20, 410, 200, 20) :[UIFont systemFontOfSize:15*Width1] :[UIColor blackColor] :@"投诉反馈" :cell.contentView :0];

                UITextView *text = [[UITextView alloc]initWithFrame:CGRectMake(20, 440, Width - 40, 120)];
               text.layer.borderColor = [COLOR2(204)CGColor];
                text.layer.borderWidth = 1;
                text.userInteractionEnabled = NO;
                text.font = [UIFont systemFontOfSize:14*Width1];
                text.text = self.dic[@"feedback"];
                [cell.contentView addSubview:text];

                UIButton *suppBut = [UIButton initWithFrame:CGRectMake(25,  580, Width - 50, 45) :@"删除投诉" :16];
                       suppBut.backgroundColor = [UIColor redColor];
                     [cell.contentView addSubview:suppBut];
                       [suppBut addTarget:self action:@selector(delelAction) forControlEvents:(UIControlEventTouchUpInside)];
                       suppBut.layer.cornerRadius = 4;
                
            }
            
          
       


        return cell;
    }
    
}

-(void)delelAction{
    
    [AFN_DF POST:@"/system/complaint/delete" Parameters:@{@"id":self.dic[@"id"]} success:^(NSDictionary *responseObject) {
         
         
         [self.navigationController popViewControllerAnimated:YES];
         
         [[AFN_DF topViewController].view addSubview:[Toast makeText:@"删除成功"]];
         
     } failure:^(NSError *error) {
         
     }];
     
    
    
}


-(void)canlAction{
    
    
    [AFN_DF POST:@"/system/complaint/cancel" Parameters:@{@"id":self.dic[@"id"]} success:^(NSDictionary *responseObject) {
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
        [[AFN_DF topViewController].view addSubview:[Toast makeText:@"撤销投诉成功"]];
        
    } failure:^(NSError *error) {
        
    }];
    
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

            return 150;
        
        
    }else if (indexPath.section == 2) {
        
        if ([self.state isEqualToString:@"0"]) {
             return 500;
        }else{
            
            return 650;
        }
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
    
    [AFN_DF POST:@"/system/complaint/add" Parameters:dic File:@[@"files"] ImageArr:_ptovc.dataArray ContVC:self success:^(NSDictionary *responseObject) {
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
