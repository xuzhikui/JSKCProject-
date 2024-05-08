//
//  payController.m
//  JSKCProject
//
//  Created by 孟德峰 on 2020/12/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "payController.h"
#import "AddBandCarController.h"
#import "UnBandController.h"
#import "UpPhoneController.h"
#import "SuppMoenyController.h"
#import "DetailedController.h"
#import "VehicleInfoVC.h"

@interface payController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSArray *dataArray;
@end

@implementation payController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = YES;
        [self postData];
}


-(void)upData{
    
    self.dataArray = [NSArray array];
    
    [AFN_DF POST:@"/system/wallet/getDetail" Parameters:nil success:^(NSDictionary *responseObject) {
        
        self.dic = responseObject[@"data"];
        self.dataArray = responseObject[@"data"][@"bankCardBeans"];
        [self.table reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}


-(void)postData{
    
    
    
    [AFN_DF POST:@"/system/wallet/getDetail" Parameters:nil success:^(NSDictionary *responseObject) {
        
        self.dic = responseObject[@"data"];
        self.dataArray = responseObject[@"data"][@"bankCardBeans"];
        [self setUI];
    } failure:^(NSError *error) {
        
    }];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的钱包";
    self.dataArray = [NSArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    
       
    UIButton *but = [UIButton initWithFrame:CGRectMake(0, 0, 100, 20) :@"交易明细" :13*Width1];
    [but setTitleColor:COLOR2(51) forState:0];
    [but addTarget:self action:@selector(mxAction) forControlEvents:(UIControlEventTouchUpInside)];

       UIBarButtonItem *leftItemBtn = [[UIBarButtonItem alloc] initWithCustomView:but];
    self.navigationItem.rightBarButtonItem = leftItemBtn;


//    [self postData];
//    [self setUI];
}

-(void)setUI{
    
    UIImageView *back = [[UIImageView alloc]initWithFrame:CGRectMake(20, NavaBarHeight + 20, Width - 40, 160)];
    back.image = [UIImage imageNamed:@"钱包back"];
    back.layer.cornerRadius = 4;
    back.layer.masksToBounds = YES;
    [self.view addSubview:back];
    back.userInteractionEnabled = YES;
    
    UIImageView *toImg = [[UIImageView alloc]initWithFrame:CGRectMake(25, 25, 45, 45)];
    toImg.backgroundColor = [UIColor whiteColor];
    toImg.layer.cornerRadius = 22.5;
    [toImg sd_setImageWithURL:[NSURL URLWithString:[UserModel shareInstance].headurl]];
    [back addSubview:toImg];
    
    [UILabel initWithDFLable:CGRectMake(90, 30, 150, 20) :[UIFont systemFontOfSize:14*Width1] :[UIColor whiteColor] :@"账户余额" :back :0];
    
       
    
    UIButton *txBut = [UIButton initWithFrame:CGRectMake(back.frame.size.width - 80, 27.5, 65, 25) :@"提现" :15*Width1];
    [txBut setTitleColor:[UIColor whiteColor] forState:0];
    txBut.layer.cornerRadius = 12.5;
    txBut.backgroundColor = COLOR(255, 180, 0);
    [txBut addTarget:self action:@selector(txAction) forControlEvents:(UIControlEventTouchUpInside)];
    txBut.layer.masksToBounds = YES;
    [back addSubview:txBut];
    
    
    
      
    [UILabel initWithDFLable:CGRectMake(20, 75, 55, 20):[UIFont systemFontOfSize:11*Width1] :[UIColor whiteColor] :[UserModel shareInstance].name :back :1];
    
    [UILabel initWithDFLable:CGRectMake(90, 70, 100, 20):[UIFont boldSystemFontOfSize:22*Width1] :[UIColor whiteColor] :[NSString stringWithFormat:@"¥%@",self.dic[@"balance"]] :back :0];
    
    
    NSArray *titArr = @[@"累计收入(元)",@"已提现(元)",@"正在提现(元)"];
    
    
    for (int i = 0 ; i < 3; i++) {
        
      UILabel *tips = [UILabel initWithDFLable:CGRectMake(20 + (back.frame.size.width/3 * i), back.frame.size.height - 40, back.frame.size.width/3 - 40 , 15) :[UIFont systemFontOfSize:12*Width1] :[UIColor whiteColor] :titArr[i] :back :0];
        
    
        UILabel *tip = [UILabel initWithDFLable:CGRectMake(20 + (back.frame.size.width/3 * i), back.frame.size.height - 22.5, back.frame.size.width/3 - 40 , 15) :[UIFont systemFontOfSize:12*Width1] :[UIColor whiteColor] :@"0.00" :back :0];
        
        
        if (i == 0) {
            tips.textAlignment = 0;
            tip.textAlignment = 1;
            tip.text = [NSString stringWithFormat:@"%@",self.dic[@"totalIncome"]];
        }else if (i == 1){
            tips.frame = CGRectMake(10 + (back.frame.size.width/3 * i), back.frame.size.height - 40, back.frame.size.width/3 - 20 , 15);
            tip.frame = CGRectMake(10 + (back.frame.size.width/3 * i), back.frame.size.height - 22.5, back.frame.size.width/3 - 20 , 15);
            tip.textAlignment = 1;
            tips.textAlignment = 1;
            tip.text = [NSString stringWithFormat:@"%@",self.dic[@"withdrawaled"]];
        }else if (i == 2){
            tips.frame = CGRectMake(20 + (back.frame.size.width/3 * i), back.frame.size.height - 40, back.frame.size.width/3 - 40 , 15);
            tip.frame =  CGRectMake(20 + (back.frame.size.width/3 * i), back.frame.size.height - 22.5, back.frame.size.width/3 - 40 , 15);
            
            tips.textAlignment = 2;
            tip.textAlignment = 1;
            tip.text = [NSString stringWithFormat:@"%@",self.dic[@"withdrawaling"]];
        }

    }
    
    UIView *codevc = [[UIView alloc]initWithFrame:CGRectMake(0, NavaBarHeight + 200, Width, 10)];
    codevc.backgroundColor = COLOR2(230);
    
    [self.view addSubview:codevc];
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, NavaBarHeight + 210, Width, 170) style:(UITableViewStylePlain)];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.table];
    self.table.scrollEnabled = NO;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;

}

-(void)txAction{
    if (UserModel.shareInstance.hasBankCard != nil && UserModel.shareInstance.hasBankCard.integerValue != 0) {
        SuppMoenyController *suVC = [SuppMoenyController new];
        [self.navigationController pushViewController:suVC animated:YES];
    }else{
        AddBandCarController *addBandCarVC = [AddBandCarController new];
        [self.navigationController pushViewController:addBandCarVC animated:YES];
    }
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 160)];
    back.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:back];
    
    if (self.dataArray.count == 0) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(Width/2 - 25, 25, 50, 50)];
        img.image = [UIImage imageNamed:@"添加银行卡"];
        [back addSubview:img];
        
        [UILabel initWithDFLable:CGRectMake(0, 85, Width, 20):[UIFont systemFontOfSize:15*Width1] :[UIColor blackColor] :@"绑定提现银行卡" :back :1];
        
      UILabel *nameLab  = [UILabel initWithDFLable:CGRectMake(0, 110, Width, 20):[UIFont systemFontOfSize:15*Width1] :COLOR2(153) :[NSString stringWithFormat:@"仅支持%@名下的储蓄卡绑定",[UserModel shareInstance].name] :back :1];
        [self setfwb:nameLab];
    }else{
        
        NSDictionary *dic = self.dataArray[indexPath.row];
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, Width - 40, 105)];
        [img sd_setImageWithURL:[NSURL URLWithString:dic[@"logoBack"]]];
        [back addSubview:img];
        img.userInteractionEnabled = YES;
        
        
        UIImageView *toimg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 22.5, 60, 60)];
        [toimg sd_setImageWithURL:[NSURL URLWithString:dic[@"logo"]]];
        [img addSubview:toimg];
        img.userInteractionEnabled = YES;
        
        
        
        [UILabel initWithDFLable:CGRectMake(100, 20,  150, 20):[UIFont systemFontOfSize:15*Width1] :[UIColor whiteColor] :[NSString stringWithFormat:@"%@",dic[@"bank"]] :img :0];
        
        [UILabel initWithDFLable:CGRectMake(100, 40,  220, 15):[UIFont systemFontOfSize:12*Width1] :[UIColor whiteColor] :[NSString stringWithFormat:@"%@",dic[@"bankSub"]] :img :0];
        
        
        UIButton *buts = [UIButton initWithFrame:CGRectMake(img.frame.size.width - 70, 10, 60, 25) :@"解绑" :13];
        buts.layer.cornerRadius = 4;
        buts.layer.masksToBounds = YES;
        buts.layer.borderWidth = 1;
        [buts addTarget:self action:@selector(butAction) forControlEvents:(UIControlEventTouchUpInside)];
        buts.layer.borderColor = [[UIColor whiteColor]CGColor];
        [img addSubview:buts];
        
        
        
        [UILabel initWithDFLable:CGRectMake(img.frame.size.width - 300, img.frame.size.height - 30,  290, 25):[UIFont systemFontOfSize:23*Width1] :[UIColor whiteColor] :[NSString stringWithFormat:@"%@",dic[@"bankCardNum"]] :img :2];
    

    }
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 10, Width, 10)];
    back.backgroundColor = COLOR2(230);
    
    return back;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([UserModel shareInstance].idcard == nil || [UserModel shareInstance].idcard.length == 0) {
        return [[AFN_DF topViewController].view addSubview:[Toast makeText:@"身份认证通过后，才可以绑定银行卡"]];
    }
    if (self.dataArray.count == 0) {
        AddBandCarController *addVC = [AddBandCarController new];
        [self.navigationController pushViewController:addVC animated:YES];
    }
    
}



-(void)mxAction{
    
    DetailedController *mxVC = [DetailedController new];
    [self.navigationController pushViewController:mxVC animated:YES];
}

///解绑
-(void)butAction{
    
    UnBandController *bandVC = [UnBandController new];
    bandVC.dic = self.dic[@"bankCardBeans"][0];
    [self.navigationController pushViewController:bandVC animated:YES];
    
    
    
}

-(void)setfwb:(UILabel *)las{
    
    NSString *str = las.text;
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    //给富文本添加属性1-字体大小
//        [attributedStr addAttribute:NSFontAttributeName
//                              value:[UIFont systemFontOfSize:14*Width1]
//                              range:NSMakeRange(0, 3)];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:COLOR(255, 180, 0)
                          range:NSMakeRange(3, [UserModel shareInstance].name.length)];
    
    
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
