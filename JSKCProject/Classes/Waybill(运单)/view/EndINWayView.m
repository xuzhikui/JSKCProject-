//
//  EndINWayView.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/24.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "EndINWayView.h"

@implementation EndINWayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCompleteBlock];
        [self setUI];
    }
    return self;
}

-(void)layoutSubviews{
    
    self.unitLab.text = self.dic[@"newUnit"];
    
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
    
    
        [self initCompleteBlock];
    
}




-(void)setUI{
    
    [self gets];
    self.ButCode = @"0";
    self.code = YES;
     self.backVC = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
         self.backVC.backgroundColor = [UIColor blackColor];
         self.backVC.alpha = 0.5;
        UITapGestureRecognizer *TapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeBlocks)];
             self.backVC.userInteractionEnabled = YES;
              [ self.backVC addGestureRecognizer:TapGR];
         
         [self addSubview:self.backVC];

    
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, NavaBarHeight, Width, Height - NavaBarHeight)];
    back.backgroundColor = [UIColor whiteColor];
    [self addSubview:back];
    

       [UILabel initWithDFLable:CGRectMake(22, 15 , Width, 30) :[UIFont boldSystemFontOfSize:22*Width1]:[UIColor blackColor] :
        @"确认到达":back :0];
    
    UIButton *closeBut  = [UIButton initWithFrame:CGRectMake(Width -  30, 20, 20, 20) :@"关闭"];
    [closeBut addTarget:self action:@selector(removeBlocks) forControlEvents:(UIControlEventTouchUpInside)];
    [back addSubview:closeBut];
    
    
       
//    [UILabel initWithDFLable:CGRectMake(22, 50, 200, 30) :[UIFont systemFontOfSize:15*Width1] :COLOR2(51) :@"实际卸货时间" :back :0];
//
//    self.selectTimeBut = [UIButton initWithFrame:CGRectMake(Width - 170, 50, 135, 30) :@"请选择实际卸货时间" :11];
//    [self.selectTimeBut setTitleColor:COLOR2(153) forState:0];
//    [self.selectTimeBut addTarget:self action:@selector(selectTime) forControlEvents:(UIControlEventTouchUpInside)];
//    self.selectTimeBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [back addSubview:self.selectTimeBut];
//
//
//    UIButton *imgBut = [UIButton initWithFrame:CGRectMake(Width - 30, 55, 12, 20) :@"返 回 拷贝 2"];
//    [back addSubview:imgBut];
    
    UIView *fg1 = [[UIView alloc]initWithFrame:CGRectMake(22, 89.5, Width - 44, 1)];
    fg1.backgroundColor = COLOR2(241);
    [back addSubview:fg1];
    
    
     [UILabel initWithDFLable:CGRectMake(22, 50, 200, 30) :[UIFont systemFontOfSize:15*Width1] :COLOR2(51) :@"实际卸货量" :back :0];
    
