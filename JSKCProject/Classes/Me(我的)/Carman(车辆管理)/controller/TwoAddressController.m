//
//  TwoAddressController.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/27.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "TwoAddressController.h"
#import "DF_SHopList.h"
#import "BindMasterView.h"
#import "AddCarController.h"
@interface TwoAddressController ()
{
    UIView *backVC;
}
@property(nonatomic,strong)UITextField *numCatTF;
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
@end

@implementation TwoAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车辆详情";

    self.view.backgroundColor = COLOR2(240);

        [self getCarInfo];
        [self gettranslateList];
 
    
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


-(void)setUI{
    
    
    
    
        UIView *noteVC = [[UIView alloc]initWithFrame:CGRectMake(0, 10, Width,40)];
        noteVC.backgroundColor = COLOR(255, 244, 234);
        [self.mainView addSubview:noteVC];
   
    [UILabel initWithDFLable:CGRectMake(0,0, Width, 40) :[UIFont systemFontOfSize:14*Width1] :[UIColor redColor] : [NSString stringWithFormat:@"认证失败原因:%@",self.dic[@"failReason"]] :noteVC:1];
    
    
    
    self.numCatTF = [UITextField new];
    self.selectloonBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectTypeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIView *backVC = [[UIView alloc]initWithFrame:CGRectMake(10,60, Width - 20, 150)];
    backVC.backgroundColor = COLOR2(240);
    backVC.layer.cornerRadius = 4;
    [self.mainView addSubview:backVC];
    NSArray *arr = @[self.numCatTF,self.selectTypeBut,self.selectloonBut];
        NSArray *titarr = @[@"车辆牌照",@"车辆类型",@"车长"];
    
    for (int i = 0;i < arr.count; i++) {
        
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0 + (50 *i), Width - 20, 49)];
        back.backgroundColor = [UIColor whiteColor];
        [backVC addSubview:back];
        
        [UILabel initWithDFLable:CGRectMake(10, 10, 140, 30) :[UIFont systemFontOfSize:15*Width1] :COLOR2(51) :titarr[i] :back :0];
        
        if (i == 0) {
            
            self.numCatTF.frame = CGRectMake(Width - 200, 10, 170, 30);
            self.numCatTF.font = [UIFont systemFontOfSize:15*Width1];
            self.numCatTF.placeholder = @"请输入车辆牌照";
            self.numCatTF.textAlignment = 2;
            [back addSubview:self.numCatTF];
        }else{
            
            UIButton *sendBut = arr[i];
            sendBut.frame = CGRectMake(Width - 200, 10, 150, 30);
            if (self.dic != nil) {
                sendBut.frame = CGRectMake(Width - 200, 10, 170, 30);
            }
            [sendBut setTitleColor:[UIColor grayColor] forState:0];
            sendBut.tag = 1000 + i;
            sendBut.titleLabel.font = [UIFont systemFontOfSize:15*Width1];
            sendBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [back addSubview:sendBut];
            if (i == 1) {
                
                [sendBut setTitle:@"请选择车辆类型" forState:0];
            }else{
                 [sendBut setTitle:@"请选择车辆长度" forState:0];
            }
            
            if (self.dic == nil) {
                UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(Width - 40, 17.5, 10, 15)];
                img.image = [UIImage imageNamed:@"返 回 拷贝 2"];
                [back addSubview:img];
            }
            
           

        }

    }
    
    
    if (self.dic) {
         
         self.numCatTF.text = self.dic[@"plateNumber"];
           [self.selectloonBut setTitle:self.dic[@"truckLength"] forState:0];
               [self.selectTypeBut setTitle:self.dic[@"truckType"] forState:0];
        
        self.numCatTF.userInteractionEnabled = NO;
         self.selectloonBut.userInteractionEnabled = NO;
         self.selectTypeBut.userInteractionEnabled = NO;
         
     }
    

    for (int i = 0; i < 3; i ++) {
        
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(10,220 + (210 *i), Width - 20, 200)];
        back.backgroundColor = [UIColor whiteColor];
        back.layer.cornerRadius = 4;
        [self.mainView addSubview:back];
        
        
        if (i == 0) {
            
            [UILabel initWithDFLable:CGRectMake(10, 0, 80, 50) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :@"行驶证信息" :back :0];
              [UILabel initWithDFLable:CGRectMake(90, 0, 200, 50) :[UIFont systemFontOfSize:11*Width1] :[UIColor grayColor] :@"上传清晰的证件照认证较快哦！" :back :0];
 
            
            ImageVC *imageVC1 = [[ImageVC alloc]initWithFrame:CGRectMake(10, 50, (back.frame.size.width/2) - 20, 100)];
            imageVC1.imgs = @"行驶证反";
            imageVC1.typess = @"1";
            imageVC1.vc = self;
            imageVC1.url = self.dic[@"idTrvalFront"];
            imageVC1.block = ^(UIImage * _Nonnull img) {
                
                self.img1 = img;
            };
            imageVC1.removerblock = ^(UIImage * _Nonnull img) {
                 self.img1 = nil;
            };
           
            [back addSubview:imageVC1];
            
            
            
            ImageVC *imageVC2 = [[ImageVC alloc]initWithFrame: CGRectMake(back.frame.size.width/2 + 10, 50, (back.frame.size.width/2) - 20, 100)];
             imageVC2.imgs = @"行驶证反";
              imageVC2.vc = self;
             imageVC2.userInteractionEnabled = NO;
             imageVC1.userInteractionEnabled = NO;
            imageVC2.url = self.dic[@"idTrvalBack"];
              imageVC2.typess =@"1";
              imageVC2.block = ^(UIImage * _Nonnull img) {
                    self.img2 = img;
                };
              imageVC2.removerblock = ^(UIImage * _Nonnull img) {
                  self.img2 = nil;
               };
              [back addSubview:imageVC2];
            
           
          
             [UILabel initWithDFLable:CGRectMake(10, 160, (back.frame.size.width/2) - 20, 15) :[UIFont systemFontOfSize:11*Width1] :[UIColor blackColor] :@"点击拍摄/上传行驶证主页" :back :1];
             [UILabel initWithDFLable: CGRectMake(back.frame.size.width/2 + 10, 160, (back.frame.size.width/2) - 20, 15) :[UIFont systemFontOfSize:11*Width1] :[UIColor blackColor] :@"点击拍摄/上传行驶证副页" :back :1];
            
            
                }else if(i == 1){
                    
                    
                    [UILabel initWithDFLable:CGRectMake(10, 0, 300, 50) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :@"道路运输证信息" :back :0];
                    
              ImageVC *imageVC1 = [[ImageVC alloc]initWithFrame:CGRectMake(10, 50, (back.frame.size.width/2) - 20, 100)];
                      imageVC1.imgs = @"道路运输正";
                      imageVC1.vc = self;
                    imageVC1.typess = @"1";
                                                
                        imageVC1.url = self.dic[@"idrtFront"];
                      imageVC1.block = ^(UIImage * _Nonnull img) {
                          self.img3 = img;
                      };
                      imageVC1.removerblock = ^(UIImage * _Nonnull img) {
                          self.img3 = nil;
                      };
                      [back addSubview:imageVC1];
                      
                      
                      
                      ImageVC *imageVC2 = [[ImageVC alloc]initWithFrame: CGRectMake(back.frame.size.width/2 + 10, 50, (back.frame.size.width/2) - 20, 100)];
                       imageVC2.imgs = @"道路运输反";
                        imageVC2.vc = self;
                       imageVC2.typess =@"1";
                       imageVC2.url = self.dic[@"idrtBack"];
                        imageVC2.block = ^(UIImage * _Nonnull img) {
                            self.img4 = img;
                          };
                        imageVC2.removerblock = ^(UIImage * _Nonnull img) {
                            self.img4 = nil;
                         };
                        [back addSubview:imageVC2];
                            imageVC2.userInteractionEnabled = NO;
                            imageVC1.userInteractionEnabled = NO;
            
                    [UILabel initWithDFLable:CGRectMake(10, 160, (back.frame.size.width/2) - 20, 15) :[UIFont systemFontOfSize:11*Width1] :[UIColor blackColor] :@"点击拍摄/上传道路运输证主页" :back :1];
                               [UILabel initWithDFLable: CGRectMake(back.frame.size.width/2 + 10, 160, (back.frame.size.width/2) - 20, 15) :[UIFont systemFontOfSize:11*Width1] :[UIColor blackColor] :@"点击拍摄/上传道路运输证副页" :back :1];
                    
                                 
            
        }else{
              [UILabel initWithDFLable:CGRectMake(10, 0, 300, 50) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :@"最新年检记录(选填)" :back :0];
            
                     ImageVC *imageVC1 = [[ImageVC alloc]initWithFrame:CGRectMake(10, 50, (back.frame.size.width/2) - 20, 100)];
                    imageVC1.imgs = @"年检记录1";
                        imageVC1.vc = self;
                        imageVC1.url = self.dic[@"yearInspect"];
                        imageVC1.block = ^(UIImage * _Nonnull img) {
                                      self.img5 = img;
                                  };
                    imageVC1.removerblock = ^(UIImage * _Nonnull img) {
                        self.img5 = nil;
                        };
                                  [back addSubview:imageVC1];
                                  
                                  
                    [UILabel initWithDFLable:CGRectMake(10, 160, (back.frame.size.width/2) - 20, 15) :[UIFont systemFontOfSize:11*Width1] :[UIColor blackColor] :@"点击拍摄/上传最新年检记录" :back :1];
         
                     imageVC1.userInteractionEnabled = NO;
                imageVC1.typess = @"1";
                    
        }

    }
    
    
    if (self.dic) {
       
        _mainView.contentSize = CGSizeMake(0, 950);
               UIView *tabVC = [[UIView alloc]initWithFrame:CGRectMake(0, 860, Width, 90)];
                 tabVC.backgroundColor = [UIColor whiteColor];
                 [self.mainView addSubview:tabVC];
                 
        
    
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
        
        
                UIButton *delegateBut = [UIButton initWithFrame:CGRectMake(20, 40, Width/2 - 40, 40) :@"删除" :16*Width1];
                    delegateBut.layer.cornerRadius = 4;
                    delegateBut.layer.borderWidth  = 1;
                    delegateBut.layer.borderColor = [[UIColor redColor]CGColor];
                    [delegateBut setTitleColor:[UIColor redColor] forState:0];
                    [delegateBut addTarget:self action:@selector(deleAction) forControlEvents:(UIControlEventTouchUpInside)];
                    [tabVC addSubview:delegateBut];
        
        
                UIButton *endBut = [UIButton initWithFrame:CGRectMake(Width/2 + 20, 40, Width/2 - 40, 40) :@"重新认证" :16*Width1];
                 endBut.layer.cornerRadius = 4;
                 endBut.backgroundColor = [UIColor redColor];
                [endBut addTarget:self action:@selector(suppAction) forControlEvents:(UIControlEventTouchUpInside)];
                [tabVC addSubview:endBut];
        
         
        
        
        
    }
    
  
}


-(void)deleAction{
    
    [AFN_DF POST:@"/system/truck/delete" Parameters:@{@"truckId":self.dic[@"id"]} success:^(NSDictionary *responseObject) {
         
         [[AFN_DF topViewController].navigationController popViewControllerAnimated:YES];
         [[AFN_DF topViewController].view addSubview:[Toast makeText:@"删除成功"]];
         
     } failure:^(NSError *error) {
         
     }];
     
    
}

///提交
-(void)suppAction{
    
    
    AddCarController *addVC = [AddCarController new];
    addVC.codedic = self.codedic;
    
    
    
    [self.navigationController pushViewController:addVC animated:YES];
    
}


//解绑
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
    __weak TwoAddressController *weakSelf  = self;
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



-(UIScrollView *)mainView{
    
    if (_mainView == nil) {
        
        _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        _mainView.contentSize = CGSizeMake(0, 880);
        _mainView.bounces = NO;
        _mainView.backgroundColor = COLOR2(240);
        _mainView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_mainView];
    }
    return _mainView;
}

-(void)onTapGR{
    
    
    [backVC removeFromSuperview];
 
    [self.bindVC removeFromSuperview];
     [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
// 
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
