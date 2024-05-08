//
//  AddCarController.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/27.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "AddCarController.h"
#import "DF_SHopList.h"
#import "BindMasterView.h"
#import "DreCarAddVC.h"
#import "CarNumView.h"
@interface AddCarController ()
{
    UIView *backVC;
}
@property(nonatomic,strong)UIButton *numBut;
@property(nonatomic,strong)UIButton *selectTypeBut;
@property(nonatomic,strong)UIButton *selectloonBut;
@property(nonatomic,strong)UIButton *xxzImg;
@property(nonatomic,strong)UIButton *unxxzImg;
@property(nonatomic,strong)UIButton *yszImg;
@property(nonatomic,strong)UIButton *unyszImg;
@property(nonatomic,strong)UIButton *yearImg;
@property(nonatomic,strong)UIScrollView *mainView;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSDictionary *loonDic;
@property(nonatomic,strong)NSDictionary *typeDic;
@property(nonatomic,strong)UIImage *img1;
@property(nonatomic,strong)UIImage *img2;
@property(nonatomic,strong)UIImage *img3;
@property(nonatomic,strong)UIImage *img4;
@property(nonatomic,strong)UIImage *img5;
@property(nonatomic,strong)UILabel *bindLab;
@property(nonatomic,strong)UIButton *selectBindLab;
@property(nonatomic,strong)NSArray *translateArray;
@property(nonatomic,strong)BindMasterView *bindVC;
@property(nonatomic,strong)NSDictionary *bindDic;
@property(nonatomic,strong)NSDictionary *carNumDic;
@end

@implementation AddCarController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
   
  
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self postData];
    self.view.backgroundColor = COLOR2(240);
    
    if (self.dic) {
        
        [self getCarInfo];
        [self gettranslateList];
    }else{
        
        
        [self setUI];
        
    }
    
    
}