//    UIView *fg2 = [[UIView alloc]initWithFrame:CGRectMake(22, 139.5, Width - 44, 1)];
//      fg2.backgroundColor = COLOR2(241);
//      [back addSubview:fg2];
    
    
    self.numTF = [[UITextField alloc]initWithFrame:CGRectMake(Width - 190, 50, 150, 30)];
    self.numTF.font = [UIFont systemFontOfSize:11];
    self.numTF.placeholder = @"请输入实际卸货量";
    [back addSubview:self.numTF];
    self.numTF.textAlignment = 2;
    
    
    
    self.unitLab = [UILabel initWithDFLable:CGRectMake(Width - 35, 50, 20, 30) :[UIFont systemFontOfSize:12*Width1] :COLOR2(51) :@"" :back :0];
    
    
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:15*Width1]};
            
               CGFloat width = [@"请上传发货凭证" boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
    
     [UILabel initWithDFLable:CGRectMake(22, 110, width, 20) :[UIFont systemFontOfSize:15*Width1] :COLOR2(51) :@"请上传发货凭证" :back :0];
    
    
    
     [UILabel initWithDFLable:CGRectMake(width + 25, 110, Width, 20) :[UIFont systemFontOfSize:11] :COLOR2(153) :@"请保证凭证图片完整、清晰可见" :back :0];
    

    
    self.contImageBut = [UIButton initWithFrame:CGRectMake((Width - 190)/2, 140, 190, 120) :@"卸货回单"];
    [self.contImageBut addTarget:self action:@selector(onTapGR:) forControlEvents:(UIControlEventTouchUpInside)];
    self.contImageBut.backgroundColor = [UIColor whiteColor];
    [back addSubview:self.contImageBut];
    
        self.colseBut = [UIButton initWithFrame:CGRectMake((Width - 190)/2 + 170, 140, 20, 20) :@"关闭"];
       [self.colseBut addTarget:self action:@selector(closeAction) forControlEvents:(UIControlEventTouchUpInside)];
       [back addSubview: self.colseBut];
        self.colseBut.hidden = YES;
    
    
    [UILabel initWithDFLable:CGRectMake((Width - 190)/2, 260, 190, 20) :[UIFont systemFontOfSize:12] :COLOR2(51) :@"点击拍照/上传卸货凭证" :back :1];
    
//
    
    self.outImageBut = [UIButton initWithFrame:CGRectMake((Width - 190)/2, 290, 190, 120) :@"icon_defeat_image"];
    self.outImageBut.tag = 1001;
    self.outImageBut.backgroundColor = [UIColor whiteColor];
    [self.outImageBut addTarget:self action:@selector(onTapGR:) forControlEvents:(UIControlEventTouchUpInside)];
      [back addSubview:self.outImageBut];
    
     [UILabel initWithDFLable:CGRectMake((Width - 190)/2,410, 190, 20) :[UIFont systemFontOfSize:12] :COLOR2(51) :@"点击拍照/上传卸货图片" :back :1];
    
    self.twoBut = [UIButton initWithFrame:CGRectMake((Width - 190)/2 + 170, 290, 20, 20) :@"关闭"];
        [self.twoBut addTarget:self action:@selector(twocloseAction) forControlEvents:(UIControlEventTouchUpInside)];
        [back addSubview: self.twoBut];
        self.twoBut.hidden = YES;
    
    
    
    
     [UILabel initWithDFLable:CGRectMake(0, back.frame.size.height - 105, Width, 20) :[UIFont systemFontOfSize:12*Width1] :COLOR2(51) :@"请仔细阅读合同内容" :back :1];
    
    
        NSDictionary *attrs1 = @{NSFontAttributeName:[UIFont systemFontOfSize:12*Width1]};
              
                 CGFloat widths = [@"我已阅读并同意签署《货物运输合同》" boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs1 context:nil].size.width;
    
        _textView = [[UITextView alloc] initWithFrame:CGRectMake((Width - widths)/2 + 5, back.frame.size.height - 85,widths + 10, 30)];
        _textView.font = [UIFont systemFontOfSize:12*Width1];
        _textView.textColor = COLOR2(51);
        _textView.text = @"我已阅读并同意签署《货物运输合同》";
        [back addSubview:_textView];
//   titleEdgeInsets

    
    self.selectBut = [UIButton initWithFrame:CGRectMake((Width - widths)/2 - 15, back.frame.size.height - 85, 30, 30) :@"选中"];
    [self.selectBut addTarget:self action:@selector(selectAction) forControlEvents:(UIControlEventTouchUpInside)];
    [back addSubview:self.selectBut];
       
       [self setfwb:_textView :31 :12];
    
    
    
    UIButton *suppBut = [UIButton initWithFrame:CGRectMake(20, back.frame.size.height - 50, Width - 40, 40) :@"提交" :18*Width1];
    suppBut.backgroundColor = COLOR(245, 12, 12);
    suppBut.layer.cornerRadius = 4;
    [suppBut addTarget:self action:@selector(suppAction) forControlEvents:(UIControlEventTouchUpInside)];
    [back addSubview:suppBut];
    

    
}

-(void)closeAction{
    
    
    [self.contImageBut setImage:[UIImage imageNamed:@"发货凭证"] forState:0];
    self.img = nil;
     self.contImageBut.userInteractionEnabled =YES;
    self.colseBut.hidden = YES;
}


-(void)twocloseAction{
    
    [self.outImageBut setImage:[UIImage imageNamed:@"icon_defeat_image"] forState:0];
       self.twoimg = nil;
        self.outImageBut.userInteractionEnabled =YES;
       self.twoBut.hidden = YES;
    
    
}

///是否选择协议
-(void)selectAction{
    
    if (self.code) {
        
        self.code = NO;
        [self.selectBut setImage:[UIImage imageNamed:@"未选中"] forState:0];
        
        
    }else{
        
        self.code = YES;
          [self.selectBut setImage:[UIImage imageNamed:@"选中"] forState:0];
    }
    
    
}

