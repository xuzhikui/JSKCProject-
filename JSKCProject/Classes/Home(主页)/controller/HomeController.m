//
//  HomeController.m
//  JSKCProject
//
//  Created by XHJ on 2020/9/17.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "HomeController.h"
#import "SourceListCell.h"
#import "SelectCell.h"
#import "AddressVC.h"
#import "MoreView.h"
#import "SourceGoodController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "TestViewController.h"
#import "WQCodeScanner.h"
#import "MeassListController.h"
#import "ScanViewController.h"
#import "ConsignmentListController.h"
#import "AVCodeController.h"
#import "AddCarNewViewController.h"
#import "ReceOrderView.h"
#import "LoginController.h"
#import "AlertUpdateVersionView.h"

#define DefaultLocationTimeout 10
#define DefaultReGeocodeTimeout 5
@interface HomeController ()<UITableViewDelegate,UITableViewDataSource,AMapLocationManagerDelegate>
{
    
    UIView *backVC;
    NSArray *butArray;
    AddressVC *addressVC;
    AddressVC *unAddressVC;
    MoreView *moerVC;
    NSString *lo;
    NSString *lat;
     NSString *citys;
    NSTimer *timer;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIButton *distanceBut;///距离
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;

@property(nonatomic,strong)UIButton *dischargeBut;///卸货地
@property(nonatomic,strong)UIButton *screenBut;///筛选
@property(nonatomic,strong)UIButton *addressBut;///地址
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UITableView *distanceTable;
@property(nonatomic,strong)NSString * distanceCode;///距离状态 0//未弹出选择页  1已经弹出选择页
@property(nonatomic,strong)UIButton *SMAction;
@property(nonatomic,strong)NSString * code;///控制backvc
@property(nonatomic,strong)NSArray *distanceArray;
@property(nonatomic,strong)NSMutableArray *postDataArray;///总数据数组
@property(nonatomic,strong)NSString * adressCode;///装货地状态 0//未弹出选择页  1已经弹出选择页
@property(nonatomic,strong)NSString * unadressCode;///装货地状态 0//未弹出选择页  1已经弹出选择页
@property(nonatomic,assign)NSInteger  time;
@property(nonatomic,strong)NSMutableArray *timearr;
@property(nonatomic,strong)NSArray *loadPlacesArray;
@property(nonatomic,strong)NSArray *unloadPlacesArray;
@property(nonatomic,strong)NSArray *loadAarray;
@property(nonatomic,strong)NSArray *unloadAarray;
@property(nonatomic,strong)NSArray *moerArray;
@property(nonatomic,strong)NSMutableArray *moerSelectArray;
@property(nonatomic,strong)NSMutableArray *timeArray;
///装货地字符串
@property(nonatomic,strong)NSString *loadPlace;
///卸货地字符串
@property(nonatomic,strong)NSString *unloadPlace;
//locationManager;
///装货记录
@property(nonatomic,strong)NSString *pickDistance;

@property(nonatomic,strong)NSString *mjCode;

@property(nonatomic,strong)UIView *imageVC;
@property(nonatomic,strong)NSDictionary *cityDIc;


@property(nonatomic,strong)NSString *postCode;
@end

@implementation HomeController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.tabBarController.tabBar.hidden = NO;
  
    if (@available(iOS 13.0, *)) {

           UITabBarAppearance *apperance= self.tabBarController.tabBar.standardAppearance;

           apperance.backgroundImage=[self imageWithColor:[UIColor whiteColor]];

          apperance.shadowImage = [self imageWithColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1]];

           self.tabBarController.tabBar.standardAppearance = apperance;

       } else {

           self.tabBarController.tabBar.backgroundImage = [self imageWithColor:[UIColor whiteColor]];

           self.tabBarController.tabBar.shadowImage = [self imageWithColor:COLOR2(240)];

       };
    
    
    if (![LoactionModel shareInstance].lat) {
        
        self.postCode = @"1";
        [self gets];
    }else{
        if (self.cityDIc == nil) {
            self.postCode = @"1";
            [self gets];
        }
    }
    
    if (UserModel.shareInstance.type == 1) {
        [self.dataArray removeAllObjects];
        self.imageVC.hidden = NO;
        [self.table reloadData];
    }
    self.SMAction.hidden = UserModel.shareInstance.type == 1;
}


-(void)messAction{
    
    if ([UserModel shareInstance].accessToken == nil) {
//        if ([TXCommonUtils simSupportedIsOK] && [TXCommonUtils checkDeviceCellularDataEnable]) {
//            LoginController *logVC =  [LoginController new];
//            [self.navigationController pushViewController:logVC animated:YES];
//        }else{
//            PhoneLoginController *logVC =  [PhoneLoginController new];
////            logVC.code = @"1";
//            [self.navigationController pushViewController:logVC animated:YES];
//        }
        PhoneLoginController *logVC =  [PhoneLoginController new];
//            logVC.code = @"1";
        [self.navigationController pushViewController:logVC animated:YES];
        return;
    }
    
    MeassListController *meaVC = [MeassListController new];
    [self.navigationController pushViewController:meaVC animated:YES];
}

