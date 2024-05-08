//
//  AddBandCarController.m
//  JSKCProject
//
//  Created by 孟德峰 on 2020/12/28.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "AddBandCarController.h"
#import "AddBandCell.h"
#import "UpPhoneController.h"
#import "UIButton+ExtendedMethods.h"
#import "InfoSubmitSuccessViewController.h"

@interface AddBandCarController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>

@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSArray *titArray;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)UIImage *img;
@property(nonatomic,strong)UIButton *codeButton;
@property(nonatomic,strong)UITableView *jstable;
@property(nonatomic,strong)NSArray *jsarray;
@property(nonatomic,strong)NSDictionary *bankdata;

@end

@implementation AddBandCarController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"绑定银行卡";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    
}

-(void)setUI{
    
    self.titArray = @[@"持卡人",@"身份证",@"银行卡号",@"开户银行",@"手机号码",@"短信验证",];
    
    _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[AddBandCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.table];
    self.table.backgroundColor = COLOR2(240);
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.tableFooterView = ({
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 150)];
        UIButton *suppBut = [UIButton initWithFrame:CGRectMake(20, 40, Width - 40, 40) :@"确认绑卡" :16];
        suppBut.backgroundColor = [UIColor redColor];
        suppBut.layer.cornerRadius = 4;
        suppBut.layer.masksToBounds = YES;
        [suppBut addTarget:self action:@selector(suppAction) forControlEvents:(UIControlEventTouchUpInside)];
        [footerView addSubview:suppBut];
        
        UIButton *updataBut = [UIButton initWithFrame:CGRectMake(20, 90, Width - 40, 30) :@"更换手机号？" :14];
        [updataBut setTitleColor:[UIColor redColor] forState:0];
        updataBut.layer.cornerRadius = 4;
        updataBut.layer.masksToBounds = YES;
        [updataBut addTarget:self action:@selector(undataAction) forControlEvents:(UIControlEventTouchUpInside)];
        [footerView addSubview:updataBut];
        
        footerView;
    });
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0.0f);
        make.top.mas_equalTo(NavaBarHeight);
        make.bottom.mas_equalTo(-UISafeAreaBottomHeight);
    }];
    
    self.jstable = [[UITableView alloc]initWithFrame:CGRectMake(0, 322, Width, 260) style:(UITableViewStylePlain)];
    self.jstable.tag = 1001;
    self.jstable.delegate = self;
    self.jstable.dataSource = self;
    self.jstable.hidden = YES;
    [self.view addSubview:self.jstable];
    [self.jstable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    
    
    
}