///添加车辆前判断
-(void)getaddBeforeInfo{
    
    
    [AFN_DF POST:@"/system/truck/addBefore" Parameters:@{@"plateNumber":self.carNumDic[@"num"],@"plateType":self.carNumDic[@"color"]} success:^(NSDictionary *responseObject) {
        
        NSInteger info =  [responseObject[@"data"][@"state"]intValue];
               
               
               if (info == 99) {
                   
                 
                   
               }else if(info == 100){
                   
                       [self.view  addSubview:[Toast makeText:responseObject[@"data"][@"info"]]];
               }else if(info == 101){
                   
                       ///直接添加弹窗
                   
                   DreCarAddVC *addVC = [[DreCarAddVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                   addVC.plateType = self.carNumDic[@"color"];
                   addVC.plateNumber = self.carNumDic[@"num"];
                   addVC.dic = responseObject[@"data"];
                   addVC.block = ^(NSDictionary * _Nonnull dic) {
                       self.block(dic);
                   };
                   [self.view addSubview:addVC];
                   
               }
               
        
    } failure:^(NSError *error) {
        
    }];
    
    
}


///获取司机列表
-(void)gettranslateList{
    
    [AFN_DF POST:@"/system/driver/drivers" Parameters:nil success:^(NSDictionary *responseObject) {
          
          self.translateArray = responseObject[@"data"];
          

      } failure:^(NSError *error) {
          
      }];
    
    
}

-(void)getCarInfo{
    
    
    [AFN_DF POST:@"/system/truck/getTruckByTruckId" Parameters:@{@"truckId":self.dic[@"truckId"]} success:^(NSDictionary *responseObject) {
        self.dic = responseObject[@"data"];
        [self setUI];
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)postData{
    
    
    [AFN_DF POST:@"/system/truck/clickaddtruck" Parameters:nil success:^(NSDictionary *responseObject) {
        
        self.dataArray = responseObject[@"data"];

    } failure:^(NSError *error) {
            
    }];
    
}

-(void)setUI{
    
    
    self.numBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectloonBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectTypeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIView *backVC = [[UIView alloc]initWithFrame:CGRectMake(10,10, Width - 20, 45)];
    backVC.backgroundColor = COLOR2(240);
    backVC.layer.cornerRadius = 4;
    [self.mainView addSubview:backVC];
    NSArray *arr = @[self.numBut];
        NSArray *titarr = @[@"车辆牌照"];
    
    for (int i = 0;i < arr.count; i++) {
        
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0 + (50 *i), Width - 20, 49)];
        back.backgroundColor = [UIColor whiteColor];
        [backVC addSubview:back];
        
        [UILabel initWithDFLable:CGRectMake(10, 10, 140, 30) :[UIFont systemFontOfSize:15*Width1] :COLOR2(51) :titarr[i] :back :0];
        
      
            
            UIButton *sendBut = arr[i];
           
        
            sendBut.frame = CGRectMake(Width - 200, 10, 150, 30);
        
        if (self.dic != nil) {
            sendBut.frame = CGRectMake(Width - 200, 10, 170, 30);
        }
        
            [sendBut setTitleColor:[UIColor grayColor] forState:0];
            sendBut.tag = 1000 + i;
            sendBut.titleLabel.font = [UIFont systemFontOfSize:15*Width1];
            [sendBut addTarget:self action:@selector(butAction:) forControlEvents:(UIControlEventTouchUpInside)];
            sendBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [back addSubview:sendBut];
            if (i == 1) {
                
                [sendBut setTitle:@"请选择车辆类型" forState:0];
            }else if (i == 2){
                 [sendBut setTitle:@"请选择车辆长度" forState:0];
            }else{
                
                 [sendBut setTitle:@"输入车牌照" forState:0];
                
            }
            
        
        if (self.dic == nil) {
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(Width - 40, 17.5, 15, 15)];
            img.image = [UIImage imageNamed:@"返 回 拷贝 2"];
            [back addSubview:img];
        }
        
     

        }

   
    
    
        if (self.dic) {
         
        [self.numBut setTitle:self.dic[@"plateNumber"] forState:0];
        [self.selectloonBut setTitle:self.dic[@"truckLength"] forState:0];
        [self.selectTypeBut setTitle:self.dic[@"truckType"] forState:0];
            
            [self.numBut setTitleColor:[UIColor blackColor] forState:0];
            [self.selectloonBut setTitleColor:[UIColor blackColor] forState:0];
            [self.selectTypeBut setTitleColor:[UIColor blackColor] forState:0];
            
            
            
            self.numBut.userInteractionEnabled = NO;
            self.selectloonBut.userInteractionEnabled = NO;
            self.selectTypeBut.userInteractionEnabled = NO;
            
            
         
     }
    

    NSInteger icode = 3;
    NSString *imgurls = self.dic[@"yearInspect"];
    if ([imgurls isEqualToString:@""] || imgurls == nil) {
        
        icode = 2;
    }
    
    
    for (int i = 0; i < icode; i ++) {
        
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(10,170 + (210 *i), Width - 20, 200)];
        back.backgroundColor = [UIColor whiteColor];
        back.layer.cornerRadius = 4;
        [self.mainView addSubview:back];
        
        
        if (i == 0) {
            
            [UILabel initWithDFLable:CGRectMake(10, 0, 80, 50) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :@"行驶证信息" :back :0];
              [UILabel initWithDFLable:CGRectMake(90, 0, 200, 50) :[UIFont systemFontOfSize:11*Width1] :[UIColor grayColor] :@"上传清晰的证件照认证较快哦！" :back :0];
 
            
            ImageVC *imageVC1 = [[ImageVC alloc]initWithFrame:CGRectMake(10, 50, (back.frame.size.width/2) - 20, 110)];
            imageVC1.imgs = @"行驶证正";
            imageVC1.vc = self;
           
            imageVC1.url = self.dic[@"idTrvalFront"];
            imageVC1.block = ^(UIImage * _Nonnull img) {
                
                self.img1 = img;
            };
            imageVC1.removerblock = ^(UIImage * _Nonnull img) {
                 self.img1 = nil;
            };
            [back addSubview:imageVC1];
            
            
            
            ImageVC *imageVC2 = [[ImageVC alloc]initWithFrame: CGRectMake(back.frame.size.width/2 + 10, 50, (back.frame.size.width/2) - 20, 110)];
             imageVC2.imgs = @"行驶证反";
              imageVC2.vc = self;
            imageVC2.url = self.dic[@"idTrvalBack"];
              imageVC2.block = ^(UIImage * _Nonnull img) {
                    self.img2 = img;
                };
              imageVC2.removerblock = ^(UIImage * _Nonnull img) {
                  self.img2 = nil;
               };
              [back addSubview:imageVC2];
            
            
            if (self.dic) {
                
                imageVC1.typess = @"1";
                imageVC2.typess = @"1";
            }
            
             [UILabel initWithDFLable:CGRectMake(10, 170, (back.frame.size.width/2) - 20, 15) :[UIFont systemFontOfSize:11*Width1] :[UIColor blackColor] :@"点击拍摄/上传行驶证主页" :back :1];
             [UILabel initWithDFLable: CGRectMake(back.frame.size.width/2 + 10, 170, (back.frame.size.width/2) - 20, 15) :[UIFont systemFontOfSize:11*Width1] :[UIColor blackColor] :@"点击拍摄/上传行驶证副页" :back :1];
            
            
                }else if(i == 1){
                    
                    
                    [UILabel initWithDFLable:CGRectMake(10, 0, 300, 50) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :@"道路运输证信息" :back :0];
                    
              ImageVC *imageVC1 = [[ImageVC alloc]initWithFrame:CGRectMake(10, 50, (back.frame.size.width/2) - 20, 110)];
                      imageVC1.imgs = @"道路运输正";
                      imageVC1.vc = self;
                        imageVC1.url = self.dic[@"idrtFront"];
                      imageVC1.block = ^(UIImage * _Nonnull img) {
                          self.img3 = img;
                      };
                      imageVC1.removerblock = ^(UIImage * _Nonnull img) {
                          self.img3 = nil;
                      };
                      [back addSubview:imageVC1];

            if (self.dic) {
                           
                           imageVC1.typess = @"1";
//                           imageVC2.typess = @"1";
                       }
                    [UILabel initWithDFLable:CGRectMake(10, 170, (back.frame.size.width/2) - 20, 15) :[UIFont systemFontOfSize:11*Width1] :[UIColor blackColor] :@"点击拍摄/上传道路运输证" :back :1];

        }else{
              [UILabel initWithDFLable:CGRectMake(10, 0, 300, 50) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :@"人车合照(选填)" :back :0];
            
                     ImageVC *imageVC1 = [[ImageVC alloc]initWithFrame:CGRectMake(10, 50, (back.frame.size.width/2) - 20, 110)];
                    imageVC1.imgs = @"icon_defeat_image";
            
                        imageVC1.vc = self;
            
                        imageVC1.url = self.dic[@"yearInspect"];
                    if (self.dic) {
                        imageVC1.typess = @"1";
                    }
                        imageVC1.block = ^(UIImage * _Nonnull img) {
                                      self.img5 = img;
                                  };
                    imageVC1.removerblock = ^(UIImage * _Nonnull img) {
                        self.img5 = nil;
                        };
                                  [back addSubview:imageVC1];
                                  
                                  
                    [UILabel initWithDFLable:CGRectMake(10, 170, (back.frame.size.width/2) - 20, 15) :[UIFont systemFontOfSize:11*Width1] :[UIColor blackColor] :@"点击拍摄/上传人车合照" :back :1];

        }

    }
    
    
    if (self.dic) {

               UIView *tabVC = [[UIView alloc]init];
                 tabVC.backgroundColor = [UIColor whiteColor];
                 [self.mainView addSubview:tabVC];
         
        if (icode == 2) {
               
//            _mainView.contentSize = CGSizeMake(0, Height - NavaBarHeight);
            tabVC.frame = CGRectMake(0, Height - 91, Width, 90);
        }else{
            _mainView.contentSize = CGSizeMake(0, 900);
            tabVC.frame = CGRectMake(0, 810, Width, 80);
            
        }

        
            NSInteger tags = [[NSString stringWithFormat:@"%@",self.dic[@"mainDriverId"]]intValue];
            
            if (tags == 0) {
                    
                self.bindLab = [UILabel initWithDFLable:CGRectMake(20,10, 200, 20) :[UIFont systemFontOfSize:14*Width1] :[UIColor redColor] :@"请绑定货主主驾" :tabVC :0];
                    
                    self.selectBindLab = [UIButton initWithFrame:CGRectMake(Width - 40, 5, 30, 30) :@"返 回 拷贝 4"];
                    [self.selectBindLab addTarget:self action:@selector(binds) forControlEvents:(UIControlEventTouchUpInside)];
                    [tabVC addSubview:self.selectBindLab];
                    
            }else{
                
                self.bindLab = [UILabel initWithDFLable:CGRectMake(20,10, 200, 20) :[UIFont systemFontOfSize:14*Width1] :[UIColor redColor] :self.dic[@"mainDriver"] :tabVC :0];
                    
                self.selectBindLab = [UIButton initWithFrame:CGRectMake(Width - 90, 5, 80, 30) :@"解绑":14*Width1];
                [self.selectBindLab setTitleColor:[UIColor redColor] forState:0];
                    [self.selectBindLab addTarget:self action:@selector(binds) forControlEvents:(UIControlEventTouchUpInside)];
                    [tabVC addSubview:self.selectBindLab];
                    
                
            }
            
            
            NSDictionary *dic = self.dic;
              NSInteger verify = [[NSString stringWithFormat:@"%@",dic[@"verify"]]integerValue];
            
            
            if (verify == 2) {
                UIButton *endBut = [UIButton initWithFrame:CGRectMake(20, 40, Width - 40, 40) :@"提交" :16*Width1];
                                       endBut.layer.cornerRadius = 4;
                                       endBut.backgroundColor = [UIColor redColor];
                                       [endBut addTarget:self action:@selector(editAction) forControlEvents:(UIControlEventTouchUpInside)];
                                       [tabVC addSubview:endBut];
            }else{
                
                
                UIButton *endBut = [UIButton initWithFrame:CGRectMake(20, 40, Width - 40, 40) :@"删除" :16*Width1];
                                       endBut.layer.cornerRadius = 4;
                                       endBut.backgroundColor = [UIColor redColor];
                                       [endBut addTarget:self action:@selector(delegateAction) forControlEvents:(UIControlEventTouchUpInside)];
                                       [tabVC addSubview:endBut];
                
            }
            
        
        
        
    }else{
        
                _mainView.contentSize = CGSizeMake(0, 880);
               UIView *tabVC = [[UIView alloc]initWithFrame:CGRectMake(0, 820, Width, 60)];
                 tabVC.backgroundColor = [UIColor whiteColor];
                 [self.mainView addSubview:tabVC];
                 
                 UIButton *endBut = [UIButton initWithFrame:CGRectMake(20, 10, Width - 40, 40) :@"提交" :16*Width1];
                 endBut.layer.cornerRadius = 4;
                 endBut.backgroundColor = [UIColor redColor];
                 [endBut addTarget:self action:@selector(suppAction) forControlEvents:(UIControlEventTouchUpInside)];
                 [tabVC addSubview:endBut];
    }
}