-(void)suppAction{
    
    
    
    
    
    if (self.lont == nil) {

         [self.vc.view addSubview:[Toast makeText:@"定位错误，正在重新定位"]];
        [self initCompleteBlock];
        return;
    }
    
    
    
    if (self.code == NO) {
        
        return [self.vc.view addSubview:[Toast makeText:@"请您先阅读并同意运输协议"]];
    }
    
    if (self.img == nil) {
        
         return [self.vc.view addSubview:[Toast makeText:@"请您上传发货凭证"]];
    }
    
    

    
    if ([self.numTF.text isEqualToString:@""]) {
           
           return [self.vc.view addSubview:[Toast makeText:@"请输入货物重量"]];
       }
    
    
    
    
    NSString *loadPlaceCode = [NSString stringWithFormat:@"%@", self.dic[@"loadPlaceCode"]];
    if (loadPlaceCode == nil || [loadPlaceCode isEqualToString:@"<null>"]) {
        loadPlaceCode = @"0";
    }
    NSString *unloadPlaceCode = [NSString stringWithFormat:@"%@",self.dic[@"unloadPlaceCode"]];
    if (unloadPlaceCode == nil ||  [unloadPlaceCode isEqualToString:@"<null>"]) {
        unloadPlaceCode = @"0";
    }
    
    NSArray *arr = @[@{@"shippingNoteNumber":[NSString stringWithFormat:@"%@",self.dic[@"waybillId"]],@"serialNumber":@"0000",@"startCountrySubdivisionCode":loadPlaceCode,@"endCountrySubdivisionCode":unloadPlaceCode}];
    
//    MapService *mp =  [[MapService alloc]init];
//      [mp stopLocationWithShippingNoteInfos:arr listener:^(id  _Nonnull model, NSError * _Nonnull error) {
////          result//结果
////          waybillId 运单/tsmanage/waybill/confirmSDK
//          [AFN_DF POST:@"/tsmanage/waybill/confirmSDK" Parameters:@{@"result":@"0",@" waybillId":[NSString stringWithFormat:@"%@",self.dic[@"waybillId"]]} success:^(NSDictionary *responseObject) {
//              
//                
//              
//              
//          } failure:^(NSError *error) {
//            
//          }];
//          
          
          
          
//      }];
    
    
    
    
    NSDictionary *dic = @{
        @"localItude":self.lont,
        @"actualReceive":self.numTF.text,
        @"waybillId":self.dic[@"waybillId"],
    };
    
    
    NSArray *imagearr;
    
    if (self.twoimg != nil) {
        imagearr = @[self.img,self.twoimg];
    }else{
        
        imagearr = @[self.img];
    }
    
    
    [AFN_DF POST:@"/tsmanage/waybill/confirm" Parameters:dic File:@[@"hfile",@"zxfile"] ImageArr:imagearr ContVC:[AFN_DF topViewController] success:^(NSDictionary *responseObject) {
        
       
            self.block(self.dic);
        
      [self clanAction];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}



-(void)removeBlocks{
    
    [self clanAction];
   
    
  
    
}



-(void)clanAction{
    
    [self.dateView removeFromSuperview];
      [self removeFromSuperview];
    if ([self.codes isEqualToString:@"1"]) {
        [[AFN_DF topViewController].navigationController setNavigationBarHidden:YES animated:YES];
        [AFN_DF topViewController].tabBarController.tabBar.hidden = NO;
    }else{
        [[AFN_DF topViewController].navigationController setNavigationBarHidden:NO animated:YES];
    }
    [self.vc.tabBarController hideTabBar:NO animated:YES];
}


#pragma make  avdelegate--
///选择相册
- (void)onTapGR:(UIButton *)but
{
    
    if (but.tag == 1001) {
       
        self.ButCode = @"1";
    }else{
        
        self.ButCode = @"0";
    }
    
    
    // 选择控制器
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    actionsheet.tag = 1000;
    [actionsheet showInView:self.vc.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) // 拍照
    {
        //先判断当前设备是否支持相机（模拟器不支持相机，如果强行打开程序会崩）
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            
            picker.allowsEditing = NO;//设置拍照后的图片可被编辑
            picker.sourceType = sourceType;
            //设置导航栏背景颜色
            
            //            picker.navigationBar.barTintColor =
            
            //设置右侧取消按钮的字体颜色
            
            picker.navigationBar.tintColor = [UIColor blackColor];
            [self.vc presentViewController:picker animated:YES completion:nil];
        }else // 模拟器
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"当前设备不支持相机" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alert.tag = 1;
            [alert show];
        }
    }else if (buttonIndex == 1) // 相册
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        //指定打开相册
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = NO;//允许编辑（允许编辑才能选择图片）
        
        
        picker.navigationBar.tintColor = [UIColor  blackColor];
        [self.vc presentViewController:picker animated:NO completion:nil];
    }
}
#pragma mark - 相册delegate
//协议中的方法，当用户选择某个图片时被调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
       ///可编辑为 UIImagePickerControllerEditedImage
   
    
    if ([self.ButCode isEqualToString:@"0"]) {
        self.img = image;
         self.colseBut.hidden = NO;
         self.contImageBut.userInteractionEnabled = NO;
         [self.contImageBut setImage:image forState:0];
         [picker dismissViewControllerAnimated:YES completion:nil];
    }else{
        
            self.twoimg = image;
         self.twoBut.hidden = NO;
         self.outImageBut.userInteractionEnabled = NO;
         [self.outImageBut setImage:image forState:0];
         [picker dismissViewControllerAnimated:YES completion:nil];
        
    }
    [self.vc.tabBarController hideTabBar:YES animated:YES];

 
}
//协议中的方法，当用户取消时被调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.vc.tabBarController hideTabBar:YES animated:YES];
}



