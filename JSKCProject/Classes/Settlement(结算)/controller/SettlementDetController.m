//
//  SettlementDetController.m
//  JSKCProject
//
//  Created by XHJ on 2020/12/25.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "SettlementDetController.h"
#import "SourceCell.h"
#import "EndSendWayVC.h"
#import "CanlWayView.h"
#import "EndINWayView.h"
#import "WayRecordController.h"
#import "SelectCarView.h"
#import "BindMasterView.h"
#import "WayCanlVC.h"
#import <AMapNaviKit/MAMapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import "ComplaintController.h"
#import "AddCompController.h"
#import "SuppCommController.h"
@interface SettlementDetController ()<UITableViewDelegate,UITableViewDataSource,MAMapViewDelegate,AMapNaviDriveManagerDelegate,   AMapNaviDriveViewDelegate,AMapNaviCompositeManagerDelegate>
{
     UIView *backVC;
    SelectCarView *carVC;
      NSTimer *timer;

}
@property(nonatomic,strong)UILabel *addressLab;
@property(nonatomic,strong)UILabel *addNameLab;
@property(nonatomic,strong)UILabel *unaddressLab;
@property(nonatomic,strong)UILabel *unaddNameLab;
@property(nonatomic,strong)UILabel *addisLab;
@property(nonatomic,strong)UILabel *unaddisLab;
@property(nonatomic,strong)UIScrollView *mainView;
@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UITableView *addresstable;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSArray *carListArray;
@property(nonatomic,strong)UILabel *price;
@property(nonatomic,strong)NSArray *translateArray;
@property(nonatomic,strong)NSString *bindCode;
@property(nonatomic,strong)NSDictionary *carDic;
@property(nonatomic,strong)BindMasterView *bindVC;
@property(nonatomic,strong)UILabel *carLab;
@property(nonatomic,strong)UIImageView *starttoImg;
@property(nonatomic,strong)UIImageView *overtoImg;
@property(nonatomic,strong)NSString *viewcode;
@property(nonatomic,strong)AMapNaviPoint *startPoint;
@property(nonatomic,strong)AMapNaviPoint *endPoint;
@property(nonatomic,strong)MAMapView *mapView;
@property(nonatomic,strong)AMapNaviDriveView *driveView;
@property(nonatomic,strong)AMapNaviCompositeManager *compositeManager;
@property(nonatomic,strong)UIButton *phoneBut;
@property(nonatomic,strong)UIButton *tsBut;
@end

@implementation SettlementDetController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = YES;
   

    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStyleDone) target:self action:@selector(back)];
       self.viewcode = @"0";
    [self postDet];
     [self setUI];
    self.dataArray = [NSMutableArray array];
    self.bindCode = @"0";
    ///选择车辆数据
//    [self getCarList];
    ///选择司机列表
//    [self gettranslateList];
    
    
    self.title = @"运单详情";
}