///删除
-(void)delegateAction{
    
    
    [AFN_DF POST:@"/system/truck/delete" Parameters:@{@"truckId":self.dic[@"id"]} success:^(NSDictionary *responseObject) {
            
            [[AFN_DF topViewController].navigationController popViewControllerAnimated:YES];
            [[AFN_DF topViewController].view addSubview:[Toast makeText:@"删除成功"]];
            
        } failure:^(NSError *error) {
            
        }];
    
    
    
}

///解绑
-(void)unselectAction{
    
        NSDictionary *dict = @{
               @"bindType":@"2",
               @"driverId":self.dic[@"mainDriverId"],
               @"truckId":self.dic[@"id"],
               @"type":@"1",
            };
            [self PostBind:dict];
}

///绑定
-(void)selectAction{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
         self.tabBarController.tabBar.hidden = YES;
      
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
    
    
    self.bindVC = [[BindMasterView alloc]initWithFrame:CGRectMake(0, NavaBarHeight, Width, Height - NavaBarHeight)];
    self.bindVC.backgroundColor = [UIColor whiteColor];
    self.bindVC.dataArray = [NSMutableArray arrayWithArray:self.translateArray];
    __weak AddCarController *weakSelf  = self;
    self.bindVC.block = ^(NSDictionary * _Nonnull dic) {
      
            [weakSelf onTapGR];
        weakSelf.bindDic = dic;
        NSDictionary *dict = @{
            @"bindType":@"1",
            @"driverId":weakSelf.bindDic[@"id"],
            @"truckId":weakSelf.dic[@"id"],
            @"type":@"1",
        };
        [weakSelf PostBind:dict];
        
        };
    [self.view addSubview:self.bindVC];
//    [];
    
    
}