-(void)saoyisaoAction{
    
    if ([UserModel shareInstance].accessToken == nil) {
//        if ([TXCommonUtils simSupportedIsOK] && [TXCommonUtils checkDeviceCellularDataEnable]) {
//            LoginController *logVC =  [LoginController new];
//            [self.navigationController pushViewController:logVC animated:YES];
//        }else{
//            PhoneLoginController *logVC =  [PhoneLoginController new];
////            logVC.code = @"1";
//            [self.navigationController pushViewController:logVC animated:YES];
//        }
        PhoneLoginController *logVC =  [PhoneLoginController new];
//            logVC.code = @"1";
        [self.navigationController pushViewController:logVC animated:YES];
        return;
    }
    
    ScanViewController *saVC = [ScanViewController new];
    saVC.block = ^(NSString *info) {
        
        
        [self sysAvPostgoods:info];
        
//        NSString *str = [info substringToIndex:2];
//
//        if ([str isEqualToString:@"2-"] || [str isEqualToString:@"1-"]) {
//            ///正常
//            [self sysAvPostgoods:[info substringFromIndex:2]];
//
//        }else{
//            ///错误
//
////            [self.view addSubview:[Toast makeText:@"错误"]];
//
//        }
 
      
    };
    [self.navigationController pushViewController:saVC animated:YES];
     
//    WQCodeScanner *scanner = [[WQCodeScanner alloc] init];
//    [self.navigationController pushViewController:scanner animated:YES];
//    scanner.resultBlock = ^(NSString *value) {
//
//        NSLog(@"%@",value);
//
//        [self sysAvPostgoods:value];
////        /other/getCodeValue
//
////        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:value message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
////        [alertView show];
//    };
    
    
}
-(void)sysAvPostgoods:(NSString *)value{
    
    
//    [self.view addSubview:[Toast makeText:@"该订单不存在"]];
    
    [AFN_DF POST:@"/other/getCodeValue" Parameters:@{@"content":value} success:^(NSDictionary *responseObject) {

        
        NSDictionary *dic = responseObject[@"data"];
        
        NSString *type = [NSString stringWithFormat:@"%@",dic[@"type"]];
        
        if ([type isEqualToString:@"1"]) {
            ///详情
            SourceGoodController *sourVC = [SourceGoodController new];
            sourVC.dic = @{@"goodsSourceId":dic[@"content"]};
            [self.navigationController pushViewController:sourVC animated:YES];

        }else if ([type isEqualToString:@"2"]){
         ///列表
            ConsignmentListController *conVC = [ConsignmentListController new];
            conVC.goodID = dic[@"content"];
            [self.navigationController pushViewController:conVC animated:YES];
            
        }else if ([type isEqualToString:@"3"]){
        ///失效
            AVCodeController *codeVC = [AVCodeController new];
            codeVC.img = @"二维码失效";
            [self.navigationController pushViewController:codeVC animated:YES];
            
        }else if ([type isEqualToString:@"4"]){
        ///错误
            AVCodeController *codeVC = [AVCodeController new];
            codeVC.img = @"二维码错误";
            [self.navigationController pushViewController:codeVC animated:YES];
            
        }
        
       
        

    } failure:^(NSError *error) {

        NSLog(@"ssssssssss");
        
        
    }];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    ///获取地位
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(refreshData) name:RefreHomeDataNotification object:nil];
   
    [self initCompleteBlock];
    self.timeArray = [NSMutableArray array];
    self.mjCode = @"1";
    self.loadPlace = @"";
    self.unloadPlace = @"";
    self.pickDistance = @"1";
    self.time = 1000;
    self->lo = @"118.344990";
    self->lat =@"35.102785";
    self.view.backgroundColor = COLOR2(240);
//    [self getLocation];
//
    self.dataArray = [NSMutableArray array];
    self.distanceArray = @[@"装货距离",@"装货时间",@"发布时间",@"截止时间"];
    self.postDataArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"", nil];
    [self setUI];

    self.distanceCode = @"0";
    self.adressCode = @"0";
    self.unadressCode = @"0";
    
    
    WeakSelf
    [AFN_DF POST:@"/version/update/get" Parameters:nil success:^(NSDictionary *responseObject) {
        if ([responseObject[@"data"][@"iosOpen"] boolValue]) {
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            CFShow(CFBridgingRetain(infoDictionary));
            NSString *currentVersion = [NSString stringWithFormat:@"V%@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
            if (responseObject[@"data"][@"versionName"] && [responseObject[@"data"][@"iosVersionName"] isEqualToString:currentVersion]) {
                [weakSelf alertInfo];
            }else{
                StrongSelf
                [[AlertUpdateVersionView alertWithVersion:responseObject[@"data"][@"iosVersionName"] message:responseObject[@"data"][@"content"] handler:^(NSInteger actionIndex) {
                    if (actionIndex > 0) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://apps.apple.com/cn/app/id%@",responseObject[@"data"][@"iosAppId"]]] options:nil completionHandler:nil];
                    }
                    [strongSelf alertInfo];
                }]show];
            }
        }else{
            [weakSelf alertInfo];
        }
    } failure:^(NSError *error) {
        [weakSelf alertInfo];
    }];
}

