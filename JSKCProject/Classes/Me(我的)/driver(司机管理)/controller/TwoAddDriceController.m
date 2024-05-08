//
//  TwoAddDriceController.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "TwoAddDriceController.h"
#import "AddDriverController.h"
@interface TwoAddDriceController ()
@property(nonatomic,strong)UIScrollView *mainView;
@property(nonatomic,strong)UITextField *numTF;
@property(nonatomic,strong)UIImage *img1;
@property(nonatomic,strong)UIImage *img2;
@property(nonatomic,strong)UIImage *img3;
@property(nonatomic,strong)UIImage *img4;
@property(nonatomic,strong)UIImage *img5;

@property(nonatomic,strong)UIView *oneVC;
@property(nonatomic,strong)UIView *TwoVC;
@property(nonatomic,strong)UIView *ThereVC;
@property(nonatomic,strong)UIView *tabVC;
@end

@implementation TwoAddDriceController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = COLOR2(240);
    self.title =@"司机详情";
   
    if (self.dic) {
        
        [self postinfo];
    }else{
        
         [self setUI];
        
    }
    
}

-(void)postinfo{
    
    
    
    
    
    [AFN_DF POST:@"/system/driver/getDriverDetailByDId" Parameters:@{@"dId":self.dic[@"id"]} success:^(NSDictionary *responseObject) {
        
        
        self.dic = responseObject[@"data"];
         [self setUI];
    } failure:^(NSError *error) {
        
    }];
    
    
}

