//
//  SourceGoodController.m
//  JSKCProject
//
//  Created by XHJ on 2020/9/21.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "SourceGoodController.h"
#import "SourceCell.h"
#import <AMapNaviKit/MAMapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import "SelectCarView.h"
#import "BindMasterView.h"
#import "ReceOrderView.h"
#import "OrSuccessController.h"
#import "DriverbankView.h"
#import "AgentView.h"
@interface SourceGoodController ()<UITableViewDelegate,UITableViewDataSource,MAMapViewDelegate,AMapNaviDriveManagerDelegate,   AMapNaviDriveViewDelegate,AMapNaviCompositeManagerDelegate>
{
     UIView *backVC;
    SelectCarView *carVC;
      NSTimer *timer;

}
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UITableView *addresstable;
@property(nonatomic,strong)AMapNaviPoint *startPoint;
@property(nonatomic,strong)AMapNaviPoint *endPoint;
@property(nonatomic,strong)MAMapView *mapView;
@property(nonatomic,strong)AMapNaviDriveView *driveView;
@property(nonatomic,strong)AMapNaviCompositeManager *compositeManager;
@property(nonatomic,strong)BindMasterView *bindVC;
@property(nonatomic,strong)UIButton *selectCarBut;
@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,strong)UILabel *addressLab;
@property(nonatomic,strong)UILabel *addNameLab;
@property(nonatomic,strong)UILabel *unaddressLab;
@property(nonatomic,strong)UILabel *unaddNameLab;
@property(nonatomic,strong)UILabel *addisLab;
@property(nonatomic,strong)UILabel *unaddisLab;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSArray *carListArray;
@property(nonatomic,strong)UILabel *price;
@property(nonatomic,strong)NSArray *translateArray;
@property(nonatomic,strong)UIButton *orderBut;
@property(nonatomic,strong)UIScrollView *mainView;
///需要绑定车辆的id
@property(nonatomic,strong)NSDictionary *carDic;
///绑定code
@property(nonatomic,strong)NSString *bindCode;
@property(nonatomic,strong)NSString *viewcode;
@property(nonatomic,strong)UIImageView *overtoImg;
@property(nonatomic,strong) UIImageView *starttoImg;
@property(nonatomic,assign)NSInteger times;

///运输车辆
@property(nonatomic,strong)UILabel *carNameLab;

@end

@implementation SourceGoodController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
        self.tabBarController.tabBar.hidden = YES;
      [self.navigationController setNavigationBarHidden:NO animated:YES];

}



- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStyleDone) target:self action:@selector(back)];
    
    
     self.viewcode = @"0";
    self.bindCode = @"0";
    self.startPoint = [AMapNaviPoint locationWithLatitude:39.99 longitude:116.47];
       self.endPoint   = [AMapNaviPoint locationWithLatitude:39.90 longitude:116.32];
    
    ///检测经纪人和司机是否绑定银行卡
   
    self.title = @"货源详情";
    self.view.backgroundColor = COLOR2(240);
    [self postData];
    ///选择车辆数据
    [self getCarList];
    ///选择司机列表
//    [self gettranslateList];
    [self setUI];
    
    
//
    
    
}



-(void)back{
    if ([self.typeCode isEqualToString:@"2"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(void)setUI{
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, NavaBarHeight)];
    bgView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:bgView];

    UIView *addressVC = [[UIView alloc]initWithFrame:CGRectMake(10, 10, Width - 20 ,210)];
    addressVC.backgroundColor = [UIColor whiteColor];
    addressVC.layer.cornerRadius = 4;
    [self.mainView addSubview:addressVC];
    
    UIImageView *startImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 21, 21)];
    startImg.image = [UIImage imageNamed:@"装货-1"];
    [addressVC addSubview:startImg];
    
    self.addressLab = [UILabel initWithDFLable:CGRectMake(45, 20.5, Width - 60, 20) :[UIFont systemFontOfSize:16*Width1] :[UIColor blackColor] :@"" :addressVC :0];
    self.addNameLab = [UILabel initWithDFLable:CGRectMake(45, 45, 200, 20) :[UIFont systemFontOfSize:14*Width1] :[UIColor grayColor] :@"" :addressVC :0];
    
    self.starttoImg = [[UIImageView alloc]initWithFrame:CGRectMake(180, 48.5, 14, 13)];
       self.starttoImg.image = [UIImage imageNamed:@"电话-11"];
