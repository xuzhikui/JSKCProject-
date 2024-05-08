//
//  EndSuppController.m
//  JSKCProject
//
//  Created by 孟德峰 on 2020/12/29.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "EndSuppController.h"
#import "DetailedController.h"
#import "payController.h"

@interface EndSuppController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSArray *titArray;
@property(nonatomic,strong)NSArray *costArray;

@end

@implementation EndSuppController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提现成功";
    self.view.backgroundColor = COLOR2(240);
    [self setUI];
    
}

-(void)setUI{
    
    
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, NavaBarHeight, Width, 200)];
    img.backgroundColor = [UIColor redColor];
    img.userInteractionEnabled = YES;
    img.image = [UIImage imageNamed:@"多边形 1 拷贝 2"];
    [self.view addSubview:img];
    
    
    
    UIImageView *iconimg = [[UIImageView alloc]initWithFrame:CGRectMake(Width/2 - 20, 30, 40, 40)];
    iconimg.image = [UIImage imageNamed:@"对"];
    [img addSubview:iconimg];
    
    
    [UILabel initWithDFLable:CGRectMake(0, 80, Width, 20) :[UIFont boldSystemFontOfSize:17*Width1] :[UIColor whiteColor] :@"恭喜您，提现成功" :img :1];
    
    [UILabel initWithDFLable:CGRectMake(0, 110, Width, 20) :[UIFont systemFontOfSize:13*Width1] :[UIColor whiteColor] :@"两小时内到账，请注意查收" :img :1];
    
    
    self.titArray = @[@"提现金额",@"到账银行卡",@"账户余额"];
    
   
    self.costArray = @[self.dic[@"amount"],[NSString stringWithFormat:@"%@",self.dic[@"bankCardNum"]],self.dic[@"balance"]];
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(10, NavaBarHeight + 220, Width - 20, 150) style:(UITableViewStylePlain)];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.table];
    self.table.backgroundColor = COLOR2(240);
    self.table.scrollEnabled = NO;

    
    
    UIButton *onebut = [UIButton initWithFrame:CGRectMake(50, NavaBarHeight + 400, Width/2 - 60, 35) :@"我知道了" :15];
    onebut.layer.cornerRadius = 4;
    onebut.layer.masksToBounds = YES;
    onebut.layer.borderWidth =1;
    [onebut setTitleColor:[UIColor redColor] forState:0];
    [onebut addTarget:self action:@selector(oneButAction) forControlEvents:(UIControlEventTouchUpInside)];
    onebut.layer.borderColor = [[UIColor redColor]CGColor];
    [self.view addSubview:onebut];

    
    UIButton *twobut = [UIButton initWithFrame:CGRectMake(Width/2  + 10, NavaBarHeight + 400, Width/2 - 60, 35) :@"交易明细" :15];
    twobut.layer.cornerRadius = 4;
    twobut.layer.masksToBounds = YES;
    twobut.backgroundColor = [UIColor redColor];
    [twobut addTarget:self action:@selector(twoButAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:twobut];
    
}


-(void)oneButAction{
    UIViewController *tempVC = nil;
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:payController.class]) {
            tempVC = vc;
            break;
        }
    }
    if (tempVC) {
        [self.navigationController popToViewController:tempVC animated:YES];
    }else
        [self.navigationController popToRootViewControllerAnimated:YES];
    [UIApplication.sharedApplication.keyWindow addSubview:[Toast makeText:@"提现成功"]];
}

-(void)twoButAction{
    
    DetailedController *detVC = [DetailedController new];
    [self.navigationController pushViewController:detVC animated:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor =[UIColor whiteColor];
    cell.textLabel.text = self.titArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13*Width1];
    
    [UILabel initWithDFLable:CGRectMake(Width - 160, 10,120, 30) :[UIFont systemFontOfSize:13*Width1] :[UIColor blackColor] :self.costArray[indexPath.row] :cell.contentView :2];
    
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
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