- (void)alertInfo{
    WeakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([weakSelf.navigationController.topViewController isEqual:weakSelf]) {
            UserModel *userInfo = UserModel.shareInstance;
            if (userInfo.accessToken) {
                if (UserModel.shareInstance.cyrVerify == nil || [[NSString stringWithFormat:@"%@",userInfo.cyrVerify] isEqualToString:@"0"]){
                    InfoVC *infoVC = [[InfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                    infoVC.tag = 1;
                    [UIApplication.sharedApplication.keyWindow addSubview:infoVC];
                    return;
                }
                if (userInfo.hasBankCard == nil || [userInfo.hasBankCard integerValue] == 0) {
                    CardInfoVC *vc =  [[CardInfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                    vc.tag = 1;
                    [UIApplication.sharedApplication.keyWindow addSubview:vc];
                    return;
                }
                if (userInfo.type == 2) {
                    if(userInfo.bandTruckId == nil || [userInfo.bandTruckId integerValue] == 0){
                        VehicleInfoVC *deivc = [[VehicleInfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                        deivc.tag = 1;
                        [UIApplication.sharedApplication.keyWindow addSubview:deivc];
                    }
                }
            }
        }
    });
   
}

-(void)setUI{
    
    
    self.imageVC = [[UIImageView alloc]initWithFrame:CGRectMake((Width - 250)/2, Height/2 - 85, 250, 170)];
      [self.view addSubview:self.imageVC];
      
      UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 250, 170)];
      backImg.image = [UIImage imageNamed:@"货源占位图"];
      [self.imageVC addSubview:backImg];
      self.imageVC.hidden = YES;
    
    
    self.code = @"0";
    
    UIView *backVC = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 120)];
    backVC.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backVC];
    
    
    
    [UILabel initWithDFLable:CGRectMake(22, 43, Width, 30) :[UIFont boldSystemFontOfSize:22*Width1]:[UIColor blackColor] :
     @"货源":self.view :0];
    
    
    _SMAction = [UIButton initWithFrame:CGRectMake(Width - 90, 43, 30, 30) :@"saoyisao"];
    _SMAction.backgroundColor =[UIColor whiteColor];
    [_SMAction addTarget:self action:@selector(saoyisaoAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:self.SMAction];
    
    UIButton *messAction = [UIButton initWithFrame:CGRectMake(Width - 50, 43, 30, 30) :@"无消息"];
    messAction.backgroundColor =[UIColor whiteColor];
    [messAction addTarget:self action:@selector(messAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:messAction];
    
    
    self.distanceBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addressBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dischargeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.screenBut = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    NSArray *datasuArray = @[@"装货距离",@"装货地 ",@"卸货地 ",@"筛选  "];
    
    butArray = @[_distanceBut,_addressBut,_dischargeBut,_screenBut];
    for (int i = 0; i < 4; i++) {
        
        UIButton *but = butArray[i];
        but.frame = CGRectMake(8 + (Width/4 * i), 90, Width/4 - 16, 25);
        [but setTitle:datasuArray[i] forState:0];
        [backVC addSubview:but];
        but.titleLabel.font = [UIFont systemFontOfSize:13*Width1];
        [but setTitleColor:COLOR2(51) forState:0];
        but.tag = 1000 + i;
        [but addTarget:self action:@selector(butAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
       
        but.semanticContentAttribute =  UISemanticContentAttributeForceLeftToRight;
        [but setImage:[UIImage imageNamed:@"向下-1"] forState:0];
      
        
        UIImageView *fg = [[UIImageView alloc]initWithFrame:CGRectMake(Width/4 * i, 95, 1, 20)];
        fg.image  = [UIImage imageNamed:@"矩形 8"];
        [backVC addSubview:fg];
    
        
        NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:14*Width1]};
        
           CGFloat width = [datasuArray[i] boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
        [but setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        
        
       
        if (i == 0) {
            [but setImageEdgeInsets:UIEdgeInsetsMake(0, (Width/4 -20)/2 + width/2+ 5 , 0,  0)];
        }else{
            
            [but setImageEdgeInsets:UIEdgeInsetsMake(0, (Width/4 -20)/2 + width/2+ 10 , 0,  0)];
        }

    }
    
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 130, Width, Height - 120) style:(UITableViewStylePlain)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor = [UIColor clearColor];
    [self.table registerClass:[SourceListCell class] forCellReuseIdentifier:@"cell"];
    self.table.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    WeakSelf
    _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (UserModel.shareInstance.type == 1) {
            [weakSelf.table.mj_footer endRefreshing];
            return;
        }
        [self postData];
        
    }];
    
    _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (UserModel.shareInstance.type == 1) {
            [weakSelf.table.mj_header endRefreshing];
            return;
        }
        self.mjCode = @"0";
        self.dataArray =[NSMutableArray array];
        [self  postData];
    }];
    
    ///开始定时器倒计时