//    starttoImg.backgroundColor = [UIColor redColor];
    [addressVC addSubview:self.starttoImg];
    
    
UITapGestureRecognizer *TapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userPhoneAction)];
    self.starttoImg.userInteractionEnabled = YES;
      [self.starttoImg addGestureRecognizer:TapGR];
    
    
    
     UIImageView *overImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 83, 21, 21)];
        overImg.image = [UIImage imageNamed:@"卸载-1"];
        [addressVC addSubview:overImg];
        
    self.unaddressLab =  [UILabel initWithDFLable:CGRectMake(45, 83.5, Width - 60, 20) :[UIFont systemFontOfSize:16*Width1] :[UIColor blackColor] :@"" :addressVC :0];
        
    self.unaddNameLab =  [UILabel initWithDFLable:CGRectMake(45, 109, 200, 20) :[UIFont systemFontOfSize:14*Width1] :[UIColor grayColor] :@"" :addressVC :0];
        
        self.overtoImg = [[UIImageView alloc]initWithFrame:CGRectMake(180, 112.5, 14, 13)];
          self.overtoImg.image = [UIImage imageNamed:@"电话-01 拷贝"];
    //    starttoImg.backgroundColor = [UIColor redColor];
           [addressVC addSubview:self.overtoImg];
    UITapGestureRecognizer *TapGR1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loasPhoneAction)];
    self.overtoImg.userInteractionEnabled = YES;
          [self.overtoImg addGestureRecognizer:TapGR1];
    
    
    
    
        UIView *fg = [[UIView alloc]initWithFrame:CGRectMake(30, 45, 1, 25)];
        fg.backgroundColor = COLOR2(220);
        [addressVC addSubview:fg];
    
            UIView *fg1 = [[UIView alloc]initWithFrame:CGRectMake(0, 141, Width - 20, 1)];
            fg1.backgroundColor = COLOR2(220);
            [addressVC addSubview:fg1];
    
    
    self.addisLab = [UILabel initWithDFLable:CGRectMake(0, 160, addressVC.frame.size.width/3, 20) :[UIFont systemFontOfSize:14*Width1] :[UIColor blackColor] :@"" :addressVC :1];
    
    [UILabel initWithDFLable:CGRectMake(0, 180, addressVC.frame.size.width/3, 20) :[UIFont systemFontOfSize:12*Width1] :[UIColor grayColor] :@"距离装货地约" :addressVC :1];
    
    
    
    self.unaddisLab = [UILabel initWithDFLable:CGRectMake(addressVC.frame.size.width/3, 160, addressVC.frame.size.width/3, 20) :[UIFont systemFontOfSize:14*Width1] :[UIColor blackColor] :@"" :addressVC :1];
       
           [UILabel initWithDFLable:CGRectMake(addressVC.frame.size.width/3, 180, addressVC.frame.size.width/3, 20) :[UIFont systemFontOfSize:11*Width1] :[UIColor grayColor] :@"距离运输总路程" :addressVC :1];
    
    CGFloat wid = addressVC.frame.size.width;
    UIButton *addressBut =  [UIButton initWithFrame:CGRectMake(wid *0.666 +  (wid/3 - 80)/2, 167.5, 80, 25) :@"查看地图" :11*Width1];
    addressBut.layer.cornerRadius = 4;
    addressBut.layer.borderColor = [[UIColor redColor]CGColor];
    addressBut.layer.borderWidth = 1;
    [addressBut setTitleColor:[UIColor redColor] forState:0];
    [addressBut setImage:[UIImage imageNamed:@"导航-1"] forState:0];
    [addressBut addTarget:self action:@selector(startDhAction) forControlEvents:(UIControlEventTouchUpInside)];
    [addressBut setImageEdgeInsets:UIEdgeInsetsMake(0, 60 , 0,  0)];
    [addressBut setTitleEdgeInsets:UIEdgeInsetsMake(0, 0 , 0,  20)];
    [addressVC addSubview:addressBut];
    
    
    
    UIView *addressTabVC = [[UIView alloc]initWithFrame:CGRectMake(10,230, Width - 20, 90)];
    addressTabVC.backgroundColor = [UIColor whiteColor];
    addressTabVC.layer.cornerRadius = 4;
    addressVC.layer.masksToBounds = YES;
    [self.mainView addSubview:addressTabVC];
    
    
        self.addresstable = [[UITableView alloc]initWithFrame:CGRectMake(10,10, Width - 20,70) style:(UITableViewStylePlain)];
        self.addresstable.delegate = self;
        self.addresstable.dataSource = self;
        self.addresstable.backgroundColor = [UIColor clearColor];
        [self.addresstable registerClass:[SourceCell class] forCellReuseIdentifier:@"cell"];
        self.addresstable.separatorStyle =UITableViewCellSeparatorStyleNone;
        self.addresstable.scrollEnabled = NO;
        [addressTabVC addSubview:self.addresstable];
    
        UIView *TabVC = [[UIView alloc]initWithFrame:CGRectMake(10, 330, Width - 20, 200)];
       TabVC.backgroundColor = [UIColor whiteColor];
       TabVC.layer.cornerRadius = 4;
       TabVC.layer.masksToBounds = YES;
       [self.mainView addSubview:TabVC];

    
        self.table = [[UITableView alloc]initWithFrame:CGRectMake(10,12.5, Width - 20, 175) style:(UITableViewStylePlain)];
        self.table.delegate = self;
        self.table.dataSource = self;
        self.table.tag = 1001;
        self.table.scrollEnabled = NO;
        self.table.userInteractionEnabled = NO;
        self.table.layer.cornerRadius = 10;
        self.table.backgroundColor = [UIColor whiteColor];
        [self.table registerClass:[SourceCell class] forCellReuseIdentifier:@"cell"];
        self.table.separatorStyle =UITableViewCellSeparatorStyleNone;
        [TabVC addSubview:self.table];

            UIView *tabBarVC = [[UIView alloc]initWithFrame:CGRectMake(0, Height - 88, Width, 88)];
            tabBarVC.backgroundColor = [UIColor whiteColor];
            tabBarVC.layer.cornerRadius = 4;
            [self.view addSubview:tabBarVC];
    [UILabel initWithDFLable:CGRectMake(15, 10, 65, 20) :[UIFont systemFontOfSize:14*Width1] :[UIColor blackColor] :@"运费价格:" :tabBarVC :0];
    self.carNameLab = [UILabel initWithDFLable:CGRectMake(82.5, 5, 200, 30) :[UIFont systemFontOfSize:14*Width1] :COLOR(245, 12, 12) :@"运输车辆:" :tabBarVC :0];
    
    