-(void)suppAction{
    [self.codeButton stopCountDownTime];
    NSMutableArray *userArr = [NSMutableArray array];
    NSMutableArray *bandArr = [NSMutableArray array];
    for (int i = 0 ; i < 2; i++) {
        
        AddBandCell *cell = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if ([cell.textTF.text isEqualToString:@""]) {
            
            return [self.view addSubview:[Toast makeText:[NSString stringWithFormat:@"请输入%@",cell.textTF.placeholder]]];
        }else{
            [userArr addObject:cell.textTF.text];
        }
    }
    
    for (int i = 0 ; i < 4; i++) {
        
        AddBandCell *cell = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:1]];
        if ([cell.textTF.text isEqualToString:@""]) {
            
            return [self.view addSubview:[Toast makeText:[NSString stringWithFormat:@"请输入%@",cell.textTF.placeholder]]];
        }else{
            
            [bandArr addObject:cell.textTF.text];
            
        }
        
    }
    ///上面检测一二分区是否有空值
    
    NSDictionary *dic = @{
        @"name":userArr[0],
        @"idCard":userArr[1],
        @"bankCardNum":bandArr[0],
        @"bank":bandArr[1],
        @"phone":bandArr[2],
        @"code":bandArr[3],
        @"bankNum":[NSString stringWithFormat:@"%@",self.bankdata[@"bankNum"]]
    };
    
    WeakSelf
    [AFN_DF POST:@"/system/wallet/bind" Parameters:dic success:^(NSDictionary *responseObject) {
        [weakSelf.view addSubview:[Toast makeText:@"银行卡绑定成功"]];
        [weakSelf getUserInfo];
        
    } failure:^(NSError *error) {
            
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
        if (UserModel.shareInstance.type == 2) {
            if(UserModel.shareInstance.bandTruckId == nil || [UserModel.shareInstance.bandTruckId integerValue] == 0){
                VehicleInfoVC *vc =  [[VehicleInfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                vc.tag = 1;
                [UIApplication.sharedApplication.keyWindow addSubview:vc];
            }
        }
  
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if(tableView.tag != 1001){
        return 2;
    }else{
        return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView.tag != 1001){
        if (section == 0) {
            return 2;
        }else{
            return 4;
        }
    }else{
        return self.jsarray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView.tag != 1001){
        AddBandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0) {
            cell.tit = self.titArray[indexPath.row];

        }else{
            cell.tit = self.titArray[indexPath.row + 2];
        }
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                cell.textTF.userInteractionEnabled = NO;
                cell.textTF.text = [UserModel shareInstance].name;
                cell.textTF.placeholder = @"请输入姓名";
            }else{
                
                cell.textTF.userInteractionEnabled = NO;
                cell.textTF.text = [UserModel shareInstance].idcard;
                cell.textTF.placeholder = @"请输入身份号码";
            }
            
        }else{
            cell.textTF.userInteractionEnabled = YES;
            NSLog(@"%ld",indexPath.row);
            switch (indexPath.row) {
                case 0:
                {
                    cell.textTF.userInteractionEnabled = YES;
                    cell.textTF.placeholder = @"请输入银行卡卡号";
                    cell.textTF.keyboardType = UIKeyboardTypeNumberPad;
                    UIButton *bandBut = [UIButton initWithFrame:CGRectMake(Width - 40,10, 20, 20) :@"相机s1"];
                    [bandBut addTarget:self action:@selector(bandAction) forControlEvents:(UIControlEventTouchUpInside)];
                    [cell.contentView addSubview:bandBut];
                    
                }
                    break;
                    case 1:
                {
                    cell.textTF.userInteractionEnabled = YES;
                    cell.textTF.placeholder = @"请输入开户银行名称";
//                    cell.textTF.delegate = self;
                    [cell.textTF addTarget:self action:@selector(textFieldDidChange:)forControlEvents:UIControlEventEditingChanged];
                }
                    break;
                    case 2:
                {
                    cell.textTF.userInteractionEnabled = NO;
                    cell.textTF.text = [UserModel shareInstance].username;
                }
                    break;
                    default:
                {
                    cell.textTF.userInteractionEnabled = YES;
                    cell.textTF.placeholder = @"请输入验证码";
                    cell.textTF.keyboardType = UIKeyboardTypeNumberPad;
                    if (self.codeButton == nil) {
                        _codeButton = [UIButton initWithFrame:CGRectMake(Width - 120,10, 100, 20) :@"获取验证码":14*Width1];
                        _codeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                        [_codeButton setTitleColor:[UIColor redColor] forState:0];
                        [_codeButton addTarget:self action:@selector(codeButAction) forControlEvents:(UIControlEventTouchUpInside)];
                    }
                    [cell.contentView addSubview:self.codeButton];
                }
                    break;
            }
     
        }
        
        return cell;
    }else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        cell.textLabel.text = self.jsarray[indexPath.row][@"bankSubName"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 41;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView.tag != 1001){
        return 50;
    }else{
        return 0.0001;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(tableView.tag != 1001){
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 10, Width, 50)];
        back.backgroundColor = COLOR2(230);
        
        if (section == 0) {
            [UILabel initWithDFLable:CGRectMake(20, 0, 200, 50) :[UIFont systemFontOfSize:12*Width1] :[UIColor blackColor] :@"请核对您的身份证信息" :back :0];
        }else{
            [UILabel initWithDFLable:CGRectMake(20, 0, 200, 50) :[UIFont systemFontOfSize:12*Width1] :[UIColor blackColor] :@"请输入您的银行卡信息" :back :0];
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(Width - 130, 20, 10, 10)];
            img.image = [UIImage imageNamed:@"oLSfxoBS"];
            [back addSubview:img];
            
            [UILabel initWithDFLable:CGRectMake(Width - 125, 0, 110, 50) :[UIFont systemFontOfSize:12*Width1] :COLOR(255, 138, 0) :@"请绑定本人银行卡" :back :2];
            
        }
        
        
        return back;
    }else{
        return nil;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(void)codeButAction{
    
    AddBandCell *cell = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
   WeakSelf
    [AFN_DF POST:@"/system/wallet/sendsms" Parameters:@{@"phone":cell.textTF.text} success:^(NSDictionary *responseObject) {
        [weakSelf.codeButton startCountDownTime:60 withCountDownBlock:nil];
//        [self.view addSubview:[Toast makeText:@"发送验证码成功"]];
        
    } failure:^(NSError *error) {
        
    }];

}

-(void)bandAction{
    
    [self onTapGR];
    
}

///认证
-(void)postImageAction{
    
    
    [AFN_DF POST:@"/system/wallet/OCRBankcard" Parameters:nil File:@[@"bankcardFront"] ImageArr:@[self.img] ContVC:self success:^(NSDictionary *responseObject) {
        
        AddBandCell *cell = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        cell.textTF.text = responseObject[@"data"][@"bankCardNum"];
       
        NSString *bank = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"bank"]];
        if (![bank isEqualToString:@""] || ![bank isEqualToString:@"(null)"]) {
            AddBandCell *cell1 = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
            cell1.textTF.text = bank;
        }

    } failure:^(NSError *error) {
        
    }];
    
    
}