//      _timearr = [NSMutableArray arrayWithObjects:@"1200",@"1100",@"1300",@"1600", nil];
//    [self startTimer];

}

-(void)butAction:(UIButton *)but{
    
    if (UserModel.shareInstance.type == 1) {
        return;
    }
     
    for (int i = 0; i < butArray.count; i++) {
        
        UIButton *but1 = butArray[i];
        
        [but1 setImage:[UIImage imageNamed:@"向下-1"] forState:0];
           [but1 setTitleColor:[UIColor blackColor] forState:0];
    }
    [but setImage:[UIImage imageNamed:@"向下-2"] forState:0];
      [but setTitleColor:[UIColor redColor] forState:0];
    [self.distanceTable removeFromSuperview];
    [backVC removeFromSuperview];
    
    
        
         backVC = [[UIView alloc]initWithFrame:CGRectMake(0, 120, Width, Height -120)];
           backVC.backgroundColor = [UIColor blackColor];
           backVC.alpha = 0.35;
    UITapGestureRecognizer *TapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapGR)];
            backVC.userInteractionEnabled = YES;
           [ backVC addGestureRecognizer:TapGR];
            [self.view addSubview:backVC];
            self.tabBarController.tabBar.hidden = YES;
        
        

    if (but.tag == 1000) {
        
        self.code = @"0";
        [self distAction];
        
    }else if(but.tag == 1001){
        self.code = @"1";
        backVC.frame = CGRectMake(0, 0, Width, Height);
        [self addressAction];
        
    }else if(but.tag == 1002){
        self.code = @"2";
         backVC.frame = CGRectMake(0, 0, Width, Height);
        [self discharAction];
        
    }else{
        self.code = @"3";
         backVC.frame = CGRectMake(0, 0, Width, Height);
        [self screenAction];
    }

    
}