//    UIView *fg2 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, Width - 20, 1)];
//    fg2.backgroundColor = COLOR2(220);
//    [tabBarVC addSubview:fg2];
//
//    _selectCarBut = [UIButton initWithFrame:CGRectMake(Width - 160, 0, 100, 50) :@"请选择运输车辆" :13*Width1];
//    [_selectCarBut setTitleColor:[UIColor redColor] forState:0];
//    _selectCarBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [_selectCarBut addTarget:self action:@selector(seleCarAction) forControlEvents:(UIControlEventTouchUpInside)];
//    [tabBarVC addSubview:_selectCarBut];
    
//
//    UIButton *selectCarImgBut = [UIButton initWithFrame:CGRectMake(Width - 55,19.5, 5, 11) :@"向下-11"];
//       [selectCarImgBut setTitleColor:[UIColor redColor] forState:0];
//       [tabBarVC addSubview:selectCarImgBut];
//
//
//     self.price = [UILabel initWithDFLable:CGRectMake(20, 51, 200, 79) :[UIFont systemFontOfSize:14*Width1] :[UIColor redColor] :@"" :tabBarVC :0];
//
    
    self.orderBut = [UIButton initWithFrame:CGRectMake(10, 40, Width-20, 38) :@"立即抢单" :15*Width1];
     self.orderBut.backgroundColor = COLOR(245, 12, 12);
     self.orderBut.layer.cornerRadius = 4;
    [self.orderBut addTarget:self action:@selector(orderButAction) forControlEvents:(UIControlEventTouchUpInside)];
