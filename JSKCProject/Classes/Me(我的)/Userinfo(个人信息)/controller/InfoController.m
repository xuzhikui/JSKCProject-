//
//  InfoController.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/29.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "InfoController.h"
#import "InfoAuthViewController.h"
#import <HSFaceDetector/LiveHeader.h>
#import <HSFaceDetector/LiveDetectController.h>
#import <HSFaceDetector/LiveCamera.h>
#import "ResultViewController.h"
@interface InfoController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate,LiveDetectControllerDelegate>
{
    UIButton *fBut;
     UIButton *zBut;
    UIButton *suppBut;
}
@property (nonatomic, strong) BRDatePickerView *pickerView;
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *livingBodyAuth;

@end

@implementation InfoController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
      [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = COLOR2(240);
    
    [self setUI];
}

-(void)setUI{
    
    _table = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
              self.table.delegate = self;
              self.table.dataSource = self;
    self.table.backgroundColor = COLOR2(240);
              [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
            [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
            [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell3"];
    self.table.layer.cornerRadius = 4;
    self.table.layer.masksToBounds = YES;
              self.table.separatorStyle =UITableViewCellSeparatorStyleNone;
              [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        if (UserModel.shareInstance.type == 1) {
            make.top.mas_equalTo(NavaBarHeight+ 10.0f);
        }else{
            make.top.mas_equalTo(10.0f);
        }
        make.bottom.mas_equalTo(-10.0f);
        make.left.mas_equalTo(10.0f);
        make.right.mas_equalTo(-10.0f);
    }];
    if (UserModel.shareInstance.type == 1) {
        self.title = @"身份认证";
        UIView *navBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, NavaBarHeight)];
        navBgView.backgroundColor = UIColor.whiteColor;
        [self.view insertSubview:navBgView atIndex:0];
        if ([self.cyrVerify integerValue] != 0) {
            WeakSelf
            [AFN_DF POST:@"/system/account/getDetail" Parameters:nil success:^(NSDictionary *responseObject) {
                //验证成功
                weakSelf.info = [responseObject objectForKey:@"data"];
                [weakSelf.table reloadData];
            } failure:^(NSError *error) {

            }];
        }
        if ([self.cyrVerify integerValue] != 1) {
            UIView *tabvc = [[UIView alloc]initWithFrame:CGRectMake(0, Height - 60 - UISafeAreaBottomHeight, Width,60+UISafeAreaBottomHeight)];
            tabvc.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:tabvc];

           suppBut =  [UIButton initWithFrame:CGRectMake(20, 10, Width - 40, 40) :@"提交认证" :16*Width1];
            suppBut.backgroundColor = COLOR2(238);
            suppBut.layer.cornerRadius = 4;
            [suppBut setTitleColor:COLOR2(153) forState:0];
            suppBut.userInteractionEnabled = NO;
            [suppBut addTarget:self action:@selector(suppAction) forControlEvents:(UIControlEventTouchUpInside)];
            [tabvc addSubview:suppBut];
        }else{
            if (UserModel.shareInstance.hasBankCard == nil || UserModel.shareInstance.hasBankCard.integerValue == 0) {
                CardInfoVC *cardVC = [[CardInfoVC alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
                [self.view addSubview:cardVC];
            }
        }
    }
}

- (void)setInfo:(id)info{
    _info = info;
    [self.table reloadData];
}


-(void)suppAction{
    
    if([self.livingBodyAuth isEqualToString:@"1"]){
        [self startLive];
    }else{
        [self autocers];
    }
}


-(void)autocers{
    NSDictionary *dic = @{
        
        @"name":self.dic[@"name"],
        @"num":self.dic[@"num"],
        @"phone":[UserModel shareInstance].username,
    };
    
    [AFN_DF POST:@"/system/account/auth" Parameters:dic File:@[@"idcardBack",@"idcardFront"] ImageArr:@[self.img2,self.img1] ContVC:self success:^(NSDictionary *responseObject) {
        
        [self getUserInfo];

    } failure:^(NSError *error) {
        
    }];
}

-(void)submitIdCardInfo{
    WeakSelf
    [AFN_DF POST:@"/system/auth/realNameAuth" Parameters:@{@"name":self.dic[@"name"],@"idcard":self.dic[@"num"]} success:^(NSDictionary *responseObject) {
        //验证成功
        if (weakSelf.submitIdCardInfoBlock) {
            if ([responseObject[@"code"] integerValue] == 200) {
                weakSelf.submitIdCardInfoBlock(responseObject);
            }else{
                weakSelf.submitIdCardInfoBlock(nil);
            }
        }
    } failure:^(NSError *error) {
//        if (weakSelf.submitIdCardInfoBlock) {
//            weakSelf.submitIdCardInfoBlock(nil);
//        }
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] init];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
           cell.backgroundColor = [UIColor clearColor];
            cell.layer.cornerRadius = 4;
            cell.layer.masksToBounds = YES;
        UIView *backVC = [[UIView alloc]initWithFrame:CGRectMake(cell.frame.origin.x,0, Width - 20,(self.img2 != nil && self.img1 != nil ? 200 : 270.0f))];
           backVC.backgroundColor = [UIColor whiteColor];
           backVC.layer.cornerRadius = 4;
            backVC.layer.masksToBounds = YES;
           [cell.contentView addSubview:backVC];
        
        [UILabel initWithDFLable:CGRectMake(10, 17, 75, 13) :[UIFont systemFontOfSize:13] :COLOR2(51) :@"身份证信息" :backVC :0];
        [UILabel initWithDFLable:CGRectMake(85, 20, 155, 10) :[UIFont systemFontOfSize:10] :COLOR2(153) :@"上传清晰的证件照认证较快哦！" :backVC :0];
        
        UIImageView *sfzzImage = [[UIImageView alloc]initWithFrame:CGRectMake(15.0f,50, 145,90.0f)];
        sfzzImage.contentMode = UIViewContentModeScaleAspectFill;
        sfzzImage.layer.masksToBounds = YES;
        sfzzImage.image = [UIImage imageNamed:@"身份证正面背景"];
        [backVC addSubview:sfzzImage];
        
        [UILabel initWithDFLable:CGRectMake((CGRectGetWidth(sfzzImage.frame) - 145)*0.5+sfzzImage.frame.origin.x, 150, 145, 20) :[UIFont systemFontOfSize:10] :COLOR2(68) :@"点击拍摄/上传身份证人像面" :backVC :1];
        
//        if (zBut == nil) {
        zBut = [UIButton buttonWithType:UIButtonTypeCustom];
        zBut.frame = sfzzImage.frame;
        [zBut setImage:self.img1 forState:UIControlStateNormal];
        [zBut addTarget:self action:@selector(zAction) forControlEvents:(UIControlEventTouchUpInside)];
        zBut.contentMode = UIViewContentModeScaleAspectFill;
        zBut.layer.masksToBounds = YES;
        zBut.imageView.contentMode = UIViewContentModeScaleAspectFill;
        zBut.imageView.layer.masksToBounds = YES;
        zBut.layer.cornerRadius = 4;
        zBut.layer.masksToBounds = YES;
        zBut.userInteractionEnabled = [self.cyrVerify integerValue] == 0;
        [backVC addSubview:zBut];
        
        if ([self.cyrVerify integerValue] == 0) {
            UIButton *zdeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [zdeleteButton setImage:[UIImage imageNamed:@"delete_small"] forState:UIControlStateNormal];
            zdeleteButton.frame = CGRectMake(CGRectGetMaxX(sfzzImage.frame) - 10.0f, sfzzImage.frame.origin.y - 10.0f, 20, 20);
            zdeleteButton.tag = 1;
            zdeleteButton.hidden = self.img1 == nil;
            [zdeleteButton addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
            [backVC addSubview:zdeleteButton];
        }else{
            zBut.userInteractionEnabled = NO;
            [zBut sd_setImageWithURL:[NSURL URLWithString:self.info[@"idcardFront"]] forState:UIControlStateNormal];
        }

        UIImageView *sfzfImage = [[UIImageView alloc]initWithFrame:CGRectMake(backVC.frame.size.width - 160.0f,50.0f, 145,90)];
        sfzfImage.image = [UIImage imageNamed:@"身份证背面背景"];
        sfzfImage.contentMode = UIViewContentModeScaleAspectFill;
        sfzfImage.layer.masksToBounds = YES;
        [backVC addSubview:sfzfImage];
        [UILabel initWithDFLable:CGRectMake((CGRectGetWidth(sfzfImage.frame) - 145)*0.5+sfzfImage.frame.origin.x, 150, 145, 20) :[UIFont systemFontOfSize:10] :COLOR2(68) :@"点击拍摄/上传身份证国徽面" :backVC :1];

//          if (fBut == nil) {
        fBut = [UIButton buttonWithType:UIButtonTypeCustom];
        fBut.frame = sfzfImage.frame;
        [fBut addTarget:self action:@selector(fAction) forControlEvents:(UIControlEventTouchUpInside)];
        fBut.contentMode = UIViewContentModeScaleAspectFill;
        fBut.layer.masksToBounds = YES;
        fBut.imageView.contentMode = UIViewContentModeScaleAspectFill;
        fBut.imageView.layer.masksToBounds = YES;
        fBut.layer.cornerRadius = 4;
        fBut.layer.masksToBounds = YES;
        [fBut setImage:self.img2 forState:UIControlStateNormal];
        [backVC addSubview:fBut];
        if ([self.cyrVerify integerValue] == 0) {
            UIButton *fdeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [fdeleteButton setImage:[UIImage imageNamed:@"delete_small"] forState:UIControlStateNormal];
            fdeleteButton.frame = CGRectMake(CGRectGetMaxX(sfzfImage.frame) - 10.0f, sfzfImage.frame.origin.y - 10.0f, 20, 20);
            fdeleteButton.tag = 2;
            [fdeleteButton addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
            fdeleteButton.hidden = self.img2 == nil;
            [backVC addSubview:fdeleteButton];
        }else{
            fBut.userInteractionEnabled = NO;
            [fBut sd_setImageWithURL:[NSURL URLWithString:self.info[@"idcardBack"]] forState:UIControlStateNormal];
        }

           return cell;

    }else{
        
                
        if ((self.img1 == nil || self.img2 == nil) && [self.cyrVerify integerValue] == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
             cell.backgroundColor = [UIColor whiteColor];
            cell.layer.cornerRadius = 4;
            [UILabel initWithDFLable:CGRectMake(20,20, 200, 20) :[UIFont systemFontOfSize:14*Width1] :COLOR2(119) :@"拍摄身份证要求:" :cell.contentView :0];
            
            [UILabel initWithDFLable:CGRectMake(20,50,Width  - 60, 20) :[UIFont systemFontOfSize:12*Width1] :COLOR2(119) :@"大陆公民持有的本人有效二代身份证" :cell.contentView :0];
            
          UILabel *tips =  [UILabel initWithDFLable:CGRectMake(20,70,Width  - 60, 20) :[UIFont systemFontOfSize:12*Width1] :[UIColor redColor] :@"拍摄时确保身份证边框完整，字体清晰，亮度均匀;" :cell.contentView :0];
            
            [self setfwb:tips];
            
            
            UIImageView *imgVC =[[UIImageView alloc]initWithFrame:CGRectMake(20, 110, Width - 60, 60)];
            imgVC.image = [UIImage imageNamed:@"标准"];
            
            [cell.contentView addSubview:imgVC];
            
               return cell;
            
        }else{
            
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

         
            cell.backgroundColor = [UIColor whiteColor];
            cell.layer.cornerRadius = 4;
            [UILabel initWithDFLable:CGRectMake(10,10, 200, 15) :[UIFont systemFontOfSize:13] :COLOR2(51) :@"请确认您的个人信息：" :cell.contentView :0];
            [UILabel initWithDFLable:CGRectMake(15,40, 50, 15) :[UIFont systemFontOfSize:11] :COLOR2(102) :@"真实姓名" :cell.contentView :0];
            [UILabel initWithDFLable:CGRectMake(60,42.5,12, 12) :[UIFont systemFontOfSize:11] :COLOR(245,12,12) :@"*" :cell.contentView :0];
            
            
            UITextField *titleTextField = [[UITextField alloc] init];
            titleTextField.font = [UIFont systemFontOfSize:11];
            titleTextField.textColor = COLOR2(51);
            titleTextField.text = [self.cyrVerify integerValue] == 0 ? self.dic[@"name"] : self.info[@"name"];
            titleTextField.frame = CGRectMake(Width - 215,40,185, 20);
            titleTextField.textAlignment = NSTextAlignmentRight;
            titleTextField.delegate = self;
            titleTextField.tag = 1;
            titleTextField.returnKeyType = UIReturnKeyDone;
            titleTextField.userInteractionEnabled = [self.cyrVerify integerValue] == 0;
            [cell.contentView addSubview:titleTextField];

            UIView *nameLineView = [[UIView alloc] initWithFrame:CGRectMake(10, 64.5, Width - 40.0f, 1.0f)];
            nameLineView.backgroundColor = COLOR2(241);
            [cell.contentView addSubview:nameLineView];
          
            [UILabel initWithDFLable:CGRectMake(15,70, 50, 15) :[UIFont systemFontOfSize:11] :COLOR2(102) :@"身份证号" :cell.contentView :0];
            [UILabel initWithDFLable:CGRectMake(60,72.5,12, 12) :[UIFont systemFontOfSize:11] :COLOR(245,12,12) :@"*" :cell.contentView :0];
            
            UITextField *idCardTextField = [[UITextField alloc] init];
            idCardTextField.font = [UIFont systemFontOfSize:11];
            idCardTextField.textColor = COLOR2(51);
            idCardTextField.text = [self.cyrVerify integerValue] == 0 ? self.dic[@"num"] : self.info[@"idcard"];
            idCardTextField.frame = CGRectMake(Width - 245,70,215, 20);
            idCardTextField.textAlignment = NSTextAlignmentRight;
            idCardTextField.delegate = self;
            idCardTextField.tag = 2;
            idCardTextField.returnKeyType = UIReturnKeyDone;
            idCardTextField.userInteractionEnabled = [self.cyrVerify integerValue] == 0;
            [cell.contentView addSubview:idCardTextField];
            
            UIView *numLineView = [[UIView alloc] initWithFrame:CGRectMake(10, 94.5, Width - 40.0f, 1.0f)];
            numLineView.backgroundColor = COLOR2(241);
            [cell.contentView addSubview:numLineView];
            
            if (UserModel.shareInstance.type == 2) {
                [UILabel initWithDFLable:CGRectMake(15,100, 70, 15) :[UIFont systemFontOfSize:11] :COLOR2(102) :@"身份证有效期" :cell.contentView :0];
                UIImageView *accessImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrowIndicator_icon"]];
                accessImageView.frame = CGRectMake(Width - 40, 105, 10, 10);
                [cell.contentView addSubview:accessImageView];

                UITextField *endDateTextField = [[UITextField alloc] init];
                endDateTextField.font = [UIFont systemFontOfSize:11];
                endDateTextField.textColor = COLOR2(51);
                endDateTextField.text = [self.cyrVerify integerValue] == 0 ? self.dic[@"endDate"] : self.info[@"idcardValid"];
                endDateTextField.frame = CGRectMake(Width - 215,100,170, 20);
                endDateTextField.textAlignment = NSTextAlignmentRight;
                endDateTextField.delegate = self;
                endDateTextField.tag = 3;
                endDateTextField.userInteractionEnabled = [self.cyrVerify integerValue] == 0;
                [cell.contentView addSubview:endDateTextField];
                
                UIView *dateLineView = [[UIView alloc] initWithFrame:CGRectMake(10, 124.5, Width - 40.0f, 1.0f)];
                dateLineView.backgroundColor = COLOR2(241);
                [cell.contentView addSubview:dateLineView];
            }
            
            return cell;
        }
    }
}

- (BRDatePickerView *)pickerView{
    if (_pickerView == nil) {
        _pickerView = [[BRDatePickerView alloc]init];
        // 2.设置属性
        _pickerView.pickerMode = BRDatePickerModeYMD;
        _pickerView.title = @"身份证有效期";
        _pickerView.selectDate = [NSDate br_setYear:2019 month:10 day:30];
        _pickerView.minDate = [NSDate br_setYear:1900 month:1 day:1];
        NSDate *now = [NSDate date];
       NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
        NSInteger year = [dateComponent year];
        
        NSString *date = [NSString stringWithFormat:@"%ld-12-31",year+100];
        NSDateFormatter *dateFor = [[NSDateFormatter alloc] init];
        [dateFor setDateFormat:@"yyyy-MM-dd"];
        NSDate *maxDate = [dateFor dateFromString:date];
        dateFor = nil;
        _pickerView.maxDate = maxDate;
        _pickerView.isAutoSelect = YES;
        WeakSelf
        _pickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
            NSLog(@"选择的值：%@", selectValue);
            if (selectValue) {
                [weakSelf.dic setValue:selectValue forKey:@"endDate"];
            }
            [weakSelf.table reloadData];
        };
        // 设置自定义样式
        BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
        customStyle.pickerColor = BR_RGB_HEX(0xd9dbdf, 1.0f);
        customStyle.pickerTextColor = [UIColor redColor];
        customStyle.separatorColor = [UIColor redColor];
        _pickerView.pickerStyle = customStyle;
    }
    return _pickerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *vc = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 10)];
    vc.backgroundColor = COLOR2(240);
    return vc;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    if (section == 0) {
         if (self.img2 != nil && self.img1 != nil) {
             return 0;
             
         }else{
             
             return 10;
         }
    }else{
        
        return 0;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        if (self.img2 != nil && self.img1 != nil) {
            return 200.0f;
        }else
            return 270.0f;
        
    }else if (indexPath.section == 1){
         
        if (self.img2 != nil && self.img1 != nil) {

            return tableView.frame.size.height - 210.0f;
        }else{
            return 190.0f;
        }
        
    }else{
        return 0;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 3) {
        if (self.dic[@"endDate"]) {
            NSString *dateStr = self.dic[@"endDate"];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [formatter dateFromString:dateStr];
            self.pickerView.selectDate = date;
        }
        [self.pickerView show];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1) {
        [self.dic setValue:textField.text forKey:@"name"];
    }else if (textField.tag == 2){
        [self.dic setValue:textField.text forKey:@"num"];
    }
    [textField resignFirstResponder];
    return YES;
}