///装货距离
-(void)distAction{
    
    
//    if (self.distanceTable != nil) {
//
//        return;
//    }
    
    
    if ([self.distanceCode isEqualToString:@"0"]) {
          [self setdistTables];
    }else{
        
        [UIView animateWithDuration:0.2 animations:^{
                  
                    self.distanceTable.frame = CGRectMake(0, 120, 0, 0);
                [self.distanceTable removeFromSuperview];
            [self.distanceBut setImage:[UIImage imageNamed:@"向下-1"] forState:0];
          [self.distanceBut setTitleColor:[UIColor blackColor] forState:0];
            self.tabBarController.tabBar.hidden = NO;
                }];
        self.distanceCode = @"0";
     
        [backVC removeFromSuperview];
        
    }
    
  
    
}
///装货地
-(void)addressAction{
  
//    self.adressCode = @"0";
//    [backVC removeFromSuperview];
    
    if ([self.adressCode isEqualToString:@"0"]) {
        ///弹出选择弹窗
        
        addressVC  = [[AddressVC alloc]initWithFrame:CGRectMake(0, 120, Width, Height - 110)];
        addressVC.backgroundColor = [UIColor whiteColor];
        addressVC.layer.cornerRadius = 8;
        addressVC.listArray = self.loadPlacesArray;
        addressVC.layer.masksToBounds = YES;
        addressVC.cityDic = self.cityDIc;
        addressVC.code = @"0";
        addressVC.vc = backVC;
        __weak HomeController *weakSelf = self;
        addressVC.block = ^(NSArray * _Nonnull arr) {
             weakSelf.tabBarController.tabBar.hidden = NO;
            weakSelf.loadAarray = arr;
             NSString *loadPlace = @"";
            for (int i = 0; i <arr.count; i ++) {
                
                if (i == 0) {
                  
                    loadPlace = [NSString stringWithFormat:@"%@",arr[i][@"id"]];
                }else{
                    
                     loadPlace = [NSString stringWithFormat:@"%@,%@",loadPlace,arr[i][@"id"]];
                    
                }
                
            }
            
                weakSelf.loadPlace = loadPlace;
                weakSelf.dataArray = [NSMutableArray array];
                    [self->timer invalidate];
                    self->timer = nil;
                [weakSelf postData];
            
            
            [self.addressBut setImage:[UIImage imageNamed:@"向下-1"] forState:0];
            [self.distanceBut setTitleColor:[UIColor blackColor] forState:0];
            
        };
        
        
        
        addressVC.czblock = ^(NSArray * _Nonnull arr) {
            weakSelf.loadPlace = @"";
             weakSelf.tabBarController.tabBar.hidden = NO;
            weakSelf.loadAarray = [NSMutableArray array];
            weakSelf.dataArray = [NSMutableArray array];
                    [self->timer invalidate];
                    self->timer = nil;
                    [weakSelf postData];
            
            
          [self.addressBut setImage:[UIImage imageNamed:@"向下-1"] forState:0];
                   [self.distanceBut setTitleColor:[UIColor blackColor] forState:0];
                       
           
        };
        
        
        if (self.loadAarray.count != 0) {
            
            addressVC.selectCollArray = [NSMutableArray arrayWithArray:self.loadAarray];
        }
        
        [self.view addSubview:addressVC];
        
        
//           [self setdistTables];
     }else{
         
         [UIView animateWithDuration:0.2 animations:^{
                   
//                     self.distanceTable.frame = CGRectMake(0, 120, 0, 0);
//                 [self.distanceTable removeFromSuperview];
             [self.addressBut setImage:[UIImage imageNamed:@"向下-1"] forState:0];
           [self.distanceBut setTitleColor:[UIColor blackColor] forState:0];
                     
                 }];
         self.adressCode = @"0";
     ;
         [backVC removeFromSuperview];
         
         [_addressBut setImage:[UIImage imageNamed:@"向下-1"] forState:0];
                   [_addressBut setTitleColor:[UIColor blackColor] forState:0];
         
     }
    
    
    
}
///卸货地
-(void)discharAction{
    
     if ([self.unadressCode isEqualToString:@"0"]) {
            ///弹出选择弹窗
            
         unAddressVC  = [[AddressVC alloc]initWithFrame:CGRectMake(0, 120, Width, Height - 110)];
          unAddressVC.backgroundColor = [UIColor whiteColor];
          unAddressVC.layer.cornerRadius = 8;
          unAddressVC.listArray = self.unloadPlacesArray;
          unAddressVC.layer.masksToBounds = YES;
           unAddressVC.vc = backVC;
         unAddressVC.cityDic = self.cityDIc;
            __weak HomeController *weakSelf = self;
           unAddressVC.block = ^(NSArray * _Nonnull arr) {
                  weakSelf.tabBarController.tabBar.hidden = NO;
                weakSelf.unloadAarray = arr;
               NSString *unloadPlace = @"";
                          for (int i = 0; i <arr.count; i ++) {
                              
                            if (i == 0) {
                                
                            unloadPlace = [NSString stringWithFormat:@"%@",arr[i][@"id"]];
                              }else{
                                  
                    unloadPlace = [NSString stringWithFormat:@"%@,%@",unloadPlace,arr[i][@"id"]];
                                  
                        }
                              
                          }
                          
                          weakSelf.unloadPlace = unloadPlace;
               
                                            weakSelf.dataArray = [NSMutableArray array];
                                            [self->timer invalidate];
                                            self->timer = nil;
               
               [weakSelf.dischargeBut setImage:[UIImage imageNamed:@"向下-1"] forState:0];
                                        [weakSelf.dischargeBut setTitleColor:[UIColor blackColor] forState:0];
               
                                            [weakSelf postData];
            };
         
         unAddressVC.czblock = ^(NSArray * _Nonnull arr) {
             
                    weakSelf.tabBarController.tabBar.hidden = NO;
                      weakSelf.unloadAarray = [NSMutableArray array];
                    weakSelf.unloadPlace = @"";
             
                    weakSelf.dataArray = [NSMutableArray array];
                        [self->timer invalidate];
                        self->timer = nil;
             
             
                          [weakSelf.dischargeBut setImage:[UIImage imageNamed:@"向下-1"] forState:0];
                            [weakSelf.dischargeBut setTitleColor:[UIColor blackColor] forState:0];
                          
                            [weakSelf postData];
             
         
         };
            
         
         
         
         
            if (self.unloadAarray.count != 0) {
                
                unAddressVC.selectCollArray = [NSMutableArray arrayWithArray:self.unloadAarray];
            }
            
//
//
            [self.view addSubview:unAddressVC];
            
            
    //           [self setdistTables];
         }else{
             
             [UIView animateWithDuration:0.2 animations:^{
                       
    //
                 [self.dischargeBut setImage:[UIImage imageNamed:@"向下-1"] forState:0];
               [self.dischargeBut setTitleColor:[UIColor blackColor] forState:0];
                         
                     }];
             self.adressCode = @"0";
         ;
             [backVC removeFromSuperview];
         
             
         }
    [_distanceBut setImage:[UIImage imageNamed:@"向下-1"] forState:0];
     [_distanceBut setTitleColor:[UIColor blackColor] forState:0];
    
}
///筛选
-(void)screenAction{
    
            moerVC  = [[MoreView alloc]initWithFrame:CGRectMake(0, 120, Width, Height - 110)];
            moerVC.backgroundColor = [UIColor whiteColor];
            moerVC.dataArray = self.moerArray;
                moerVC.layer.cornerRadius = 8;
                moerVC.vc = backVC;
    __weak HomeController *weakSelf = self;
        moerVC.block = ^(NSMutableArray * _Nonnull arr) {
         weakSelf.tabBarController.tabBar.hidden = NO;
        weakSelf.moerSelectArray = arr;
            [weakSelf.screenBut setImage:[UIImage imageNamed:@"向下-1"] forState:0];
            [weakSelf.screenBut setTitleColor:[UIColor blackColor] forState:0];
            weakSelf.dataArray = [NSMutableArray array];
            [self->timer invalidate];
            self->timer = nil;
            [weakSelf postData];
          
        };
    moerVC.czblock = ^(NSMutableArray * _Nonnull arr) {
        weakSelf.tabBarController.tabBar.hidden = NO;
              weakSelf.moerSelectArray = [NSMutableArray array];
        
        [weakSelf.screenBut setImage:[UIImage imageNamed:@"向下-1"] forState:0];
        [weakSelf.screenBut setTitleColor:[UIColor blackColor] forState:0];
         weakSelf.dataArray = [NSMutableArray array];
                  [self->timer invalidate];
                  self->timer = nil;
                  [weakSelf postData];
    };
    
    
    
        moerVC.selectArray = self.moerSelectArray;
        [self.view addSubview:moerVC];
    
    
       
    
}