//     self.orderBut.userInteractionEnabled = NO;
        [tabBarVC addSubview:self.orderBut];
    
      
    
    
    
}

-(void)seleCarAction{
     [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
        if (backVC != nil) {
          
          [backVC removeFromSuperview];
        }
    
 

        backVC = [[UIView alloc]initWithFrame:CGRectMake(0, -NavaBarHeight, Width, Height + NavaBarHeight)];
           backVC.backgroundColor = [UIColor blackColor];
            backVC.alpha = 0.35;
                    UITapGestureRecognizer *TapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapGR)];
                    backVC.userInteractionEnabled = YES;
           [ backVC addGestureRecognizer:TapGR];
           [self.view addSubview:backVC];
            self.tabBarController.tabBar.hidden = YES;
        
    
    
            carVC = [[SelectCarView alloc]initWithFrame:CGRectMake(0, NavaBarHeight, Width, Height - NavaBarHeight)];
            carVC.backgroundColor = [UIColor whiteColor];
            carVC.layer.cornerRadius = 8;
                carVC.dataArray = [NSMutableArray arrayWithArray:self.carListArray];
            __weak SourceGoodController *weakSelf = self;
    
                carVC.selectblock = ^(NSDictionary * _Nonnull dic) {
            weakSelf.carDic = dic;
           [self->backVC removeFromSuperview];
          [self.navigationController setNavigationBarHidden:NO animated:YES];
                    self.carNameLab.text = [NSString stringWithFormat:@"%@%@",self.dic[@"freight"],self.dic[@"freightType"]];
//                    [self carNamesetfwb:self.carNameLab];
//            [weakSelf.selectCarBut setTitle:@"更换车辆" forState:0];
//           [weakSelf.selectCarBut setTitleColor:[UIColor redColor] forState:0];
            self.orderBut.userInteractionEnabled = YES;
            self.orderBut.backgroundColor = COLOR(245, 12, 12);
                    
                    [self onTapGR];
                    
    };
    carVC.bindblock = ^(NSDictionary * _Nonnull dic) {
        
          weakSelf.carDic = dic;
          [weakSelf.bindVC removeFromSuperview];
        
        [weakSelf addsubView];

    };
    
 
    
    [self.view addSubview:carVC];
    

}

-(void)addsubView{
    
    
        [carVC removeFromSuperview];
                       
  self.bindVC = [[BindMasterView alloc]initWithFrame:CGRectMake(0, NavaBarHeight, Width, Height - NavaBarHeight)];
       self.bindVC.backgroundColor = [UIColor whiteColor];
    self.bindVC.dataArray = [NSMutableArray arrayWithArray:self.translateArray];
 
       self.bindVC.layer.cornerRadius = 8;
    
    __weak SourceGoodController *weakSelf = self;
        self.bindVC.block = ^(NSDictionary * _Nonnull dic) {
             
            [weakSelf postbindOrUnbindDriver:dic];
            
            
         };
    
       [self.view addSubview:self.bindVC];

}