-(void)binds{
    
      NSInteger tags = [[NSString stringWithFormat:@"%@",self.dic[@"mainDriverId"]]intValue];
    
    if (tags == 0) {
        
        [self selectAction];
        
    }else{
        
        [self unselectAction];
    }
    
    
}


///绑定主驾驶/解除
-(void)PostBind:(NSDictionary *)dic{
    
    [AFN_DF POST:@"/system/truck/bindOrUnbindDriver" Parameters:dic success:^(NSDictionary *responseObject) {
        
        if ([dic[@"bindType"] isEqualToString:@"1"]) {
            
            [self.view addSubview:[Toast makeText:@"绑定成功"]];
            self.selectBindLab.frame = CGRectMake(Width - 90, 5, 80, 30);
            [self.selectBindLab setImage:[UIImage imageNamed:@"2312321"] forState:0];
            [self.selectBindLab setTitleColor:[UIColor redColor] forState:0];
             [self.selectBindLab setTitle:@"解绑" forState:0];
             
            self.selectBindLab.titleLabel.font =[UIFont systemFontOfSize:15*Width1];
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.dic];
            dict[@"mainDriverId"] = dic[@"driverId"];
            self.bindLab.text = self.bindDic[@"name"];
            self.dic = dict;
            
            
              
            
        }else{
            
        self.selectBindLab.frame = CGRectMake(Width - 40, 5, 30, 30);
            [self.selectBindLab setImage:[UIImage imageNamed:@"返 回 拷贝 4"] forState:0];
            [self.selectBindLab setTitleColor:[UIColor redColor] forState:0];
            [self.selectBindLab setTitle:@"" forState:0];
             [self.view addSubview:[Toast makeText:@"解除绑定成功"]];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.dic];
                  dict[@"mainDriverId"] = @"0";
                  self.dic = dict;
            self.bindLab.text = @"请绑定货主主驾";
            
        }
     
      
        
    } failure:^(NSError *error) {
            
        
    }];
    
    
    
}