-(void)undataAction{
    
    
    [self.navigationController pushViewController:[UpPhoneController new] animated:YES];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView.tag != 1001){
         
    }else{
        self.bankdata = self.jsarray[indexPath.row];
        self.jstable.hidden = YES;
        AddBandCell *cell = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
        cell.textTF.text = self.bankdata[@"bankSubName"];
    }
    
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
            [self presentViewController:picker animated:YES completion:nil];
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
        [self presentViewController:picker animated:YES completion:nil];
    }
}
#pragma mark - 相册delegate
//协议中的方法，当用户选择某个图片时被调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    ///可编辑为 UIImagePickerControllerEditedImage
    
    self.img = image;
    ///认证
//    dispatch_async(dispatch_queue_create("sdsadsadsa", NULL), ^{
       
        
        [self postImageAction];
        
//    });
  
    [picker dismissViewControllerAnimated:YES completion:nil];
   
    
}
//协议中的方法，当用户取消时被调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc{
    [self.codeButton stopCountDownTime];
}

////kaishi
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    NSLog(@"%@",@"sssssss");
//
//}
////jieshu
//-(void)textFieldDidEndEditing:(UITextField *)textField{
//    if(textField.text.length >= 2){
//        self.jstable.hidden = NO;
//        [self loaddatas:textField.text];
//    }else{
//        self.jstable.hidden = YES;
//    }
//
//}
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//
//    if(textField.text.length >= 3){
//
//    }
//
//    NSLog(@"%@",textField.text);
//    return YES;
//}


#pragma mark -----输入手机号位数的监听
-(void)textFieldDidChange:(id)sender{
    UITextField *phoneTF = (UITextField *)sender;
    if (phoneTF.markedTextRange == nil) {
        if (phoneTF.text.length >= 2) {
    //        [phoneTF resignFirstResponder];
            self.jstable.hidden = NO;
            [self loaddatas:phoneTF.text];
        }else{
            self.jstable.hidden = YES;
        }
    }
   



}


-(void)loaddatas:(NSString *)bankName{
    
    WeakSelf
     [AFN_DF POST:@"/system/wallet/openBank" Parameters:@{@"bankName":bankName} success:^(NSDictionary *responseObject) {
         NSLog(@"%@",@"-------------------------------");
         self.jsarray = responseObject[@"data"];
         [self.jstable reloadData];
     } failure:^(NSError *error) {
         
     }];
    
}




@end