-(void)setUI{
    
    
    UIView *noteVC = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width,40)];
          noteVC.backgroundColor = COLOR(255, 244, 234);
          [self.mainView addSubview:noteVC];

    [UILabel initWithDFLable:CGRectMake(0,0, Width, 40) :[UIFont systemFontOfSize:14*Width1] :[UIColor redColor] :[NSString stringWithFormat:@"失败原因:%@",self.dic[@"failReason"]] :noteVC:1];
    
    
    UIView *backVC = [[UIView alloc]initWithFrame:CGRectMake(10,50, Width - 20, 50)];
    backVC.backgroundColor = [UIColor whiteColor];
    backVC.layer.cornerRadius = 4;
    [self.mainView addSubview:backVC];
    
    [UILabel initWithDFLable:CGRectMake(10, 10, 140, 30) :[UIFont systemFontOfSize:15*Width1] :COLOR2(51) :@"快成注册手机号" :backVC :0];
            
            self.numTF = [UITextField new];
            self.numTF.frame = CGRectMake(Width - 200, 10, 170, 30);
              self.numTF.font = [UIFont systemFontOfSize:14*Width1];
              self.numTF.placeholder = @"用于系统登录，请准确填写";
                self.numTF.textAlignment = 2;
              [backVC addSubview:self.numTF];
    
    
    if (self.dic) {
        
        self.numTF.text = self.dic[@"phone"];
    }
    
        for (int i = 0; i < 3; i ++) {
           
           UIView *back = [[UIView alloc]initWithFrame:CGRectMake(10,110 + (210 *i), Width - 20, 200)];
           back.backgroundColor = [UIColor whiteColor];
           back.layer.cornerRadius = 4;
           [self.mainView addSubview:back];
           
           
           if (i == 0) {
               
               [UILabel initWithDFLable:CGRectMake(10, 0, 80, 50) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :@"身份证信息" :back :0];
                 [UILabel initWithDFLable:CGRectMake(90, 0, 200, 50) :[UIFont systemFontOfSize:11*Width1] :[UIColor grayColor] :@"上传清晰的证件照认证较快哦！" :back :0];
    
               
               ImageVC *imageVC1 = [[ImageVC alloc]initWithFrame:CGRectMake(10, 50, (back.frame.size.width/2) - 20, 100)];
               imageVC1.imgs = @"驾驶证正";
               imageVC1.vc = self;
               
               imageVC1.url = self.dic[@"idcardFront"];
               imageVC1.block = ^(UIImage * _Nonnull img) {
                   
                   self.img1 = img;
               };
               imageVC1.removerblock = ^(UIImage * _Nonnull img) {
                    self.img1 = nil;
               };
               [back addSubview:imageVC1];
               
               
               
               ImageVC *imageVC2 = [[ImageVC alloc]initWithFrame: CGRectMake(back.frame.size.width/2 + 10, 50, (back.frame.size.width/2) - 20, 100)];
                imageVC2.imgs = @"驾驶证反";
                 imageVC2.vc = self;
               imageVC2.url = self.dic[@"idcardBack"];
                 imageVC2.block = ^(UIImage * _Nonnull img) {
                       self.img2 = img;
                   };
                 imageVC2.removerblock = ^(UIImage * _Nonnull img) {
                     self.img2 = nil;
                  };
                 [back addSubview:imageVC2];
                [UILabel initWithDFLable:CGRectMake(10, 160, (back.frame.size.width/2) - 20, 15) :[UIFont systemFontOfSize:11*Width1] :[UIColor blackColor] :@"点击拍摄/上传身份证人面像" :back :1];
                [UILabel initWithDFLable: CGRectMake(back.frame.size.width/2 + 10, 160, (back.frame.size.width/2) - 20, 15) :[UIFont systemFontOfSize:11*Width1] :[UIColor blackColor] :@"点击拍摄/上传身份证国徽面" :back :1];
               
               imageVC1.typess = @"1";
               imageVC2.typess = @"1";
                   }else if(i == 1){
                       
                       
                       [UILabel initWithDFLable:CGRectMake(10, 0, 300, 50) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :@"道路运输证信息" :back :0];
                       
                 ImageVC *imageVC1 = [[ImageVC alloc]initWithFrame:CGRectMake(10, 50, (back.frame.size.width/2) - 20, 100)];
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
                         
                         
                         
                         ImageVC *imageVC2 = [[ImageVC alloc]initWithFrame: CGRectMake(back.frame.size.width/2 + 10, 50, (back.frame.size.width/2) - 20, 100)];
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
               
               imageVC1.typess = @"1";
                           imageVC2.typess = @"1";
                       [UILabel initWithDFLable:CGRectMake(10, 160, (back.frame.size.width/2) - 20, 15) :[UIFont systemFontOfSize:11*Width1] :[UIColor blackColor] :@"点击拍摄/上传驾驶证主页" :back :1];
                                  [UILabel initWithDFLable: CGRectMake(back.frame.size.width/2 + 10, 160, (back.frame.size.width/2) - 20, 15) :[UIFont systemFontOfSize:11*Width1] :[UIColor blackColor] :@"点击拍摄/上传驾驶证副页" :back :1];
                       
                       
               
           }else{
                 [UILabel initWithDFLable:CGRectMake(10, 0, 300, 50) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :@"驾驶员从业资格证" :back :0];
               
                        ImageVC *imageVC1 = [[ImageVC alloc]initWithFrame:CGRectMake(10, 50, (back.frame.size.width/2) - 20, 100)];
                       imageVC1.imgs = @"驾驶证正";
                           imageVC1.vc = self;
                           imageVC1.url = self.dic[@"iddriveFront"];
                           imageVC1.block = ^(UIImage * _Nonnull img) {
                                         self.img5 = img;
                                     };
                       imageVC1.removerblock = ^(UIImage * _Nonnull img) {
                           self.img5 = nil;
                           };
                                     [back addSubview:imageVC1];
                                     imageVC1.typess = @"1";
                                             
                                     
                       [UILabel initWithDFLable:CGRectMake(10, 160, (back.frame.size.width/2) - 20, 15) :[UIFont systemFontOfSize:11*Width1] :[UIColor blackColor] :@"点击拍摄/上传驾驶员从业资格证" :back :1];

           }
            
            if (i == 0) {
                self.oneVC = back;
            }else if (i == 1){
                
                self.TwoVC = back;
            }else if (i == 2){
                
                self.ThereVC = back;
                
            }
            

       }
       
    
                UIView *tabVC = [[UIView alloc]initWithFrame:CGRectMake(0, Height - 60, Width, 60)];
                        tabVC.backgroundColor = [UIColor whiteColor];
                        [self.view addSubview:tabVC];
    
                    UIButton *deleBut = [UIButton initWithFrame:CGRectMake(20, 10, Width/2 - 40, 40) :@"删除" :16*Width1];
                                    deleBut.layer.cornerRadius = 4;
                    deleBut.layer.borderColor = [[UIColor redColor]CGColor];
                    deleBut.layer.borderWidth = 1;
                    [deleBut setTitleColor:[UIColor redColor] forState:0];
                    [deleBut addTarget:self action:@selector(delegate) forControlEvents:(UIControlEventTouchUpInside)];
                    [tabVC addSubview:deleBut];
    
                UIButton *endBut = [UIButton initWithFrame:CGRectMake(Width/2 + 20, 10, Width/2 - 40, 40) :@"重新认证" :16*Width1];
                  endBut.layer.cornerRadius = 4;
                  endBut.backgroundColor = [UIColor redColor];
                [endBut addTarget:self action:@selector(suppAction) forControlEvents:(UIControlEventTouchUpInside)];
                 [tabVC addSubview:endBut];
    
    
    
    if (self.dic) {
        
        self.oneVC.frame = CGRectMake(10,110, Width - 20, 320);
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

        
        self.TwoVC.frame = CGRectMake(10, 440, Width - 20, 200);
        self.ThereVC.frame = CGRectMake(10, 650, Width - 20, 200);
        self.mainView.contentSize = CGSizeMake(0, 930);
        self.tabVC.frame = CGRectMake(0, 870, Width, 60);
        
        
    }
    
    
    
}


-(void)delegate{
    
    
    [AFN_DF POST:@"/system/driver/delete" Parameters:@{@"dId":self.dic[@"id"]} success:^(NSDictionary *responseObject) {
        
        
                [[AFN_DF topViewController].navigationController popViewControllerAnimated:YES];
                [[AFN_DF topViewController].view addSubview:[Toast makeText:@"删除成功"]];
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

///提交
-(void)suppAction{
    
    AddDriverController *dicrce = [AddDriverController new];
    dicrce.phone = self.dic[@"phone"];
    dicrce.codes =@"1";
    [self.navigationController pushViewController:dicrce animated:YES];
    
}

-(UIScrollView *)mainView{
    
    if (_mainView == nil) {
        
        _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        _mainView.contentSize = CGSizeMake(0, 820);
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
