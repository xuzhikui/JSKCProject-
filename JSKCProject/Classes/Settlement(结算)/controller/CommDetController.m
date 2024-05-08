//
//  CommDetController.m
//  JSKCProject
//
//  Created by 孟德峰 on 2020/12/27.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "CommDetController.h"
#import "LHRatingView.h"
@interface CommDetController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)UIScrollView *mainView;
@end

@implementation CommDetController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = YES;

}

-(void)postData{
    
    
[AFN_DF POST:@"/tsmanage/waybillsettle/getEvaluatedById" Parameters:@{@"waybillId":self.dic[@"waybillId"]} success:^(NSDictionary *responseObject) {
        
        
        self.data = responseObject[@"data"];
        [self setUI];
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStyleDone) target:self action:@selector(back)];
    
    self.title = @"评论详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
        [self postData];
//    [self setUI];
    
}

-(void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


-(void)setUI{
    
    UIView *numVC =  [[UIView alloc]initWithFrame:CGRectMake(10,  10, Width - 20, 40)];
     numVC.backgroundColor = [UIColor whiteColor];
     [self.mainView addSubview:numVC];
     
//     UIImageView *timeImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39, Width - 20, 1)];
//      timeImg.image = [UIImage imageNamed:@"线 拷贝"];
//     [numVC addSubview:timeImg];
     

     UILabel *timeLab = [UILabel initWithDFLable:CGRectMake(10,10,Width - 50, 20) :[UIFont systemFontOfSize:15*Width1] :[UIColor redColor] :[NSString stringWithFormat:@"订单号: %@",self.dic[@"waybillId"]] :numVC :0];
         [self setfwb:timeLab];
    
    
    
    
    UIView *addVC = [[UIView alloc]initWithFrame:CGRectMake(0, 50,Width, 70)];
    addVC.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:addVC];
    
    UIImageView *oneImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 15, 15)];
    oneImg.image = [UIImage imageNamed:@"装"];
    [addVC addSubview:oneImg];
      
    [UILabel initWithDFLable:CGRectMake(40, 0, 120, 15) :[UIFont systemFontOfSize:13*Width1] :[UIColor blackColor] :[NSString stringWithFormat:@"%@-%@",self.data[@"loadCity"],self.data[@"loadArea"]] :addVC :0];
    
    
    UIImageView *xImg = [[UIImageView alloc]initWithFrame:CGRectMake(160, 10, 80, 5)];
    xImg.image = [UIImage imageNamed:@"箭头"];
    [addVC addSubview:xImg];
    
    [UILabel initWithDFLable:CGRectMake(160,0, 80, 10) :[UIFont systemFontOfSize:12*Width1] :[UIColor grayColor] :self.data[@"distanceStr"] :addVC :1];
    
    
    UIImageView *twoImg = [[UIImageView alloc]initWithFrame:CGRectMake(250, 0, 15, 15)];
    twoImg.image = [UIImage imageNamed:@"卸"];
    [addVC addSubview:twoImg];
    
    [UILabel initWithDFLable:CGRectMake(270, 0, 120, 15) :[UIFont systemFontOfSize:13*Width1] :[UIColor blackColor] :[NSString stringWithFormat:@"%@-%@",self.data[@"unloadCity"],self.data[@"unloadArea"]] :addVC :0];
    
    [UILabel initWithDFLable:CGRectMake(20, 35, Width - 40, 15) :[UIFont systemFontOfSize:13*Width1] :[UIColor grayColor] :self.data[@"otherMess"] :addVC :0];
    
    
    UIView *fg = [[UIView alloc]initWithFrame:CGRectMake(0, 120, Width, 10)];
    fg.backgroundColor = COLOR2(240);
    [self.mainView addSubview:fg];
    
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(20,  150, 40, 40)];
    img.layer.cornerRadius = 20;
    img.backgroundColor = [UIColor redColor];
    img.layer.masksToBounds = YES;
    [img sd_setImageWithURL:[NSURL URLWithString:self.data[@"headUrl"]]];
    [self.mainView addSubview:img];
    
    [UILabel initWithDFLable:CGRectMake(65,  150,140, 40) :[UIFont systemFontOfSize:14*Width1] :[UIColor blackColor] :self.data[@"name"] :self.mainView :0];
    
    NSString *tag = self.data[@"star"];
    
    LHRatingView * rView = [[LHRatingView alloc]initWithFrame:CGRectMake(20, 195, 100, 25)];
//    rView.center = self.view.center;
        rView.ratingType = INTEGER_TYPE;//整颗星
        rView.score = tag.integerValue;
      rView.userInteractionEnabled = NO;
        [self.mainView addSubview:rView];
    
    NSString *str = self.data[@"content"];
    if (str == nil || [str isEqualToString:@""]) {
        str = @"当前暂无评论";
    }
    
    CGSize widSize =  [self sizeWithFont:[UIFont systemFontOfSize:14*Width1] maxWidth:Width - 60 maxStr:str];
    
   [UILabel initWithDFLable:CGRectMake(Width - 200,  195,180, 25) :[UIFont systemFontOfSize:14*Width1] :[UIColor grayColor] :self.data[@"evaluateTime"] :self.mainView :2];
    
    UILabel *commLab = [UILabel initWithDFLable:CGRectMake(20,  230,Width - 40, widSize.height) :[UIFont systemFontOfSize:14*Width1] :[UIColor grayColor] :str :self.mainView :0];
    
//
   self.dataArray = [self.data[@"evaluatePic"] componentsSeparatedByString:@","];
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, commLab.frame.size.height + commLab.frame.origin.y + 10, Width, 180 * self.dataArray.count) style:(UITableViewStylePlain)];
       self.table.delegate = self;
       self.table.dataSource = self;
       self.table.backgroundColor = [UIColor clearColor];
        [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
       self.table.separatorStyle =UITableViewCellSeparatorStyleNone;
       [self.mainView addSubview:self.table];
    self.table.userInteractionEnabled = NO;
    _mainView.contentSize = CGSizeMake(0, NavaBarHeight + self.table.frame.size.height + self.table.frame.origin.y);
    
    
    

    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(20,0,Width - 40, 170)];
    img.backgroundColor = [UIColor whiteColor];
    img.layer.cornerRadius = 4;
    img.layer.masksToBounds = YES;
    
    [img sd_setImageWithURL:[NSURL URLWithString:self.dataArray[indexPath.row]]];

    [cell addSubview:img];
    
    return cell;
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 180;
    
}




- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth maxStr:(NSString *)maxStr
{
    // 获取文字样式
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    
    // 根据文字样式计算文字所占大小
    // 文本最大宽度
    CGSize maxSize = CGSizeMake(Width - 70, Height);
    
    // NSStringDrawingUsesLineFragmentOrigin -> 从头开始
    
    
    
    return [maxStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
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


-(UIScrollView *)mainView{
    
    if (_mainView == nil) {
        
        _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NavaBarHeight, Width, Height)];
        _mainView.contentSize = CGSizeMake(0, 670);
        _mainView.bounces = NO;
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_mainView];
    }
    
    return _mainView;
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