-(void)setUI{
    UIView *navigtionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, NavaBarHeight)];
    navigtionView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:navigtionView];
      
   UIView *numVC =  [[UIView alloc]initWithFrame:CGRectMake(10,10, Width - 20, 40)];
    numVC.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:numVC];
    
    UIImageView *timeImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39, Width - 20, 1)];
     timeImg.image = [UIImage imageNamed:@"线 拷贝"];
    [numVC addSubview:timeImg];
    

    UILabel *timeLab = [UILabel initWithDFLable:CGRectMake(10,10,Width - 50, 20) :[UIFont systemFontOfSize:15*Width1] :[UIColor redColor] :[NSString stringWithFormat:@"订单号: %@",self.dic[@"waybillId"]] :numVC :0];
        [self setfwb:timeLab];
  
    

    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:15*Width1]};
    
    CGFloat width = [timeLab.text boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
    
    timeLab.frame = CGRectMake(10, 10, width, 20);
   
    
    UIButton *copyBut =[UIButton initWithFrame:CGRectMake(15 + width, 5, 30, 30) :@"复制"];
    [copyBut addTarget:self action:@selector(copyAction) forControlEvents:(UIControlEventTouchUpInside)];
    [numVC addSubview:copyBut];
    
     NSDictionary *attrs1 = @{NSFontAttributeName:[UIFont systemFontOfSize:14*Width1]};
    CGFloat widths = [@"运单记录" boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs1 context:nil].size.width;
      
    
    
    
    UIButton *lookWayBut =[UIButton initWithFrame:CGRectMake(Width - 140, 5, 120, 30) :@"运单记录":14*Width1];
    [lookWayBut setImage:[UIImage imageNamed:@"向上"] forState:0];
    [lookWayBut setTitleColor:[UIColor redColor] forState:0];
    [lookWayBut addTarget:self action:@selector(lookWayButAction) forControlEvents:(UIControlEventTouchUpInside)];
    [lookWayBut setImageEdgeInsets:UIEdgeInsetsMake(0, widths/2 + lookWayBut.frame.size.width/2 + 5, 0, 0)];
   lookWayBut.contentHorizontalAlignment = 0;
       [numVC addSubview:lookWayBut];
    
    

    
      UIView *addressVC = [[UIView alloc]initWithFrame:CGRectMake(10, 50, Width - 20 ,210)];
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
    UITapGestureRecognizer *TapGR1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loasPhoneAction)];
    self.overtoImg.userInteractionEnabled = YES;
          [self.overtoImg addGestureRecognizer:TapGR1];
    
    
    [addressVC addSubview:self.overtoImg];
        
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
    
    
        UIView *addressTabVC = [[UIView alloc]initWithFrame:CGRectMake(10,270, Width - 20, 90)];
       addressTabVC.backgroundColor = [UIColor whiteColor];
       addressTabVC.layer.cornerRadius = 4;
       addressVC.layer.masksToBounds = YES;
       [self.mainView addSubview:addressTabVC];
       
       
           self.addresstable = [[UITableView alloc]initWithFrame:CGRectMake(10,10, Width - 20,70) style:(UITableViewStylePlain)];
           self.addresstable.delegate = self;
           self.addresstable.dataSource = self;
            self.addresstable.scrollEnabled = NO;
           self.addresstable.backgroundColor = [UIColor clearColor];
           [self.addresstable registerClass:[SourceCell class] forCellReuseIdentifier:@"cell"];
           self.addresstable.separatorStyle =UITableViewCellSeparatorStyleNone;
           [addressTabVC addSubview:self.addresstable];
       
           UIView *TabVC = [[UIView alloc]initWithFrame:CGRectMake(10, 370, Width - 20, 165)];
          TabVC.backgroundColor = [UIColor whiteColor];
          TabVC.layer.cornerRadius = 4;
          TabVC.layer.masksToBounds = YES;
          [self.mainView addSubview:TabVC];

       
           self.table = [[UITableView alloc]initWithFrame:CGRectMake(10,12.5, Width - 20, 140) style:(UITableViewStylePlain)];
           self.table.delegate = self;
           self.table.dataSource = self;
           self.table.tag = 1001;
           self.table.layer.cornerRadius = 10;
            self.table.scrollEnabled = NO;
           self.table.backgroundColor = [UIColor whiteColor];
           [self.table registerClass:[SourceCell class] forCellReuseIdentifier:@"cell"];
           self.table.separatorStyle =UITableViewCellSeparatorStyleNone;
           [TabVC addSubview:self.table];
    
                NSString *state = [NSString stringWithFormat:@"%@",self.dic[@"verify"]];
           
   
        
       
        UIView *tabbarVC = [[UIView alloc]initWithFrame:CGRectMake(0, Height - 60, Width, 60)];
        tabbarVC.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:tabbarVC];
        
    
    
    
    [UILabel initWithDFLable:CGRectMake(20, 20, 40, 20) :[UIFont systemFontOfSize:16*Width1] :[UIColor grayColor] :@"运费" :tabbarVC :0];
    
    [UILabel initWithDFLable:CGRectMake(60, 20, 120, 20) :[UIFont systemFontOfSize:22*Width1] :[UIColor orangeColor] :[NSString stringWithFormat:@"%@元",self.dic[@"freight"]] :tabbarVC :0];
    
    
    
    
    
    
    
    
    
    
    if ([state isEqualToString:@"0"]){

        
        [UILabel initWithDFLable:CGRectMake(Width - 120, 20, 80, 20) :[UIFont systemFontOfSize:14*Width1] :[UIColor orangeColor] :@"待结算" :tabbarVC :2];
        
    }else if ([state isEqualToString:@"1"] || [state isEqualToString:@"2"]){
        
    
        [UILabel initWithDFLable:CGRectMake(Width - 120, 20, 80, 20) :[UIFont systemFontOfSize:14*Width1] :[UIColor orangeColor] :@"付款审核中" :tabbarVC :2];
     
        
    }else if ([state isEqualToString:@"3"] || [state isEqualToString:@"5"]){
        
        [UILabel initWithDFLable:CGRectMake(Width - 120, 20, 80, 20) :[UIFont systemFontOfSize:14*Width1] :[UIColor orangeColor] :@"审核失败" :tabbarVC :2];
    
        
    }else if ([state isEqualToString:@"8"]){
        
        [UILabel initWithDFLable:CGRectMake(Width - 120, 20, 80, 20) :[UIFont systemFontOfSize:14*Width1] :[UIColor orangeColor] :@"打款失败" :tabbarVC :2];
}else if ([state isEqualToString:@"4"]){
    
    
    [UILabel initWithDFLable:CGRectMake(Width - 120, 20, 80, 20) :[UIFont systemFontOfSize:14*Width1] :[UIColor orangeColor] :@"待付款" :tabbarVC :2];
}else if ([state isEqualToString:@"6"]){
    
    ///已结清
    _tsBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _tsBut.frame =CGRectMake(self.view.frame.size.width - 170, 170, 60, 25);
    [ _tsBut setTitle:@"投诉" forState:0];
    [ _tsBut setTitleColor:[UIColor redColor] forState:0];
    _tsBut.titleLabel.font = [UIFont systemFontOfSize:11*Width1];
    _tsBut.hidden = YES;
    [ _tsBut addTarget:self action:@selector(tsActrion) forControlEvents:(UIControlEventTouchUpInside)];
    _tsBut.layer.cornerRadius = 4;
    _tsBut.backgroundColor = [UIColor whiteColor];
    _tsBut.layer.borderColor = [[UIColor redColor]CGColor];
    _tsBut.layer.borderWidth = 1;
    
    
    _phoneBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _phoneBut.frame =CGRectMake(self.view.frame.size.width - 100, 170, 60, 25);
    [_phoneBut setTitle:@"评价" forState:0];
    [_phoneBut setTitleColor:[UIColor whiteColor] forState:0];
    _phoneBut.titleLabel.font = [UIFont systemFontOfSize:11*Width1];
       _phoneBut.hidden = NO;
    [_phoneBut addTarget:self action:@selector(suppcommActrion) forControlEvents:(UIControlEventTouchUpInside)];
      _phoneBut.layer.cornerRadius = 4;
    _phoneBut.backgroundColor = [UIColor redColor];
    
    
    NSString *sjEvaluated = [NSString stringWithFormat:@"%@",self.data[@"sjEvaluated"]];
    if (![sjEvaluated isEqualToString:@"0"]) {
        _phoneBut.layer.borderWidth = 0;
        _phoneBut.backgroundColor = [UIColor grayColor];
        _phoneBut.userInteractionEnabled = NO;
    }
    
    NSString *sjComplainted = [NSString stringWithFormat:@"%@",self.data[@"sjComplainted"]];
    if (![sjComplainted isEqualToString:@"0"]) {
        _tsBut.layer.borderWidth = 0;
        _tsBut.backgroundColor = [UIColor grayColor];
        _tsBut.userInteractionEnabled = NO;
        [_tsBut setTitleColor:[UIColor whiteColor] forState:0];
    }
    
    
    
}else if ([state isEqualToString:@"7"]){
    
    [UILabel initWithDFLable:CGRectMake(Width - 120, 20, 80, 20) :[UIFont systemFontOfSize:14*Width1] :[UIColor orangeColor] :@"付款审核中" :tabbarVC :2];
    
    
}
    

}