-(void)setfwb:(UILabel *)las{
    
    NSString *str = las.text;
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    //给富文本添加属性1-字体大小
//        [attributedStr addAttribute:NSFontAttributeName
//                              value:[UIFont systemFontOfSize:14*Width1]
//                              range:NSMakeRange(0, 3)];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:COLOR2(119)
                          range:NSMakeRange(0, 8)];
    
    
    las.attributedText = attributedStr;
//    las.textAlignment = YES;
    
}

-(void)zAction{
    
    self.code = @"1";
     [self onTapGR];
}

-(void)fAction{
    
    self.code = @"2";
    [self onTapGR];
    
}

- (void)deleteImageAction:(UIButton *)sender{
    if (sender.tag == 1) {
        //正面删除
        self.img1 = nil;
    }else{
        self.img2 = nil;
    }
    [self.table reloadData];
}


#pragma make  avdelegate--
///选择相册
- (void)onTapGR
{
    // 选择控制器
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    actionsheet.tag = 1000;
    [actionsheet showInView:[AFN_DF topViewController].view];
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
            UIViewController *vc = self.viewController ? self.viewController : self;
            [vc presentViewController:picker animated:YES completion:nil];
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
        UIViewController *vc = self.viewController ? self.viewController : self;

        [vc presentViewController:picker animated:YES completion:nil];
    }
}
#pragma mark - 相册delegate
//协议中的方法，当用户选择某个图片时被调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
      [picker dismissViewControllerAnimated:YES completion:nil];
    ///可编辑为 UIImagePickerControllerEditedImage

    if ([self.code isEqualToString:@"1"]) {
        
        self.img1 = image;
    }else{
        
        self.img2 = image;
    }
    
    if (self.img2 != nil && self.img1 != nil) {
        
        [self postinfos];
    }
    [self.table reloadData];
  
}
//协议中的方法，当用户取消时被调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)postinfos{
    