-(void)setfwb:(UITextView *)button :(NSInteger)start :(NSInteger)over{
    
    NSInteger font = 12*Width1;

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并同意签署《货物运输合同》"];

    [attributedString addAttribute:NSLinkAttributeName

    value:@"liantong"

    range:[[attributedString string] rangeOfString:@"《货物运输合同》"]];


    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, attributedString.length)];

    _textView.attributedText = attributedString;

    _textView.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor redColor],

    NSUnderlineColorAttributeName: [UIColor lightGrayColor],

    NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};

    _textView.delegate = self;

     //必须禁止输入，否则点击将弹出输入键盘
    _textView.editable = NO;

    _textView.scrollEnabled = NO;

    _textView.textAlignment = 1;

}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{

        NSString *urlStr =[NSString stringWithFormat:@"%@",URL];
        if ([urlStr isEqualToString:@"liantong"]) {
///联通协议
            if ([[AFN_DF topViewController].navigationController.topViewController isEqual:[AFN_DF topViewController].navigationController.viewControllers.firstObject]) {
                [self clanAction];
            }

                   WKController *wkVC = [WKController new];
                   wkVC.urls = self.dic[@"contractUrl"];
                   wkVC.title = @"货物运输合同";
                   [[AFN_DF topViewController].navigationController pushViewController:wkVC animated:YES];
               

            return NO;

        }


return YES;

}

///选择时间
-(void)selectTime{
    if (self.dateView != nil) {
    
        [self.dateView removeFromSuperview];
        
    }
  
        self.dateView = [[THDatePickerView alloc] initWithFrame:CGRectMake(0, Height - 250*Height1, Width, 250*Height1)];
        
        // 设置代理
        self.dateView.delegate = self;
        // 设置标题
        self.dateView.title = @"请选择时间";
        [self.vc.view addSubview:self.dateView];
        [self.dateView show];

    
    //    [self.dateView show];
    
    
}

#pragma mark - THDatePickerViewDelegate
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    NSLog(@"保存点击");
    self.strTime = timer;
    [self.selectTimeBut setTitle:timer forState:0];
    [self.dateView removeFromSuperview];
}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate {
    
    [self.dateView removeFromSuperview];
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
            NSString *lo =  [NSString stringWithFormat:@"%f",location.coordinate.longitude];
            NSString *lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
//                        NSDictionary *dic = @{@"lo":self->lo,@"lat":self->lat,@"city":@""};
//                        [[LoactionModel shareInstance]setValuesForKeysWithDictionary:dic];
            self.lont = [NSString stringWithFormat:@"%@,%@",lo,lat];
               
        }
        

        if (regeocode)
        {
//            NSString *lo =  [NSString stringWithFormat:@"%f",location.coordinate.longitude];
//            NSString *lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
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


@end