-(void)startDhAction{
    
    
    self.compositeManager = [[AMapNaviCompositeManager alloc] init];
    // 如果需要使用AMapNaviCompositeManagerDelegate的相关回调（如自定义语音、获取实时位置等），需要设置delegate
    self.compositeManager.delegate = self;
    // 通过present的方式显示路线规划页面, 在不传入起终点启动导航组件的模式下，options需传入nil
//    [self.compositeManager presentRoutePlanViewControllerWithOptions:nil];
    
 
    AMapNaviCompositeUserConfig *config = [[AMapNaviCompositeUserConfig alloc] init];
    //传入终点坐标
//    [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:[AMapNaviPoint locationWithLatitude:39.918058 longitude:116.397026] name:@"故宫" POIId:nil];
    //启动
//    [self.compositeManager presentRoutePlanViewControllerWithOptions:config];
    
    
    //设置导航的起点和终点
    self.startPoint = [AMapNaviPoint locationWithLatitude:[LoactionModel shareInstance].lat.floatValue longitude:[LoactionModel shareInstance].lo.floatValue];
    
    
      NSArray *arr =  [self.dic[@"loadPlaceOrigins"] componentsSeparatedByString:@","];
    NSString  *lat = arr.lastObject;
     NSString  *lon = arr.firstObject;
    self.endPoint   = [AMapNaviPoint locationWithLatitude:lat.floatValue longitude:lon.floatValue];

    
    
    [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:self.endPoint name:self.data[@"loadPlaceDetail"]  POIId:nil];
    
    

    //设置车辆信息
    AMapNaviVehicleInfo *info = [[AMapNaviVehicleInfo alloc] init];
//    info.vehicleId = @"京N66Y66"; //设置车牌号
    info.type = 1;              //设置车辆类型,0:小车; 1:货车. 默认0(小车).
//  
    [config setVehicleInfo:info];

    [self.compositeManager presentRoutePlanViewControllerWithOptions:config];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 1001) {
        
        return 5;
    }else{
         return 2;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        SourceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (tableView.tag == 1001) {
         cell.dic = self.dataArray[indexPath.row + 2];
      
        }else{
            cell.dic = self.dataArray[indexPath.row];
        
        }
    
        return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 35;
    
}