-(void)butAction:(UIButton *)but{

     if (but.tag == 1000) {
          [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TFChangedValue:) name:@"carnum" object:nil];
         CarNumView *carVC = [[CarNumView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
         [self.view addSubview:carVC];
         
         
    
     }else if (but.tag == 1001) {
    ///选择类型
        
        NSArray *arr = self.dataArray[1][@"screens"];
        
        NSMutableArray *dataArray = [NSMutableArray array];
        
        for (int i = 0; i < arr.count; i++) {
            
            [dataArray addObject:arr[i][@"factor"]];
        }
        
         DF_SHopList *listVC =  [[DF_SHopList alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        listVC.proTimeList = dataArray;
        listVC.block = ^(NSInteger codes) {
            self.typeDic = arr[codes];
            [self.selectTypeBut setTitle:self.typeDic[@"factor"] forState:0];
        };
        [self.view addSubview:listVC];
        
        
    }else{
       ///选择车长
        NSArray *arr = self.dataArray[0][@"screens"];
               
               NSMutableArray *dataArray = [NSMutableArray array];
               
               for (int i = 0; i < arr.count; i++) {
                   
                   [dataArray addObject:arr[i][@"factor"]];
               }
               
        DF_SHopList *listVC =  [[DF_SHopList alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
               listVC.proTimeList = dataArray; 
               listVC.block = ^(NSInteger codes) {
                   self.loonDic = arr[codes];
                   [self.selectloonBut setTitle:self.loonDic[@"factor"] forState:0];
               };
               [self.view addSubview:listVC];
    }

    
    
    
    
    
}


- (void)TFChangedValue:(NSNotification*)notif
{
        
//    NSLog(@"%@",notif.object);
        self.carNumDic = notif.object;
        [self.numBut setTitleColor:[UIColor blackColor] forState:0];
    [self.numBut setTitle:self.carNumDic[@"num"] forState:0];
    
    [self getaddBeforeInfo];
    
    
}

///编辑
-(void)editAction{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
       NSMutableArray *fileArray = [NSMutableArray array];
     NSMutableArray *imagearr = [NSMutableArray array];
        if (self.loonDic != nil) {
        
        [dic setValue:self.loonDic[@"id"] forKey:@"length"];
    }
    
        if (self.typeDic != nil) {
    
             [dic setValue:self.typeDic[@"id"] forKey:@"type"];
         }
         
            if (self.img1 != nil) {
             
                [fileArray addObject:@"idtravlFront"];
                [imagearr addObject:self.img1];
             
         }
            if (self.img2 != nil) {
                
                [fileArray addObject:@"idtravlBack"];
                 [imagearr addObject:self.img2];
            }
            if (self.img3 != nil) {
                
              
                [fileArray addObject:@"idrtFront"];
                 [imagearr addObject:self.img3];
            }
//            if (self.img4 != nil) {
//
//                [fileArray addObject:@"idrtBack"];
//                 [imagearr addObject:self.img4];
//            }
        if (self.img5 != nil) {
                    
                [fileArray addObject:@"yearInspect"];
             [imagearr addObject:self.img5];
            }
    
    
    NSString *plateNumber = self.dic[@"plateNumber"];
        NSString *plateType =self.dic[@"plateType"];
    if (self.carNumDic) {
        
        plateNumber = self.carNumDic[@"num"];
        plateType = self.carNumDic[@"color"];
    }
    
 
    
    [dic setValue:plateNumber forKey:@"plateNumber"];
    [dic setValue:plateType forKey:@"plateType"];
    [dic setValue:self.dic[@"id"] forKey:@"truckId"];
    
  

    
    [AFN_DF POST:@"/system/truck/addOrEdit" Parameters:dic File:fileArray ImageArr:imagearr ContVC:self success:^(NSDictionary *responseObject) {

        NSInteger info =  [responseObject[@"data"][@"state"]intValue];
            if (info == 99) {
            
            [self.navigationController popViewControllerAnimated:YES];
            [[AFN_DF topViewController].view addSubview:[Toast makeText:@"提交成功"]];
                
            
            }else if(info == 100){
            
                [self.view  addSubview:[Toast makeText:responseObject[@"data"][@"info"]]];
            }else if(info == 101){
            
                ///直接添加弹窗
            
            DreCarAddVC *addVC = [[DreCarAddVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
            addVC.plateType = self.carNumDic[@"color"];
            addVC.plateNumber = self.carNumDic[@"num"];
                addVC.dic = responseObject[@"data"];
                
            [self.view addSubview:addVC];
            
        }
        
        
     

    } failure:^(NSError *error) {

    }];

    
    
}

///提交
-(void)endAction{
    
    
  
    if (self.loonDic == nil) {
           
           return [self.view addSubview:[Toast makeText:@"请选择车长"]];
       }
       
       if (self.typeDic == nil) {
           
           return [self.view addSubview:[Toast makeText:@"请选择类型"]];
       }
       
       if (self.img1 == nil) {
           
            return [self.view addSubview:[Toast makeText:@"请上传行驶证主页"]];
       }
       if (self.img2 == nil) {
              
               return [self.view addSubview:[Toast makeText:@"请上传行驶证副页"]];
          }
       if (self.img3 == nil) {
              
               return [self.view addSubview:[Toast makeText:@"请上传道路运输证"]];
          }
     
       
       NSMutableArray *fileArray = [NSMutableArray arrayWithObjects:@"idtravlFront",@"idtravlBack",@"idrtFront",@"yearInspect", nil];
         NSMutableArray *imagearr = [NSMutableArray arrayWithObjects:self.img1,self.img2,self.img3,self.img5, nil];
         
         if (self.img5 == nil) {
            
             [fileArray removeLastObject];
//             [imagearr removeLastObject];
         }
         
         
             
    
    
    
         NSDictionary *dic= @{
             
             @"length":self.loonDic[@"id"],
             @"plateNumber":self.carNumDic[@"num"],
              @"truckId":@"",
             @"type":self.typeDic[@"id"],
             @"plateType":self.carNumDic[@"color"],

         };
       
       
    [AFN_DF POST:@"/system/truck/addOrEdit" Parameters:dic File:fileArray ImageArr:imagearr ContVC:self success:^(NSDictionary *responseObject) {
           
          
           
        if ([self.addType isEqualToString:@"1"]) {
            
            NSInteger info =  [responseObject[@"data"][@"state"]intValue];
                if (info == 99) {
                
                    self.block(@{});
                    [self.navigationController popViewControllerAnimated:YES];
                
                }else if(info == 100){
                
                    [self.view  addSubview:[Toast makeText:responseObject[@"data"][@"info"]]];
                }else if(info == 101){
                
                    ///直接添加弹窗
                
                DreCarAddVC *addVC = [[DreCarAddVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                addVC.plateType = self.carNumDic[@"color"];
                addVC.plateNumber = self.carNumDic[@"num"];
                    addVC.dic = responseObject[@"data"];
                    addVC.block = ^(NSDictionary * _Nonnull dic) {
                        self.block(dic);
                    };
                [self.view addSubview:addVC];
                
            }
            
         
        }else{
            
            NSInteger info =  [responseObject[@"data"][@"state"]intValue];
                if (info == 99) {
                
                [self.navigationController popViewControllerAnimated:YES];
                [[AFN_DF topViewController].view addSubview:[Toast makeText:@"提交成功"]];
                
                }else if(info == 100){
                
                    [self.view  addSubview:[Toast makeText:responseObject[@"data"][@"info"]]];
                }else if(info == 101){
                
                    ///直接添加弹窗
                
                DreCarAddVC *addVC = [[DreCarAddVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                addVC.plateType = self.carNumDic[@"color"];
                addVC.plateNumber = self.carNumDic[@"num"];
                    addVC.dic = responseObject[@"data"];
                    addVC.block = ^(NSDictionary * _Nonnull dic) {
                      
                        self.block(dic);
                        
                    };
                [self.view addSubview:addVC];
                
            }
 
        }
          
           
       } failure:^(NSError *error) {
           
       }];
       
    
   
    
    
}


///提交
-(void)suppAction{
    
   
    
    if (self.dic) {
         [self editAction];
       
    }else{
        
        [self endAction];
        
    }
 

}

-(void)onTapGR{
    
    
    [backVC removeFromSuperview];
 
    [self.bindVC removeFromSuperview];
     [self.navigationController setNavigationBarHidden:NO animated:YES];
//       self.tabBarController.tabBar.hidden = YES;
}

-(UIScrollView *)mainView{
    
    if (_mainView == nil) {
        
        _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
     
        
        NSString *imgurls = self.dic[@"yearInspect"];
        if ([imgurls isEqualToString:@""] || imgurls == nil) {
            
            _mainView.contentSize = CGSizeMake(0,Height + 1); 
        }else{
//
            _mainView.contentSize = CGSizeMake(0, 880);
//        _mainView.contentSize = CGSizeMake(0, 1100);
        }
        
        _mainView.bounces = NO;
        _mainView.backgroundColor = COLOR2(240);
//        _mainView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_mainView];
    }
    return _mainView;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"carnum" object:nil];
 
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