///评论

-(void)suppcommActrion{
    
    SuppCommController *suppVC = [SuppCommController new];
    suppVC.dic = self.dic;
    [[AFN_DF topViewController].navigationController pushViewController:suppVC animated:YES];
}

///投诉
-(void)tsActrion{
    
    AddCompController *compVC = [AddCompController new];
     compVC.wayDic = self.dic;
     [[AFN_DF topViewController].navigationController pushViewController:compVC animated:YES];
    
    
}
-(void)deleButAction{
      [self.navigationController setNavigationBarHidden:YES animated:YES];
    WayCanlVC *canVC = [[WayCanlVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
    canVC.bolock = ^(NSString * _Nonnull code) {
      
        [self postDelegate:self.data];
        
        
    };
     [self.view addSubview:canVC];
    
    
    
    
}


///删除运单
-(void)postDelegate:(NSDictionary *)code{
    
    
    [AFN_DF POST:@"/tsmanage/waybill/delete" Parameters:@{@"waybillId":code[@"waybillId"]} success:^(NSDictionary *responseObject) {
        
//            [self.view addSubview:[Toast makeText:@"删除成功"]];
//            [self.distanceArray removeObject:code];
//            [self.table reloadData];
           
    
        self.delectblock(self.dic);
        [self.navigationController popViewControllerAnimated:YES];
        
        
    } failure:^(NSError *error) {
        
    }];
    
  
    
}

///运单记录
-(void)lookWayButAction{
    
    
    WayRecordController *wayVC = [WayRecordController new];
    wayVC.dic = self.data;
    [self.navigationController pushViewController:wayVC animated:YES];
    
    
}

-(void)setend{
    
    
    
       _mainView.contentSize = CGSizeMake(0, 960);
    UIView *backVC  = [[UIView alloc]initWithFrame:CGRectMake(0, 545, Width, 230)];
          backVC.backgroundColor = [UIColor whiteColor];
          [self.mainView addSubview:backVC];
           
           
           [UILabel initWithDFLable:CGRectMake(20, 20, 200, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :@"发货信息" :backVC :0];
          
    UILabel *timeLab =  [UILabel initWithDFLable:CGRectMake(20, 60, Width - 40, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :[NSString stringWithFormat:@"实发时间: %@",self.data[@"actualPickTime"]] :backVC :0];
           
          [self setfwb:timeLab :5];
          
          
          
           UILabel *zlLab =  [UILabel initWithDFLable:CGRectMake(20, 90, 200, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :[NSString stringWithFormat:@"货车重量/体积: %@",[NSString stringWithFormat:@""]] :backVC :0];
            [self setfwb:zlLab  :8];
          
             UILabel *imgLab =  [UILabel initWithDFLable:CGRectMake(20, 120, 65, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :[NSString stringWithFormat:@"发货凭证: %@",[NSString stringWithFormat:@""]] :backVC :0];
           [self setfwb:imgLab  :5];
          
           UIImageView *imgVC = [[UIImageView alloc]initWithFrame:CGRectMake(85, 125, 144, 92)];
    [imgVC sd_setImageWithURL:[NSURL URLWithString:self.data[@"sendProof"]] placeholderImage:[UIImage imageNamed:@"发货凭证-1"]];
              [backVC addSubview:imgVC];
    
    UIView *backVC2  = [[UIView alloc]initWithFrame:CGRectMake(10, 785, Width - 20,170)];
          backVC2.backgroundColor = [UIColor whiteColor];
            backVC2.layer.cornerRadius = 4;
          [self.mainView addSubview:backVC2];
           
           
           [UILabel initWithDFLable:CGRectMake(20, 20, 200, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :@"承运信息" :backVC2 :0];
          
    UILabel *timeLab2 =  [UILabel initWithDFLable:CGRectMake(20, 60, Width - 40, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :[NSString stringWithFormat:@"车牌号: %@",self.data[@"carNumber"]] :backVC2 :0];
           
          [self setfwb:timeLab2 :4];
          
          
          
           UILabel *zlLab2 =  [UILabel initWithDFLable:CGRectMake(20, 90, 200, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :[NSString stringWithFormat:@"司机姓名: %@",self.data[@"driverName"]] :backVC2 :0];
            [self setfwb:zlLab2  :5];


    UILabel *zlLab3 =  [UILabel initWithDFLable:CGRectMake(20, 120, 200, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :[NSString stringWithFormat:@"司机电话: %@",self.data[@"driverPhone"]] :backVC2 :0];
     [self setfwb:zlLab3  :5];
    
}


-(void)endfwinfo{
    
    _mainView.contentSize = CGSizeMake(0, 1380);
     UIView *backVC  = [[UIView alloc]initWithFrame:CGRectMake(10, 545, Width - 20, 230)];
           backVC.backgroundColor = [UIColor whiteColor];
           [self.mainView addSubview:backVC];
            
            
            [UILabel initWithDFLable:CGRectMake(20, 20, 200, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :@"发货信息" :backVC :0];
           
     UILabel *timeLab =  [UILabel initWithDFLable:CGRectMake(20, 60, Width - 40, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :[NSString stringWithFormat:@"实发时间: %@",self.data[@"actualPickTime"]] :backVC :0];
            
           [self setfwb:timeLab :5];
           
           
           
    UILabel *zlLab =  [UILabel initWithDFLable:CGRectMake(20, 90, 200, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :[NSString stringWithFormat:@"货车重量/体积: %@吨",self.data[@"planLoad"]] :backVC :0];
             [self setfwb:zlLab  :8];
           
              UILabel *imgLab =  [UILabel initWithDFLable:CGRectMake(20, 120, 65, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :[NSString stringWithFormat:@"发货凭证: %@",[NSString stringWithFormat:@""]] :backVC :0];
            [self setfwb:imgLab  :5];
           
            UIImageView *imgVC = [[UIImageView alloc]initWithFrame:CGRectMake(85, 125, 144, 92)];
//               imgVC.backgroundColor = [UIColor yellowColor];
               [backVC addSubview:imgVC];
    [imgVC sd_setImageWithURL:[NSURL URLWithString:self.data[@"sendProof"]] placeholderImage:[UIImage imageNamed:@"发货凭证-1"]];
    
    
        UIView *backVC1  = [[UIView alloc]initWithFrame:CGRectMake(10, 785, Width - 20,350)];
              backVC1.backgroundColor = [UIColor whiteColor];
            backVC.layer.cornerRadius = 4;
        backVC1.layer.cornerRadius = 4;
              [self.mainView addSubview:backVC1];
               
               
               [UILabel initWithDFLable:CGRectMake(20, 20, 200, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :@"收货信息" :backVC1 :0];
              
        UILabel *timeLab1 =  [UILabel initWithDFLable:CGRectMake(20, 60, Width - 40, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :[NSString stringWithFormat:@"实发时间: %@",self.data[@"actualPickTime"]] :backVC1 :0];
               
              [self setfwb:timeLab1 :5];
              
              
              
               UILabel *zlLab1 =  [UILabel initWithDFLable:CGRectMake(20, 90, 200, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :[NSString stringWithFormat:@"货车重量/体积: %@吨",self.data[@"planLoad"]] :backVC1 :0];
                [self setfwb:zlLab1  :8];
              
                 UILabel *imgLab1 =  [UILabel initWithDFLable:CGRectMake(20, 120, 65, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :[NSString stringWithFormat:@"收货凭证: %@",[NSString stringWithFormat:@""]] :backVC1 :0];
               [self setfwb:imgLab1  :5];
              
               UIImageView *imgVC1 = [[UIImageView alloc]initWithFrame:CGRectMake(85, 125, 144, 92)];
//                  imgVC1.backgroundColor = [UIColor yellowColor];
                  [backVC1 addSubview:imgVC1];
    
      [imgVC1 sd_setImageWithURL:[NSURL URLWithString:self.data[@"receiveProof"]] placeholderImage:[UIImage imageNamed:@"发货凭证-1"]];
    
    
            UILabel *imgLab2 =  [UILabel initWithDFLable:CGRectMake(20, 235, 65, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :[NSString stringWithFormat:@"卸货图片: %@",[NSString stringWithFormat:@""]] :backVC1 :0];
                [self setfwb:imgLab2:5];
    
    
                UIImageView *imgVC2 = [[UIImageView alloc]initWithFrame:CGRectMake(85, 240, 144, 92)];
//                imgVC2.backgroundColor = [UIColor yellowColor];
                [backVC1 addSubview:imgVC2];
    
    [imgVC2 sd_setImageWithURL:[NSURL URLWithString:self.data[@"unloadPic"]] placeholderImage:[UIImage imageNamed:@"照片"]];
    
    
    UIView *backVC2  = [[UIView alloc]initWithFrame:CGRectMake(10, 1145, Width - 20,165)];
          backVC2.backgroundColor = [UIColor whiteColor];
            backVC2.layer.cornerRadius = 4;
          [self.mainView addSubview:backVC2];
           
           
           [UILabel initWithDFLable:CGRectMake(20, 20, 200, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :@"承运信息" :backVC2 :0];
          
    UILabel *timeLab2 =  [UILabel initWithDFLable:CGRectMake(20, 60, Width - 40, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :[NSString stringWithFormat:@"车牌号: %@",self.data[@"carNumber"]] :backVC2 :0];
           
          [self setfwb:timeLab2 :4];
          
          
          
           UILabel *zlLab2 =  [UILabel initWithDFLable:CGRectMake(20, 90, 200, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :[NSString stringWithFormat:@"司机姓名: %@",self.data[@"driverName"]] :backVC2 :0];
            [self setfwb:zlLab2  :5];


    UILabel *zlLab3 =  [UILabel initWithDFLable:CGRectMake(20, 120, 200, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :[NSString stringWithFormat:@"司机电话: %@",self.data[@"driverPhone"]] :backVC2 :0];
     [self setfwb:zlLab3  :5];
    
}





///确认到达
-(void)endinButAction{
    
       [[AFN_DF topViewController].navigationController setNavigationBarHidden:YES animated:YES];
            EndINWayView *inVC = [[EndINWayView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
            inVC.vc = self;
            inVC.dic = self.dic;
        inVC.block = ^(NSDictionary * _Nonnull dic) {
             self.block(self.dic);
             [self.navigationController popViewControllerAnimated:YES];
        };
            [self.view addSubview:inVC];
    
    
}

///取消运单
-(void)canlActrion{
//

     [[AFN_DF topViewController].navigationController setNavigationBarHidden:YES animated:YES];
    CanlWayView *wayVC = [[CanlWayView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
    wayVC.dic = self.data;
    wayVC.bolock = ^(NSDictionary * _Nonnull dic) {

        [self calnWayOrder:dic];
        
        
    };

    [self.view addSubview:wayVC];
    
    
}

-(void)calnWayOrder:(NSDictionary *)dic{
    
    
    
    
    NSDictionary *dict = @{
        
        @"waybillId":dic[@"waybillId"],
    };
    
    [AFN_DF POST:@"/tsmanage/waybill/cancel" Parameters:dict success:^(NSDictionary *responseObject) {
        
        
          self.block(self.dic);
        [self.navigationController popViewControllerAnimated:YES];
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}


///确认发货
-(void)endButAction{
    
    [[AFN_DF topViewController].navigationController setNavigationBarHidden:YES animated:YES];
    EndSendWayVC *endVC = [[EndSendWayVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
    endVC.vc = self;
    endVC.dic = self.dic;
    endVC.block = ^(NSDictionary * _Nonnull dic) {

            self.block(self.dic);
            [self.navigationController popViewControllerAnimated:YES];
        
    };
    endVC.tag = 1;
    [UIApplication.sharedApplication.keyWindow addSubview:endVC];
    

}


-(void)postDet{
    
    
    NSDictionary *dic = @{
        @"localItude":[NSString stringWithFormat:@"%@,%@",[LoactionModel shareInstance].lat,[LoactionModel shareInstance].lo],
        @"waybillId":self.dic[@"waybillId"],
    };
    
    [AFN_DF POST:@"/tsmanage/waybillsettle/getbyid" Parameters:dic success:^(NSDictionary *responseObject) {
        
        self.data = responseObject[@"data"];
        [self dataSoursAction];
        
            self.dataArray = @[
                   @{ @"tit":@"装货时间", @"value":self.data[@"planPickTime"]},
                   @{ @"tit":@"卸货时间",@"value":self.data[@"planArrivalTime"]},
                   @{ @"tit":@"货物名称",@"value":self.data[@"goods"]},
                   @{ @"tit":@"货物重量",@"value":[NSString stringWithFormat:@"%@",self.data[@"planLoad"]]},
                   @{ @"tit":@"车型要求",@"value":self.data[@"truck"]},
                    @{ @"tit":@"合理货损",@"value":[NSString stringWithFormat:@"%@%",self.data[@"soundLosston"]]},
             ];
             
                 [self.table reloadData];
                 [self.addresstable reloadData];

            [self endfwinfo];

        
        
        } failure:^(NSError *error) {
        
    }];
    
    
    }

-(void)dataSoursAction{
    
    self.addressLab.text = self.data[@"loadPlaceDetail"];
    self.unaddNameLab.text = [NSString stringWithFormat:@"%@  %@",self.data[@"receiveContactName"],self.data[@"receiveContactPhone"]];
    
    
    
    
    self.unaddressLab.text = self.data[@"unloadPlaceDetail"];
 
    self.addNameLab.text = [NSString stringWithFormat:@"%@  %@",self.data[@"contactName"],self.data[@"sendContactPhone"]];
    
        
    
    NSDictionary *attrs1 = @{NSFontAttributeName:[UIFont systemFontOfSize:14*Width1]};
        CGFloat widths = [self.unaddNameLab.text boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs1 context:nil].size.width;
    
    
    CGFloat widths1 = [self.addNameLab.text boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs1 context:nil].size.width;
    
    self.unaddNameLab.frame = CGRectMake(45, 109, widths, 20);
    
    self.overtoImg.frame = CGRectMake(50 + widths, 112.5, 14, 13);
    self.starttoImg.frame = CGRectMake(50 + widths1, 48.5, 14, 13);
    
    self.addisLab.text = self.data[@"localDistanceStr"];
    self.unaddisLab.text = self.data[@"distanceStr"];
    self.carLab.text = self.data[@"truckAndDriver"];
//    self.price.text = [NSString stringWithFormat:@"运输价格: %@%@",self.dic[@"freight"],self.dic[@"freightType"]];

}



#pragma Make -----UItableviewDelegate ------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.dataArray.count != 0) {
        if (tableView.tag == 1001) {
               
               return 4;
           }else{
                return 2;
           }
        
    }else{
        
        return 0;
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



-(UIScrollView *)mainView{
    
    if (_mainView == nil) {
        
        _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NavaBarHeight, Width, Height-UISafeAreaBottomHeight-NavaBarHeight)];
        _mainView.contentSize = CGSizeMake(0, 1000);
        _mainView.bounces = NO;
        _mainView.backgroundColor = COLOR2(240);
        _mainView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_mainView];
    }
    
    return _mainView;
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


-(void)setfwb:(UILabel *)las :(NSInteger)tag{
    
    NSString *str = las.text;
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    //给富文本添加属性1-字体大小
//        [attributedStr addAttribute:NSFontAttributeName
//                              value:[UIFont systemFontOfSize:14*Width1]
//                              range:NSMakeRange(0, 3)];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:COLOR2(119)
                          range:NSMakeRange(0, tag)];
    
    
    las.attributedText = attributedStr;
//    las.textAlignment = YES;
    
   
    
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

-(void)seleCarAction{
     [self.navigationController setNavigationBarHidden:YES animated:NO];
    

    if (backVC != nil) {
        
        [backVC removeFromSuperview];
    }
    
      backVC = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
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
            __weak SettlementDetController *weakSelf = self;
    
                carVC.selectblock = ^(NSDictionary * _Nonnull dic) {
                    weakSelf.carDic = dic;
                    [self->backVC removeFromSuperview];
                    [self.navigationController setNavigationBarHidden:NO animated:YES];
             ///绑定
                  
                    
                   
                    
                    [weakSelf postBindCar];
//            [weakSelf.selectCarBut setTitle: forState:0];
//           [weakSelf.selectCarBut setTitleColor:[UIColor redColor] forState:0];
//            self.orderBut.userInteractionEnabled = YES;
//            self.orderBut.backgroundColor = [UIColor redColor];
                    
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
    
    __weak SettlementDetController *weakSelf = self;
        self.bindVC.block = ^(NSDictionary * _Nonnull dic) {
             
            [weakSelf postbindOrUnbindDriver:dic];
            
            
         };
       [self.view addSubview:self.bindVC];

}



-(void)onTapGR{
    
    
    [backVC removeFromSuperview];
    [carVC removeFromSuperview];
    [self.bindVC removeFromSuperview];
     [self.navigationController setNavigationBarHidden:NO animated:YES];
}


-(void)postBindCar{
    
    NSDictionary *dic = @{
        @"truckId":self.carDic[@"truckId"],
        @"waybillId":self.data[@"waybillId"],
      
    };
    
    
    [AFN_DF POST:@"/tsmanage/waybill/changeTruck" Parameters:dic success:^(NSDictionary *responseObject) {
        
        self.carLab.text = [NSString stringWithFormat:@"%@ %@",self.carDic[@"mainDriver"],self.carDic[@"plateNumber"]];
        [self.view addSubview:[Toast makeText:@"车辆更换成功"]];
        [self getCarList];
        
      
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
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


//- (void)startTimer
//{
//
//        timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshLessTime) userInfo:@"" repeats:YES];
//
//    //如果不添加下面这条语句，在UITableView拖动的时候，会阻塞定时器的调用
//        [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
//
//}

- (void)refreshLessTime
{



        
    NSString *code = [NSString stringWithFormat:@"%@",self.data[@"longterm"]];
           if ([code isEqualToString:@"0"]) {

                    
               NSString *times = self.data[@"planPickTime"];
                         NSInteger timecode =  [self timeSwitchTimestamp:times andFormatter:@"YYYY-MM-dd HH:mm:ss"];
                         NSInteger intimer = [self getNowTimestamp];
                         NSInteger sou = timecode - intimer;

               if (sou > 0) {
                   NSInteger time = sou;
                    SourceCell *cell = (SourceCell *)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
                  [self lessSecondToDay:--time:cell.titleLab];



               }else{

               }


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
    
    NSString *time = [NSString stringWithFormat:@"剩余时间: %lu时%lu分%lu秒",(unsigned long)hour,(unsigned long)min,(unsigned long)second];
    
   
    lab.text = time;
    
    if ([self.viewcode isEqualToString:@"0"]) {
        
              [LSProgressHUD hideForView:self.view];
                self.viewcode = @"1";
    }
    
    [self setfwb:lab :hourStr.length :minStr.length :secondStr.length];
    
   
 
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
    
    
      NSArray *arr =  [self.dic[@"unloadPlaceDestination"] componentsSeparatedByString:@","];
    NSString  *lat = arr.lastObject;
     NSString  *lon = arr.firstObject;
    self.endPoint   = [AMapNaviPoint locationWithLatitude:lat.floatValue longitude:lon.floatValue];

    
    
    [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:self.endPoint name:self.data[@"unloadPlaceDetail"]  POIId:nil];
    
    

    //设置车辆信息
    AMapNaviVehicleInfo *info = [[AMapNaviVehicleInfo alloc] init];
    info.vehicleId = self.data[@"carNumber"];//设置车牌号
    info.type = 1;              //设置车辆类型,0:小车; 1:货车. 默认0(小车).
    ///设置车辆类型,0:小车; 1:货车; 2:纯电动车; 3:纯电动货车; 4:插电式混动汽车; 5:插电式混动货车. 默认0(小车). 注意:只有设置了货车，其他关于货车的属性设置才会生效

    ///设置货车的轴数（用来计算过路费及限重）
    info.axisNums = [self.data[@"vehicleAxis"] intValue];

    ///设置货车的宽度,范围:(0,5],单位：米
    info.width = [self.data[@"vehicleWidth"] intValue];

    ///设置货车的高度,范围:(0,10],单位：米
    info.height =[self.data[@"vehicleHeight"] intValue];

    ///设置货车的长度,范围:(0,25],单位：米
    info.length = [self.data[@"vehicleLength"] intValue];

    ///设置货车的总重，范围:(0,100]，单位：吨. 注意：总重 = 车重 + 核定载重
    info.load = [self.data[@"vehicleLoad"] intValue];

    ///设置货车的核定载重，范围:(0,100)，单位：吨.
    info.weight = [self.data[@"vehicleWeight"] intValue];
    
    
    
    
//  
    [config setVehicleInfo:info];

    [self.compositeManager presentRoutePlanViewControllerWithOptions:config];

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
                          range:NSMakeRange(6,hour)];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName
                            value:[UIColor redColor]
                            range:NSMakeRange(7+hour,min)];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName
                               value:[UIColor redColor]
                               range:NSMakeRange(8+hour + min,sec)];
    
    
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
///复制
-(void)copyAction{
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [NSString stringWithFormat:@"%@",self.dic[@"waybillId"]];
    [self.view addSubview:[Toast makeText:@"复制运单成功"]];
    
    
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

-(void)back{

    if ([self.types isEqualToString:@"1"]) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        self.navigationController.tabBarController.selectedIndex = 1;
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
        
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
