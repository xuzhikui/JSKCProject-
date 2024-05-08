//
//  AddDriverController.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/27.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "AddDriverController.h"
#import "DriverListController.h"
#import "DirectAddVC.h"
#import "DriectInfoVC.h"
@interface AddDriverController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIScrollView *mainView;
@property(nonatomic,strong)UITextField *numTF;
@property(nonatomic,strong)UIImage *img1;
@property(nonatomic,strong)UIImage *img2;
@property(nonatomic,strong)UIImage *img3;
@property(nonatomic,strong)UIImage *img4;
@property(nonatomic,strong)UIImage *img5;
@property(nonatomic,strong)UIImageView *imgvc1;
@property(nonatomic,strong)UIImageView *imgvc2;
@property(nonatomic,strong)UIImageView *imgvc3;
@property(nonatomic,strong)UIImageView *imgvc4;
@property(nonatomic,strong)UIImageView *imgvc5;
@property(nonatomic,strong)NSDictionary *orcDic;
@property(nonatomic,strong)UIView *oneVC;
@property(nonatomic,strong)UIView *TwoVC;
@property(nonatomic,strong)UIView *ThereVC;
@property(nonatomic,strong)UIView *tabVC;
@end

@implementation AddDriverController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
   
  
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = COLOR2(240);
    self.title =@"新增司机";
   
   
    
    if (self.dic) {
        self.title =@"司机详情";
        if ([self.codes isEqualToString:@"1"]) {
            
            self.title =@"司机修改";
        }
        [self postinfo];
       
    }else{
        

         [self setUI];
        
    }
    
}


