//
//  ConsignmentListController.m
//  JSKCProject
//
//  Created by XHJ on 2021/4/6.
//  Copyright © 2021 孟德峰. All rights reserved.
//

#import "ConsignmentListController.h"
#import "SourceListCell.h"
#import "SourceGoodController.h"
#import "loginController.h"
@interface ConsignmentListController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSTimer *timer;
}
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSMutableArray *timeArray;

@end

@implementation ConsignmentListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStyleDone) target:self action:@selector(back)];
    
    self.timeArray = [NSMutableArray array];
    self.title = @"货源列表";
    self.view.backgroundColor = COLOR2(240);
    [self postData];
    [self setUI];
}

-(void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)postData{
    
    
    [AFN_DF POST:@"/tsmanage/goodssource/get" Parameters:@{@"goodserId":self.goodID,@"localItude":[NSString stringWithFormat:@"%@,%@",[LoactionModel shareInstance].lo,[LoactionModel shareInstance].lat]} success:^(NSDictionary *responseObject) {
        self.dataArray = responseObject[@"data"][@"list"];
        [self.table reloadData];
        
        [self startTimer];
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

-(void)setUI{
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0,NavaBarHeight + 10, Width, Height - NavaBarHeight - 10) style:(UITableViewStylePlain)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor = [UIColor clearColor];
    [self.table registerClass:[SourceListCell class] forCellReuseIdentifier:@"cell"];
    self.table.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

        return self.dataArray.count;
        
    }

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
        SourceListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
           cell.backgroundColor = [UIColor whiteColor];
        cell.layer.cornerRadius = 4;
        cell.layer.masksToBounds = YES;
        if (indexPath.row < self.dataArray.count) {

            cell.dic = self.dataArray[indexPath.row];
            }
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
           return cell;
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
      return 223;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
    NSLog(@"%@",[UserModel shareInstance].cyrVerify);
    
    
    if ([UserModel shareInstance].accessToken == nil) {
//        if ([TXCommonUtils simSupportedIsOK] && [TXCommonUtils checkDeviceCellularDataEnable]) {
//            LoginController *logVC =  [LoginController new];
//            [self.navigationController pushViewController:logVC animated:YES];
//        }else{
//            PhoneLoginController *logVC =  [PhoneLoginController new];
//            [self.navigationController pushViewController:logVC animated:YES];
//        }
        PhoneLoginController *logVC =  [PhoneLoginController new];
        [self.navigationController pushViewController:logVC animated:YES];
    }else{

        if([[NSString stringWithFormat:@"%@",[UserModel shareInstance].cyrVerify] isEqualToString:@"0"]){
        
            InfoVC *infoVC = [[InfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
            infoVC.tag = 1;
            [UIApplication.sharedApplication.keyWindow addSubview:infoVC];
        }else{
            
            SourceGoodController *sourceVC = [SourceGoodController new];
            sourceVC.dic = self.dataArray[indexPath.row];
            sourceVC.typeCode = @"2";
            [self.navigationController pushViewController:sourceVC animated:YES];

       }


    }
    
}



- (void)startTimer
{
    
    
    [self.timeArray removeAllObjects];
    
    for (int i = 0; i < self.dataArray.count; i++) {
        
            NSMutableDictionary *dic = self.dataArray[i];

        
            NSString *code = [NSString stringWithFormat:@"%@",dic[@"longterm"]];
           if ([code isEqualToString:@"0"]) {
               
              NSInteger time = [dic[@"remainTime"] integerValue]/1000;
               [self.timeArray addObject:[NSString stringWithFormat:@"%ld",(long)time]];
                  
           }else{
               
               [self.timeArray addObject:@"0"];
           }
      
    }
    
    timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshLessTime) userInfo:@"" repeats:YES];

    //如果不添加下面这条语句，在UITableView拖动的时候，会阻塞定时器的调用
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
 
}

- (void)refreshLessTime
{

    
    for (int i = 0; i < self.dataArray.count; i++) {
        
            NSDictionary *dic = self.dataArray[i];

        
            NSString *code = [NSString stringWithFormat:@"%@",dic[@"longterm"]];
           if ([code isEqualToString:@"0"]) {
          

               NSInteger time = [self.timeArray[i]integerValue];
              
                NSIndexPath *indePath = [NSIndexPath indexPathForRow:i inSection:0];
                SourceListCell *cell = ( SourceListCell *)[self.table cellForRowAtIndexPath:indePath];
                [self lessSecondToDay:--time:cell.timeLab];
               self.timeArray[i] = [NSString stringWithFormat:@"%ld",time];

//               }

               
                }
      
        
      
        
        
}

}
- (void )lessSecondToDay:(NSUInteger)seconds :(UILabel *)lab
{
    
    
    
    
//    NSUInteger day  = (NSUInteger)seconds/(24*3600);
    NSUInteger hour = (NSUInteger)seconds/(3600);
    NSUInteger min  = (NSUInteger)(seconds)%3600/60;
    NSUInteger second = (NSUInteger)(seconds%60);
    
    NSString *hourStr = [NSString stringWithFormat:@"%lu",hour];
     NSString *minStr = [NSString stringWithFormat:@"%lu",min];
     NSString *secondStr = [NSString stringWithFormat:@"%lu",second];
    
    NSString *time = [NSString stringWithFormat:@"抢单剩余 %lu时%lu分%lu秒",(unsigned long)hour,(unsigned long)min,(unsigned long)second];
    
   
    lab.text = time;
    [self setfwb:lab :hourStr.length :minStr.length :secondStr.length];
    
   
 
}



-(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format

{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format];

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];

    [formatter setTimeZone:timeZone];

    //将字符串按formatter转成nsdate

    NSDate* date = [formatter dateFromString:formatTime];

    //时间转时间戳的方法:

    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];

   

    return timeSp;

}



-(NSInteger)getNowTimestamp

{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];

    //设置时区,这个对于时间的处理有时很重要

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];

    [formatter setTimeZone:timeZone];

    //现在时间

    NSDate *datenow = [NSDate date];



    //时间转时间戳的方法:

    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];

  
    return timeSp;

}


-(void)setfwb:(UILabel *)las :(NSInteger)hour :(NSInteger)min :(NSUInteger )sec{
    
    NSString *str = las.text;
    
    if (str == nil) {
        
        return;
    }
        
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    //给富文本添加属性1-字体大小

    
    if (5 + hour >str.length) {
        return;
    }
    
    
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor redColor]
                          range:NSMakeRange(5,hour)];
    
    if (6+hour + min >str.length) {
           return;
       }
    
    [attributedStr addAttribute:NSForegroundColorAttributeName
                            value:[UIColor redColor]
                            range:NSMakeRange(6+hour,min)];
    
    
    if (7+hour + min + sec >str.length) {
        return;
    }
    
    [attributedStr addAttribute:NSForegroundColorAttributeName
                               value:[UIColor redColor]
                               range:NSMakeRange(7+hour + min,sec)];
    
    
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