/////装货地
//-(void)addressTsbles{
//
//
//
//}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (tableView.tag == 1001) {
        return self.distanceArray.count;
    }else{
        
        return self.dataArray.count;
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!(tableView.tag == 1001)) {
        SourceListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
           cell.backgroundColor = [UIColor whiteColor];
        cell.layer.cornerRadius = 4;
        cell.layer.masksToBounds = YES;
        if (indexPath.row < self.dataArray.count) {

            cell.dic = self.dataArray[indexPath.row];
            cell.indexPath = indexPath;
            }
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        WeakSelf
        [cell setGrabAnOrderBlock:^(NSIndexPath * _Nonnull indexPath) {
            id info = weakSelf.dataArray[indexPath.row];
            if (UserModel.shareInstance.accessToken == nil) {
//                if ([TXCommonUtils simSupportedIsOK] && [TXCommonUtils checkDeviceCellularDataEnable]) {
//                    LoginController *logVC =  [LoginController new];
//                    [self.navigationController pushViewController:logVC animated:YES];
//                }else{
//                    PhoneLoginController *logVC =  [PhoneLoginController new];
//                    [self.navigationController pushViewController:logVC animated:YES];
//                }
                PhoneLoginController *logVC =  [PhoneLoginController new];
                [self.navigationController pushViewController:logVC animated:YES];
                return;
            }
            if (UserModel.shareInstance.cyrVerify == nil || [[NSString stringWithFormat:@"%@",UserModel.shareInstance.cyrVerify] isEqualToString:@"0"]){
                InfoVC *infoVC = [[InfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                infoVC.tag = 1;
                [UIApplication.sharedApplication.keyWindow addSubview:infoVC];
                return;
            }
            if (UserModel.shareInstance.type == 2) {
                if(UserModel.shareInstance.bandTruckId == nil || [UserModel.shareInstance.bandTruckId integerValue] == 0){
                    VehicleInfoVC *deivc = [[VehicleInfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                    deivc.tag = 1;
                    [UIApplication.sharedApplication.keyWindow addSubview:deivc];
                    return;
                }
            }
            [AFN_DF POST:@"/tsmanage/goodssource/robOrderBefor" Parameters:nil success:^(NSDictionary *responseObject) {
                NSString *result = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"result"]];
                if ([result isEqualToString:@"1"]) {
                    ///经纪人未绑卡
                    CardInfoVC *vc =  [[CardInfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                    vc.tag = 1;
                    [UIApplication.sharedApplication.keyWindow addSubview:vc];

                }else if([result isEqualToString:@"2"]){
                   ///司机未绑卡
                    CardInfoVC *deivc = [[CardInfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                    deivc.tag = 1;
                    [UIApplication.sharedApplication.keyWindow addSubview:deivc];
                }else if([result isEqualToString:@"0"]){
                    ///正常
                  ReceOrderView *vc = [[ReceOrderView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
//                  vc.dic = self.carDic;
//                    vc.data = self.data;
                  vc.gsId = info[@"goodsSourceId"];
                    vc.tag = 1;
                  [UIApplication.sharedApplication.keyWindow addSubview:vc];
                    
                }
            } failure:^(NSError *error) {

            }];
        }];
           return cell;
    }else{
        
        SelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
           cell.backgroundColor = [UIColor whiteColor];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titStr = self.distanceArray[indexPath.row];
            cell.layer.cornerRadius = 4;
               cell.layer.masksToBounds = YES;
        cell.seleSt =  self.postDataArray[0];
           return cell;
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!(tableView.tag == 1001)) {
      return 223;
    }else{
        
      return 50;
    }
   
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
        UserModel *userInfo = [UserModel shareInstance];

    if (!(tableView.tag == 1001)) {
        if ([[NSString stringWithFormat:@"%@",userInfo.cyrVerify] isEqualToString:@"0"]) {
            InfoVC *infoVC = [[InfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
            infoVC.tag = 1;
            [UIApplication.sharedApplication.keyWindow addSubview:infoVC];
            return;
        }
        if (UserModel.shareInstance.type == 2) {
            if (userInfo.bandTruckId == nil || [userInfo.bandTruckId integerValue] == 0) {
                VehicleInfoVC *infoVC = [[VehicleInfoVC alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
                infoVC.tag = 1;
                [UIApplication.sharedApplication.keyWindow addSubview:infoVC];
                return;
            }
        }
        
        
        if (userInfo.hasBankCard == nil || [userInfo.hasBankCard integerValue] == 0){
            CardInfoVC *cardInfoVC = [[CardInfoVC alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
            cardInfoVC.tag = 1;
            [UIApplication.sharedApplication.keyWindow addSubview:cardInfoVC];
            return;
        }
        
        SourceGoodController *sourceVC = [SourceGoodController new];
        sourceVC.dic = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:sourceVC animated:YES];

       }else{


           self.distanceCode = @"0";
            [backVC removeFromSuperview];
           [self.distanceTable removeFromSuperview];

           self.postDataArray[0] = self.distanceArray[indexPath.row];
           self.pickDistance = [NSString stringWithFormat:@"%ld",(long)indexPath.row + 1];
        [self.distanceBut setImage:[UIImage imageNamed:@"向下-1"] forState:0];
             [self.distanceBut setTitleColor:[UIColor blackColor] forState:0];


                    self.dataArray = [NSMutableArray array];
                        [self->timer invalidate];
                        self->timer = nil;
                        [self postData];
          self.tabBarController.tabBar.hidden = NO;

       }


    }
    
}


-(void)setdistTables{
    
  if (self.distanceTable != nil) {
    
      [self.distanceTable removeFromSuperview];
     }
        
            self.code =@"0";
            self.distanceCode = @"1";
            self.distanceTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, 0, 0) style:(UITableViewStylePlain)];
            self.distanceTable.delegate = self;
            self.distanceTable.dataSource = self;
          self.distanceTable.tag = 1001;
            self.distanceTable.backgroundColor = COLOR2(240);
            [ self.distanceTable registerClass:[SelectCell class] forCellReuseIdentifier:@"cellID"];
             self.distanceTable.separatorStyle =UITableViewCellSeparatorStyleNone;
          [self.view addSubview:self.distanceTable];
        
              [UIView animateWithDuration:0.2 animations:^{
            
              self.distanceTable.frame = CGRectMake(0, 120, Width, 200);
              
          }];
   
//    [self.distanceTable ];
    
}


-(void)onTapGR{
    
     self.tabBarController.tabBar.hidden = NO;
    
    for (int i = 0; i < butArray.count; i++) {
        
        UIButton *but1 = butArray[i];
        
        [but1 setImage:[UIImage imageNamed:@"向下-1"] forState:0];
           [but1 setTitleColor:[UIColor blackColor] forState:0];
    }
    [backVC removeFromSuperview];
    self.distanceCode = @"0";
    NSInteger code = self.code.intValue;
    
    switch (code) {
            case 0:
            
            [self.distanceTable removeFromSuperview];
            break;
            case 1:
            [addressVC removeFromSuperview];
            break;
            case 2:
            [unAddressVC removeFromSuperview];
            break;
            case 3:
            [moerVC removeFromSuperview];
            break;
            
        default:
            break;
    }
    
    
}



-(void)gets{
    
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
//    设置期望定位精度
       [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
   
       //设置不允许系统暂停定位
       [self.locationManager setPausesLocationUpdatesAutomatically:NO];
   
       //设置允许在后台定位
       [self.locationManager setAllowsBackgroundLocationUpdates:YES];
   
       //设置定位超时时间
       [self.locationManager setLocationTimeout:DefaultLocationTimeout];
   
       //设置逆地理超时时间
       [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
   
       [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
    
        //进行单次带逆地理定位请求
        [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
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
-(void)mapViewRequireLocationAuth:(CLLocationManager *)locationManager

{

    if (@available(iOS 13.0, *)) {

        [locationManager requestWhenInUseAuthorization];

    } else {

        [locationManager requestAlwaysAuthorization];

    }

}
///
-(void)postData{
      NSString *searchType = @"";
    

    for ( int i = 0;  i < self.moerArray.count; i++) {
        
        if (i == 0) {
             searchType = [NSString stringWithFormat:@"%@:",self.moerArray[i][@"type"]];
        }else{
            
             searchType = [NSString stringWithFormat:@"%@%@:",searchType,self.moerArray[i][@"type"]];
        }
        
        if (i < 3) {
            NSString *ids = @"";
            if (self.moerSelectArray.count > i) {
                NSDictionary *dic = self.moerSelectArray[i];
                           
                           if (dic[@"id"]) {
                               ids =dic[@"id"];
                }
            }
            
          searchType = [NSString stringWithFormat:@"%@%@",searchType,ids];
        }else{
            NSArray *arr;
            if (self.moerSelectArray.count > i) {
                arr = self.moerSelectArray[i];
            }
                   
                for (int j = 0; j < arr.count; j++) {
                       
                    if (j == 0) {
                          searchType = [NSString stringWithFormat:@"%@%@",searchType,arr[j][@"id"]];
                    }else{
                        
                          searchType = [NSString stringWithFormat:@"%@,%@",searchType,arr[j][@"id"]];
                    }
            }
       
    }

        if (i != self.moerArray.count - 1) {
            
             searchType = [NSString stringWithFormat:@"%@#",searchType];
        }
        
        }

    
    
    
    
    
    
    NSDictionary *dic = @{
        @"loadPlace":self.loadPlace,
        @"localItude":[NSString stringWithFormat:@"%@,%@",[LoactionModel shareInstance].lo,[LoactionModel shareInstance].lat],
        @"pageNum":self.mjCode,
        @"pageSize":@"15",
        @"pickDistance":self.pickDistance,
        @"searchType":searchType,
        @"unloadPlace":self.unloadPlace,
    };
    
   NSLog(@"%@", [UserModel shareInstance].accessToken);
    
    [AFN_DF POST:@"/tsmanage/goodssource/get" Parameters:dic success:^(NSDictionary *responseObject) {
        
         
        
        NSArray *arr = responseObject[@"data"][@"list"];
        
        for (int i = 0; i < arr.count; i++) {
            [self.dataArray addObject:arr[i]];
        }
        
        
        if (arr.count < 15) {
            [self.table.mj_header endRefreshing];
            [self.table.mj_footer endRefreshing];
             [self.table.mj_footer endRefreshingWithNoMoreData];
//
        }else{
            
             self.mjCode = [NSString stringWithFormat:@"%d",self.mjCode.intValue + 1];
                [self.table.mj_header endRefreshing];
                [self.table.mj_footer endRefreshing];
        }
        
        
   
        [self.table reloadData];
        
        if (self.dataArray.count == 0) {
            
            self.imageVC.hidden = NO;
        }else{
             self.imageVC.hidden = YES;
        }
        
        
        [self startTimer];
        
    } failure:^(NSError *error) {
        
    }];
    
    
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

-(void)getplaceAddress{
    
    NSDictionary *dic = @{@"localItude":[NSString stringWithFormat:@"%@,%@",[LoactionModel shareInstance].lo,[LoactionModel shareInstance].lat]};
    WeakSelf
    [AFN_DF POST:@"/tsmanage/goodssource/getgssloadandunload" Parameters:dic success:^(NSDictionary *responseObject) {
            
            weakSelf.loadPlacesArray = responseObject[@"data"][@"loadPlaces"];
        weakSelf.unloadPlacesArray = responseObject[@"data"][@"unloadPlaces"];
        weakSelf.cityDIc = responseObject[@"data"][@"city"];
            NSDictionary *dic = @{@"lo":self->lo,@"lat":self->lat,@"city":responseObject[@"data"][@"city"][@"place"]};
            [[LoactionModel shareInstance]setValuesForKeysWithDictionary:dic];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)getMoerData{
    
    
    
    [AFN_DF POST:@"/tsmanage/goodssource/getGssScreen" Parameters:nil success:^(NSDictionary *responseObject) {
        
        self.moerArray = responseObject[@"data"];
        
    } failure:^(NSError *error) {
        
    }];
    
    
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



- (UIImage *)imageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0, 0, 1, 0.5);

    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);

    [color setFill];

    UIRectFill(rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return image;

}
#pragma mark - Initialization

- (void)initCompleteBlock
{
//    __weak TestViewController *weakSelf = self;
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        if (error != nil && error.code == AMapLocationErrorLocateFailed)
        {
            //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"定位错误:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }
        else if (error != nil
                 && (error.code == AMapLocationErrorReGeocodeFailed
                     || error.code == AMapLocationErrorTimeOut
                     || error.code == AMapLocationErrorCannotFindHost
                     || error.code == AMapLocationErrorBadURL
                     || error.code == AMapLocationErrorNotConnectedToInternet
                     || error.code == AMapLocationErrorCannotConnectToHost))
        {
            //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
            NSLog(@"逆地理错误:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        else if (error != nil && error.code == AMapLocationErrorRiskOfFakeLocation)
        {
            //存在虚拟定位的风险：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }
        else
        {
            //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
            self->lo =  [NSString stringWithFormat:@"%f",location.coordinate.longitude];
                        self->lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
                        NSDictionary *dic = @{@"lo":self->lo,@"lat":self->lat,@"city":@""};
                        [[LoactionModel shareInstance]setValuesForKeysWithDictionary:dic];
            if (UserModel.shareInstance.type == 1) {
                self.imageVC.hidden = NO;
                return;
            }
            if ([self.postCode isEqualToString:@"1"]) {
                [self getplaceAddress];
                    [self postData];
                   [self getMoerData];
                self.postCode = @"2";
            }
            
               
        }
        

        if (regeocode)
        {
                                self->citys =regeocode.city;
                          self->lo =  [NSString stringWithFormat:@"%f",location.coordinate.longitude];
                          self->lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
                            NSDictionary *dic = @{@"lo":self->lo,@"lat":self->lat,@"city":self->citys};
                          [[LoactionModel shareInstance]setValuesForKeysWithDictionary:dic];
        }
        else
        {
          
        }
    };
}

#pragma mark - AMapLocationManager Delegate

- (void)amapLocationManager:(AMapLocationManager *)manager doRequireLocationAuth:(CLLocationManager *)locationManager
{
    [locationManager requestAlwaysAuthorization];
}

- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
    self.completionBlock = nil;
}

- (void)refreshData{
    if (UserModel.shareInstance.type == 2) {
        if (self.dataArray.count == 0) {
            [self.table.mj_header beginRefreshing];
        }
    }
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