///添加之前检查
-(void)getdevInfo{

    
    [AFN_DF POST:@"/system/driver/addBefore" Parameters:@{@"phone":self.numTF.text} File:@[@"idCardBack",@"idCardFront"] ImageArr:@[self.img2,self.img1] ContVC:self success:^(NSDictionary *responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSInteger info =  [responseObject[@"data"][@"state"]intValue];
        
        
        if (info == 99) {
            
            
            
            self.oneVC.frame = CGRectMake(10,70, Width - 20, 320);
            self.orcDic = responseObject[@"data"][@"obj"];
            UIView *reinfoVC = [[UIView alloc]initWithFrame:CGRectMake(0,190, Width - 20, 120)];
            reinfoVC.backgroundColor = [UIColor whiteColor];
            [self.oneVC addSubview:reinfoVC];
            
            [UILabel initWithDFLable:CGRectMake(20,10, 200, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(119) :@"请确认您的个人信息" :reinfoVC :0];
            
            [UILabel initWithDFLable:CGRectMake(20,40,Width  - 40, 30) :[UIFont systemFontOfSize:15*Width1] :[UIColor blackColor] :@"真实姓名" :reinfoVC :0];
            
            UILabel *namelab = [UILabel initWithDFLable:CGRectMake(Width- 200,40,170, 30) :[UIFont systemFontOfSize:15*Width1] :[UIColor blackColor] :self.orcDic[@"name"] :reinfoVC:0];
                namelab.textAlignment = 2;
   
   
            [UILabel initWithDFLable:CGRectMake(20,90,Width  - 40, 30) :[UIFont systemFontOfSize:15*Width1] :[UIColor blackColor] :@"身份证号" :reinfoVC :0];

            UILabel *numlab = [UILabel initWithDFLable:CGRectMake(Width- 200,90,170, 30) :[UIFont systemFontOfSize:15*Width1] :[UIColor blackColor] :self.orcDic[@"num"] :reinfoVC :0];
            numlab.textAlignment = 2;
            namelab.textAlignment = 2;
   
            
            self.TwoVC.frame = CGRectMake(10, 400, Width - 20, 200);
            self.ThereVC.frame = CGRectMake(10, 610, Width - 20, 200);
            self.mainView.contentSize = CGSizeMake(0, 890);
            self.tabVC.frame = CGRectMake(0, 830, Width, 60);
            
          
            
        }else if(info == 100){
            
                [self.view  addSubview:[Toast makeText:responseObject[@"data"][@"info"]]];
        }else if(info == 101){
            
                ///直接添加弹窗
            
            DirectAddVC *addVC = [[DirectAddVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
            addVC.phone = self.numTF.text;
            addVC.dic = responseObject[@"data"];
            addVC.block = ^(NSDictionary *dic) {
                self.block(dic);
            };
            [self.view addSubview:addVC];
            
        }else if(info == 102){
            
                ///身份确认弹窗
            DriectInfoVC *addVC = [[DriectInfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
            addVC.dic = responseObject[@"data"];
            [self.view addSubview:addVC];
            
            
        }
        
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

-(void)postinfo{
    
    
    [AFN_DF POST:@"/system/driver/getDriverDetailByDId" Parameters:@{@"dId":self.dic[@"id"]} success:^(NSDictionary *responseObject) {
        
        
        self.dic = responseObject[@"data"];
         [self setUI];
    } failure:^(NSError *error) {
        
    }];
    
    
}

-(void)setUI{
    
    UIView *backVC = [[UIView alloc]initWithFrame:CGRectMake(10,10, Width - 20, 50)];
    backVC.backgroundColor = [UIColor whiteColor];
    backVC.layer.cornerRadius = 4;
    [self.mainView addSubview:backVC];
    
    [UILabel initWithDFLable:CGRectMake(10, 10, 140, 30) :[UIFont systemFontOfSize:15*Width1] :COLOR2(51) :@"快成注册手机号" :backVC :0];
            
            self.numTF = [UITextField new];
            self.numTF.frame = CGRectMake(Width - 230, 10, 200, 30);
              self.numTF.font = [UIFont systemFontOfSize:14*Width1];
              self.numTF.placeholder = @"用于系统登录，请准确填写";
                self.numTF.textAlignment = 2;
        self.numTF.delegate = self;
    [self.numTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
              [backVC addSubview:self.numTF];
    
    
    if (self.dic) {
        
        self.numTF.text = self.dic[@"phone"];
        self.numTF.userInteractionEnabled = NO;
    }
    
    
    if (![self.phone isEqualToString:@""] && self.phone != nil) {
        
        self.numTF.text = self.phone;
        
    }
    
    
    
        for (int i = 0; i < 3; i ++) {
           
           UIView *back = [[UIView alloc]initWithFrame:CGRectMake(10,70 + (210 *i), Width - 20, 200)];
           back.backgroundColor = [UIColor whiteColor];
           back.layer.cornerRadius = 4;
           [self.mainView addSubview:back];
           
           
           if (i == 0) {
               
               [UILabel initWithDFLable:CGRectMake(10, 0, 80, 50) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :@"身份证信息" :back :0];
                 [UILabel initWithDFLable:CGRectMake(90, 0, 200, 50) :[UIFont systemFontOfSize:11*Width1] :[UIColor grayColor] :@"上传清晰的证件照认证较快哦！" :back :0];
    
               
               ImageVC *imageVC1 = [[ImageVC alloc]initWithFrame:CGRectMake(10, 50, (back.frame.size.width/2) - 20, 110)];
               imageVC1.imgs = @"身份证人像";
               imageVC1.vc = self;
             
               imageVC1.url = self.dic[@"idcardFront"];
               imageVC1.block = ^(UIImage * _Nonnull img) {
                   
                   self.img1 = img;
                   
                   if (![self.numTF.text isEqualToString:@""]  && self.img1 != nil && self.img2 != nil) {
                       
                       [self getdevInfo];
                   }
                   
                   
               };
               imageVC1.removerblock = ^(UIImage * _Nonnull img) {
                    self.img1 = nil;
               };
               [back addSubview:imageVC1];
               
               
               
               ImageVC *imageVC2 = [[ImageVC alloc]initWithFrame: CGRectMake(back.frame.size.width/2 + 10, 50, (back.frame.size.width/2) - 20, 110)];
                imageVC2.imgs = @"身份证国徽";
                 imageVC2.vc = self;
               imageVC2.url = self.dic[@"idcardBack"];
                 imageVC2.block = ^(UIImage * _Nonnull img) {
                       self.img2 = img;
                     
                     if (![self.numTF.text isEqualToString:@""]  && self.img1 != nil && self.img2 != nil) {
                         
                         [self getdevInfo];
                     }
                     
                   };
                 imageVC2.removerblock = ^(UIImage * _Nonnull img) {
                     self.img2 = nil;
                  };
             
               if (self.dic) {

                   if (![self.codes isEqualToString:@"1"]) {
                                        imageVC1.typess = @"1";
                                        imageVC2.typess = @"1";
                                }
                   
               }else{
               }
                
                 [back addSubview:imageVC2];
               
                [UILabel initWithDFLable:CGRectMake(10, 170, (back.frame.size.width/2) - 20, 15) :[UIFont systemFontOfSize:11*Width1] :[UIColor blackColor] :@"点击拍摄/上传身份证人面像" :back :1];
                [UILabel initWithDFLable: CGRectMake(back.frame.size.width/2 + 10, 170, (back.frame.size.width/2) - 20, 15) :[UIFont systemFontOfSize:11*Width1] :[UIColor blackColor] :@"点击拍摄/上传身份证国徽面" :back :1];
               
               
                   }else if(i == 1){
                       
                       
                       [UILabel initWithDFLable:CGRectMake(10, 0, 300, 50) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :@"驾驶证信息" :back :0];
                       
                 ImageVC *imageVC1 = [[ImageVC alloc]initWithFrame:CGRectMake(10, 50, (back.frame.size.width/2) - 20, 110)];
                         imageVC1.imgs = @"驾驶证正";
                         imageVC1.vc = self;
                           imageVC1.url = self.dic[@"iddriveFront"];
                         imageVC1.block = ^(UIImage * _Nonnull img) {
                             self.img3 = img;
                         };
                         imageVC1.removerblock = ^(UIImage * _Nonnull img) {
                             self.img3 = nil;
                         };
                         [back addSubview:imageVC1];
                         
                         
                         
                         ImageVC *imageVC2 = [[ImageVC alloc]initWithFrame: CGRectMake(back.frame.size.width/2 + 10, 50, (back.frame.size.width/2) - 20, 110)];
                          imageVC2.imgs = @"驾驶证反";
                           imageVC2.vc = self;
                          imageVC2.url = self.dic[@"iddriveBack"];
                           imageVC2.block = ^(UIImage * _Nonnull img) {
                               self.img4 = img;
                             };
                           imageVC2.removerblock = ^(UIImage * _Nonnull img) {
                               self.img4 = nil;
                            };
                           [back addSubview:imageVC2];
                   
                                    if (self.dic) {

                                          if (![self.codes isEqualToString:@"1"]) {
                                                               imageVC1.typess = @"1";
                                                               imageVC2.typess = @"1";
                                                       }
                                          
                                      }else{
                                      }
               
                       [UILabel initWithDFLable:CGRectMake(10, 170, (back.frame.size.width/2) - 20, 15) :[UIFont systemFontOfSize:11*Width1] :[UIColor blackColor] :@"点击拍摄/上传驾驶证主页" :back :1];
                                  [UILabel initWithDFLable: CGRectMake(back.frame.size.width/2 + 10, 170, (back.frame.size.width/2) - 20, 15) :[UIFont systemFontOfSize:11*Width1] :[UIColor blackColor] :@"点击拍摄/上传驾驶证副页" :back :1];
                       
                       
               
           }else{
                 [UILabel initWithDFLable:CGRectMake(10, 0, 300, 50) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :@"驾驶员从业资格证" :back :0];
               
                        ImageVC *imageVC1 = [[ImageVC alloc]initWithFrame:CGRectMake(10, 50, (back.frame.size.width/2) - 20, 110)];
                       imageVC1.imgs = @"从业资格证";
                           imageVC1.vc = self;
                           imageVC1.url = self.dic[@"qualificateFront"];
                           imageVC1.block = ^(UIImage * _Nonnull img) {
                                         self.img5 = img;
                                     };
                       imageVC1.removerblock = ^(UIImage * _Nonnull img) {
                           self.img5 = nil;
                           };
                                     [back addSubview:imageVC1];
                                     
                       
                           if (self.dic) {

                                 if (![self.codes isEqualToString:@"1"]) {
                                    imageVC1.typess = @"1";
                                             
                                 }
                                 
                             }else{
                             }
                        
                       [UILabel initWithDFLable:CGRectMake(10, 170, (back.frame.size.width/2) - 20, 15) :[UIFont systemFontOfSize:11*Width1] :[UIColor blackColor] :@"点击拍摄/上传驾驶员从业资格证" :back :1];

           }

            
            if (i == 0) {
                self.oneVC = back;
            }else if (i == 1){
                
                self.TwoVC = back;
            }else if (i == 2){
                
                self.ThereVC = back;
                
            }
            
       }
       
    
 
    
    
                self.tabVC = [[UIView alloc]initWithFrame:CGRectMake(0, 720, Width, 60)];
                        self.tabVC.backgroundColor = [UIColor whiteColor];
                        [self.mainView addSubview:self.tabVC];
    
    if (self.dic) {
        
       
      
        
        
        if ([self.codes isEqualToString:@"1"]) {
            
          UIButton *endBut = [UIButton initWithFrame:CGRectMake(20, 10, Width - 40, 40) :@"提交" :16*Width1];
                                                      endBut.layer.cornerRadius = 4;
                                                      endBut.backgroundColor = [UIColor redColor];
                                                      [endBut addTarget:self action:@selector(eidtAction) forControlEvents:(UIControlEventTouchUpInside)];
                                                      [self.tabVC addSubview:endBut];
            
            
        }else{
            
            UIButton *endBut = [UIButton initWithFrame:CGRectMake(20, 10, Width - 40, 40) :@"删除" :16*Width1];
                                                             endBut.layer.cornerRadius = 4;
                                                  endBut.layer.borderWidth = 1;
                                                  endBut.layer.borderColor = [[UIColor redColor]CGColor];
                                                  [endBut setTitleColor:[UIColor redColor] forState:0];
                                                      [endBut addTarget:self action:@selector(delegatAction) forControlEvents:(UIControlEventTouchUpInside)];
                                                             [self.tabVC addSubview:endBut];
            
        }
        
        
        
    }else{
        
        UIButton *endBut = [UIButton initWithFrame:CGRectMake(20, 10, Width - 40, 40) :@"提交" :16*Width1];
                                           endBut.layer.cornerRadius = 4;
                                           endBut.backgroundColor = [UIColor redColor];
                                           [endBut addTarget:self action:@selector(suppAction) forControlEvents:(UIControlEventTouchUpInside)];
                                           [self.tabVC addSubview:endBut];
    }
   
    
    
    
    if (self.dic) {
        
        self.oneVC.frame = CGRectMake(10,70, Width - 20, 320);
        UIView *reinfoVC = [[UIView alloc]initWithFrame:CGRectMake(0,190, Width - 20, 120)];
        reinfoVC.backgroundColor = [UIColor whiteColor];
        [self.oneVC addSubview:reinfoVC];
        
        [UILabel initWithDFLable:CGRectMake(20,10, 200, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(119) :@"请确认您的个人信息" :reinfoVC :0];
        
        [UILabel initWithDFLable:CGRectMake(20,40,Width  - 40, 30) :[UIFont systemFontOfSize:15*Width1] :[UIColor blackColor] :@"真实姓名" :reinfoVC :0];
        
        UILabel *namelab = [UILabel initWithDFLable:CGRectMake(Width- 200,40,170, 30) :[UIFont systemFontOfSize:15*Width1] :[UIColor blackColor] :self.dic[@"name"] :reinfoVC:0];
            namelab.textAlignment = 2;


        [UILabel initWithDFLable:CGRectMake(20,90,Width  - 40, 30) :[UIFont systemFontOfSize:15*Width1] :[UIColor blackColor] :@"身份证号" :reinfoVC :0];

        UILabel *numlab = [UILabel initWithDFLable:CGRectMake(Width- 200,90,170, 30) :[UIFont systemFontOfSize:15*Width1] :[UIColor blackColor] :[NSString stringWithFormat:@"%@",self.dic[@"idcard"]] :reinfoVC :0];
        numlab.textAlignment = 2;
        namelab.textAlignment = 2;

        
        self.TwoVC.frame = CGRectMake(10, 400, Width - 20, 200);
        self.ThereVC.frame = CGRectMake(10, 610, Width - 20, 200);
        self.mainView.contentSize = CGSizeMake(0, 890);
        self.tabVC.frame = CGRectMake(0, 830, Width, 60);
        
        
    }
    
    
    
}


///
-(void)delegatAction{
    
    
    [AFN_DF POST:@"/system/driver/delete" Parameters:@{@"dId":self.dic[@"id"]} success:^(NSDictionary *responseObject) {
           
           
           [[AFN_DF topViewController].navigationController popViewControllerAnimated:YES];
            [[AFN_DF topViewController].view addSubview:[Toast makeText:@"删除成功"]];

       } failure:^(NSError *error) {
           
       }];
       
    
    
}


-(void)eidtAction{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
         NSMutableArray *fileArray = [NSMutableArray array];
       NSMutableArray *imagearr = [NSMutableArray array];
       
              if (self.img1 != nil) {
              
                  [fileArray addObject:@"idCardBack"];
                  [imagearr addObject:self.img1];
               
           }
              if (self.img2 != nil) {
                  
                  [fileArray addObject:@"idCardFront"];
                   [imagearr addObject:self.img2];
              }
              if (self.img3 != nil) {
                  
                
                  [fileArray addObject:@"idDriveBack"];
                   [imagearr addObject:self.img3];
              }
              if (self.img4 != nil) {
                  
                  [fileArray addObject:@"idDriveFront"];
                   [imagearr addObject:self.img4];
              }
          if (self.img5 != nil) {
                      
                  [fileArray addObject:@"idCardBack"];
                [imagearr addObject:self.img5];
              }
      
      
      [dic setValue:self.dic[@"id"] forKey:@"driverId"];
    
      [dic setValue:self.dic[@"phone"] forKey:@"phone"];
      
    
   
      
      [AFN_DF POST:@"/system/driver/addoredit" Parameters:dic File:fileArray ImageArr:imagearr ContVC:self success:^(NSDictionary *responseObject) {
          
          for (UIViewController *vc in [self.navigationController viewControllers]) {
              
              if ([vc isKindOfClass:[DriverListController class]]) {
                  
                  [self.navigationController popToViewController:vc animated:YES];
                           [[AFN_DF topViewController].view addSubview:[Toast makeText:@"提交成功"]];
              }
          }
          
          
         
          
      } failure:^(NSError *error) {
          
      }];
      
    
    
}

///提交
-(void)suppAction{
    
    
         
    if (self.orcDic == nil) {
        
        return  [self.view addSubview:[Toast makeText:@"身份证识别失败，请重新上传"]];
    }
    
         if (self.img1 == nil) {
             
              return [self.view addSubview:[Toast makeText:@"请上传身份证人面像"]];
         }
         if (self.img2 == nil) {
                
                 return [self.view addSubview:[Toast makeText:@"请上传国徽面"]];
            }
         if (self.img3 == nil) {
                
                 return [self.view addSubview:[Toast makeText:@"请上传驾驶证主页"]];
            }
         if (self.img4 == nil) {
                
                 return [self.view addSubview:[Toast makeText:@"请上传驾驶证副页"]];
            }
         if (self.img5 == nil) {
                        
                         return [self.view addSubview:[Toast makeText:@"请上传驾驶员从业资格证"]];
                    }
         
         NSMutableArray *fileArray = [NSMutableArray arrayWithObjects:@"idCardBack",@"idCardFront",@"idDriveFront",@"idDriveBack",@"qualificateFront", nil];
           NSMutableArray *imagearr = [NSMutableArray arrayWithObjects:self.img2,self.img1,self.img3,self.img4,self.img5, nil];
           
   
    
    NSDictionary *coenDic = @{
        @"phone":self.numTF.text,
        @"num":self.orcDic[@"num"],
         @"driverId":@"",
    };

         [AFN_DF POST:@"/system/driver/addoredit" Parameters:coenDic File:fileArray ImageArr:imagearr ContVC:self success:^(NSDictionary *responseObject) {
             
             
             NSInteger info =  [responseObject[@"data"][@"state"]intValue];
                   
                   
                   if (info == 99) {
                       
                       [self.navigationController popViewControllerAnimated:YES];
                       if ([self.addType isEqualToString:@"1"]) {
                           self.block(@{});
                           
                       }else{
                           
                              [[AFN_DF topViewController].view addSubview:[Toast makeText:@"提交成功"]];
                       }
                       
                   }else if(info == 100){
                       
                           [self.view  addSubview:[Toast makeText:responseObject[@"data"][@"info"]]];
                       
                   }else if(info == 101){
                       
                           ///直接添加弹窗
                       
                       DirectAddVC *addVC = [[DirectAddVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                       addVC.phone = self.numTF.text;
                       addVC.dic = responseObject[@"data"];
                       addVC.block = ^(NSDictionary *dic) {
                           self.block(dic);
                       };
                       [self.view addSubview:addVC];
                       
                   }else if(info == 102){
                       
                           ///身份确认弹窗
                       DriectInfoVC *addVC = [[DriectInfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                     
                       addVC.dic = responseObject[@"data"];
                       [self.view addSubview:addVC];
                       
                       
                   }
                   
//                   [self.navigationController popViewControllerAnimated:YES];
                          
                   
                   
               } failure:^(NSError *error) {
                   
               }];
             
             
          
    
         
    
    
    
    
    
}


-(void)textFieldDidChange :(UITextField *)theTextField{
   
    if (theTextField.text.length == 11) {
        
        if (self.img2 != nil && self.img1 != nil) {
             [self getdevInfo];
        }
        
    }
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

      [textField resignFirstResponder];

  return YES;
}


-(UIScrollView *)mainView{
    
    if (_mainView == nil) {
        
        _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        _mainView.contentSize = CGSizeMake(0, 780);
        _mainView.bounces = NO;
        _mainView.backgroundColor = COLOR2(240);
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