///装货地
-(void)userPhoneAction{
  
    NSString *sendContactPhone = self.data[@"sendContactPhone"];
    
    [[UIApplication   sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",sendContactPhone]]];
    

    
}

///卸货地
-(void)loasPhoneAction{
    NSString *receiveContactPhone = self.data[@"receiveContactPhone"];
    [[UIApplication   sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",receiveContactPhone]]];
}

- (void)dealloc
{
    [[AMapNaviDriveManager sharedInstance] stopNavi];
    [[AMapNaviDriveManager sharedInstance] removeDataRepresentative:self.driveView];
    [[AMapNaviDriveManager sharedInstance] setDelegate:nil];
    
    BOOL success = [AMapNaviDriveManager destroyInstance];
    NSLog(@"单例是否销毁成功 : %d",success);
    
}

-(void)postData{
    
   
     
    [AFN_DF POST:@"/tsmanage/goodssource/getGSDetails" Parameters:@{@"id":self.dic[@"goodsSourceId"],@"localItude":[NSString stringWithFormat:@"%@,%@",[LoactionModel shareInstance].lat,[LoactionModel shareInstance].lo]} success:^(NSDictionary *responseObject) {
        
        
        self.data = responseObject[@"data"];
        [self dataSoursAction];
        
        self.dataArray = @[
              @{ @"tit":@"装货时间", @"value":self.data[@"planPickTime"]},
              @{ @"tit":@"卸货时间",@"value":self.data[@"planArrivalTime"]},
              @{ @"tit":@"货物名称",@"value":self.data[@"goods"]},
              @{ @"tit":@"货物重量",@"value":[NSString stringWithFormat:@"%@",self.data[@"planLoad"]]},
              @{ @"tit":@"车型要求",@"value":self.data[@"truck"]},
              @{ @"tit":@"合理货损",@"value":[NSString stringWithFormat:@"%@%",self.data[@"soundLosston"]]},
               @{@"tit":@"剩余时间", @"value":@""},
        ];
        
            [self.table reloadData];
            [self.addresstable reloadData];
          
          
        
        
            [self startTimer];
        
    } failure:^(NSError *error) {
        
        
        
    }];
    
}

-(void)dataSoursAction{
    
   
    self.addNameLab.text =[NSString stringWithFormat:@"%@  %@",self.data[@"contactName"],self.data[@"sendContactPhone"]];
    self.addressLab.text = self.data[@"loadPlaceDetail"];
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:14*Width1]};
         CGFloat width = [self.addNameLab.text boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
    
    self.unaddressLab.text = self.data[@"unloadPlaceDetail"];
    self.unaddNameLab.text = [NSString stringWithFormat:@"%@  %@",self.data[@"receiveContactName"],self.data[@"receiveContactPhone"]];
    
    NSDictionary *attrs1 = @{NSFontAttributeName:[UIFont systemFontOfSize:14*Width1]};
         CGFloat width1 = [ self.unaddNameLab.text boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs1 context:nil].size.width;
    
    
    self.addisLab.text =self.dic[@"localDistanceStr"];
    self.unaddisLab.text = self.data[@"distanceStr"];
    self.carNameLab.text = [NSString stringWithFormat:@"%@%@",self.dic[@"freight"],self.dic[@"freightType"]];
//    [self carNamesetfwb:self.price];
    self.addNameLab.frame = CGRectMake(45, 45, width, 20);
    self.unaddNameLab.frame = CGRectMake(45, 109, width1, 20);
    self.starttoImg.frame = CGRectMake(50 + width, 48.5, 14, 13);
    self.overtoImg.frame = CGRectMake(50 + width1, 112.5, 14, 13);

}


///立即抢单

-(void)orderButAction{
    
    
    
  
    
//    OrSuccessController *orDec = [OrSuccessController new];
////         orDec.dic = dic;
//        [[AFN_DF topViewController].navigationController pushViewController:orDec animated:YES];
    
    
//
//    if (self.carDic == nil) {
//
//        return [self.view addSubview:[Toast makeText:@"请您先选择车辆"]];
//    }
//
    [self postbank];
    
}

-(void)postbank{
    
    [AFN_DF POST:@"/tsmanage/goodssource/robOrderBefor" Parameters:nil success:^(NSDictionary *responseObject) {
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        NSString *result = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"result"]];
        
        if ([result isEqualToString:@"1"]) {
            ///经纪人未绑卡
            
            CardInfoVC *vc =  [[CardInfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
            [self.view addSubview:vc];
            
            
            
        }else if([result isEqualToString:@"2"]){
           ///司机未绑卡
            CardInfoVC *deivc = [[CardInfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
            [self.view addSubview:deivc];
        }else if([result isEqualToString:@"0"]){
            ///正常
           
          ReceOrderView *vc = [[ReceOrderView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
          vc.dic = self.carDic;
            vc.data = self.data;
          vc.gsId = self.data[@"goodsSourceId"];
          [self.view addSubview:vc];
        }
        
     
   
      
        
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


///获取选择车辆列表
-(void)getCarList{
    
    
    [AFN_DF POST:@"/system/truck/trucks" Parameters:nil success:^(NSDictionary *responseObject) {
        
        self.carListArray = responseObject[@"data"];
        if ([self.bindCode isEqualToString:@"1"]) {
            
            [self gettranslateList];
        }
        
        
    } failure:^(NSError *error) {
        
    }];

}

///获取司机列表
-(void)gettranslateList{
    
    [AFN_DF POST:@"/system/driver/drivers" Parameters:nil success:^(NSDictionary *responseObject) {
          
          self.translateArray = responseObject[@"data"];
          
        if ([self.bindCode isEqualToString:@"1"]) {
            
                        [self seleCarAction];
                        self.bindCode = @"0";
        }
        
        
      } failure:^(NSError *error) {
          
      }];
    
    
}

-(void)onTapGR{
    
    
    [backVC removeFromSuperview];
    [carVC removeFromSuperview];
    [self.bindVC removeFromSuperview];
     [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)postbindOrUnbindDriver:(NSDictionary *)dic{
    
    
    
    NSDictionary *dict = @{
        @"bindType":@"1",
        @"driverId":dic[@"id"],
        @"truckId":self.carDic[@"truckId"],
        @"type":@"1",
    };
    
    [AFN_DF POST:@"/system/truck/bindOrUnbindDriver" Parameters:dict success:^(NSDictionary *responseObject) {
        
        self.bindCode = @"1";
        [self getCarList];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


-(UIScrollView *)mainView{
    
    if (_mainView == nil) {
        
        _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NavaBarHeight, Width, Height-UISafeAreaBottomHeight-NavaBarHeight)];
        _mainView.contentSize = CGSizeMake(0, 670);
        _mainView.bounces = NO;
        _mainView.backgroundColor = COLOR2(240);
        _mainView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_mainView];
    }
    
    return _mainView;
}

- (void)startTimer
{
    
    
    
            self.times = [self.data[@"remainTime"] integerValue]/1000;
            timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshLessTime) userInfo:@"" repeats:YES];

    //如果不添加下面这条语句，在UITableView拖动的时候，会阻塞定时器的调用
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
 
}

- (void)refreshLessTime
{


    NSString *code = [NSString stringWithFormat:@"%@",self.data[@"longterm"]];
           if ([code isEqualToString:@"0"]) {


                   NSInteger time =  self.times;
                    SourceCell *cell = (SourceCell *)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
                  [self lessSecondToDay:--time:cell.titleLab];
               self.times = time;


               }else{
                 SourceCell *cell = (SourceCell *)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
                 cell.titleLab.text = @"剩余时间: 此货源 长期货源";
                [self setfwbcell:cell.titleLab];
               [self->timer invalidate];
                self->timer = nil;
               
               
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
    
    NSString *time = [NSString stringWithFormat:@"抢单剩余时间: %lu时%lu分%lu秒",(unsigned long)hour,(unsigned long)min,(unsigned long)second];
    
   
    lab.text = time;
    
    if ([self.viewcode isEqualToString:@"0"]) {
        
              [LSProgressHUD hideForView:self.view];
                self.viewcode = @"1";
    }
    
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
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    //给富文本添加属性1-字体大小
//        [attributedStr addAttribute:NSFontAttributeName
//                              value:[UIFont systemFontOfSize:14*Width1]
//                              range:NSMakeRange(0, 3)];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor redColor]
                          range:NSMakeRange(8,hour)];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName
                            value:[UIColor redColor]
                            range:NSMakeRange(9+hour,min)];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName
                               value:[UIColor redColor]
                               range:NSMakeRange(10+hour + min,sec)];
    
    
    las.attributedText = attributedStr;
//    las.textAlignment = YES;
    
   
    
}


-(void)setfwbcell:(UILabel *)las{
    
    NSString *str = las.text;
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    //给富文本添加属性1-字体大小
//        [attributedStr addAttribute:NSFontAttributeName
//                              value:[UIFont systemFontOfSize:14*Width1]
//                              range:NSMakeRange(0, 3)];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor redColor]
                          range:NSMakeRange(las.text.length - 4,4)];
    
  
    
    
    las.attributedText = attributedStr;
//    las.textAlignment = YES;
    
   
    
}



-(void)carNamesetfwb:(UILabel *)las{
    
    NSString *str = las.text;
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    //给富文本添加属性1-字体大小

    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor grayColor]
                          range:NSMakeRange(0, 5)];
    
    
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