//    [LSProgressHUD showToView:self.view message:@"正在加载"];
    
    WeakSelf
    [AFN_DF POST:UserModel.shareInstance.type == 1 ? @"/system/account/OCRIdCard" : @"/system/auth/OCRIdCard" Parameters:nil File:@[@"idcardBack",@"idcardFront"] ImageArr:@[self.img2,self.img1] ContVC:self success:^(NSDictionary *responseObject) {
        
        self.dic = responseObject[@"data"];
        self.livingBodyAuth = [NSString stringWithFormat:@"%@",self.dic[@"livingBodyAuth"]];
               
               [self.table reloadData];
                self->suppBut.userInteractionEnabled = YES;
               self->suppBut.backgroundColor = [UIColor redColor];
               [self->suppBut setTitleColor:[UIColor whiteColor] forState:0];
        if (weakSelf.submitSourceInfoBlock) {
            weakSelf.submitSourceInfoBlock(weakSelf.dic);
        }
    } failure:^(NSError *error) {
        if (weakSelf.submitSourceInfoBlock) {
            weakSelf.submitSourceInfoBlock(nil);
        }
    }];
    
}


-(void)getUserInfo{
    WeakSelf
    [AFN_DF POST:@"/system/account/getUserInfo" Parameters:nil success:^(NSDictionary *responseObject) {
        
        [[UserModel shareInstance]setValuesForKeysWithDictionary:responseObject[@"data"]];
        NSDictionary *dic = responseObject[@"data"];
        id info = [PNSBuildModelUtils deleteEmpty:dic];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:info forKey:@"user"];
        [user synchronize];
        [weakSelf.navigationController popViewControllerAnimated:YES];
        if (UserModel.shareInstance.hasBankCard == nil || UserModel.shareInstance.hasBankCard.integerValue == 0) {
            CardInfoVC *cardVC = [[CardInfoVC alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
            cardVC.tag = 1;
            [UIApplication.sharedApplication.keyWindow addSubview:cardVC];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark LiveDetectControllerDelegate

- (void)onFailed:(int)code withMessage:(NSString *)message{
    if (code != IV_ERROR_BREAK) {
        ResultViewController *resultVc = [[ResultViewController alloc]init];
        resultVc.errorCode = code;
        resultVc.errorMessage = message;
        [self.navigationController pushViewController:resultVc animated:YES];
    }else{
        [self.view addSubview:[Toast makeText:message]];
    }
}

- (void)onFinishWithSign:(NSString *)imageSign{
    NSDictionary *dic = @{
        
        @"name":self.dic[@"name"],
        @"num":self.dic[@"num"],
        @"phone":[UserModel shareInstance].username,
        @"packageName":@"com.df.JSKCProjectD",
        @"signData":imageSign,
    };
    
    [AFN_DF POST:@"/system/account/auth" Parameters:dic File:@[@"idcardBack",@"idcardFront"] ImageArr:@[self.img2,self.img1] ContVC:self success:^(NSDictionary *responseObject) {
        
        [self getUserInfo];

    } failure:^(NSError *error) {
        
    }];
}

//随机数组
- (NSMutableArray *)randomArray:(NSArray *)array withRandomNum:(NSInteger)num {
    
    NSMutableArray *startArray = [[NSMutableArray alloc] initWithArray:array];
    //随机数产生结果
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:0];
    //随机数个数
    for (int i = 0; i < num; i++) {
        int t = arc4random() % startArray.count;
        resultArray[i] = startArray[t];
        startArray[t] = [startArray lastObject]; //为更好的乱序，故交换下位置
        [startArray removeLastObject];
    }
    return resultArray;
}
- (void)startLive{
    [self beginDetect:NO];
}

- (void)beginDetect:(BOOL)isCameraBack{
    NSMutableArray *temp = [self randomArray:@[@2, @3, @4, @5] withRandomNum:2];
    [temp addObject:@1];
    LiveDetectController *liveVc = [[LiveDetectController alloc]init];
    liveVc.actionList = [temp copy];
    liveVc.delegate = self;
    liveVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:liveVc animated:YES completion:nil];
    
}

@end

