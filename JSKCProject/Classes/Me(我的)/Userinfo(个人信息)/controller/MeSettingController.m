//
//  MeSettingController.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/9.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "MeSettingController.h"
#import "CancellationController.h"
#import "UpPhoneController.h"
#import "PhoneLoginController.h"
#import "TestViewController.h"
#import "AboutController.h"
#import "loginController.h"

@interface MeSettingController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)UIImageView *topimg;
@end

@implementation MeSettingController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = YES;
   

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"设置";
    self.view.backgroundColor = COLOR2(240);
    [self setUI];
}

-(void)setUI{
    
    
    self.dataArray = @[@"更换头像",@"账号注销",@"修改手机号",@"清除缓存",@"关于我们"];
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, NavaBarHeight + 10, Width, 270) style:(UITableViewStylePlain)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor = COLOR2(240);
//    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    self.table.scrollEnabled = NO;
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    
    
    UIButton *outBut = [UIButton initWithFrame:CGRectMake(10, NavaBarHeight + 290, Width - 20, 50) :@"退出当前账号" :15*Width1];
    [outBut addTarget:self action:@selector(outAction) forControlEvents:(UIControlEventTouchUpInside)];
    [outBut setTitleColor:[UIColor redColor] forState:0];
    outBut.layer.cornerRadius = 4;
    outBut.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:outBut];
    
}



-(void)outAction{
    
    
                [[UserModel shareInstance] setValuesForKeysWithDictionary:@{}];
      
                [UserModel shareInstance].accessToken = nil;
                   NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                   [user setObject:@{} forKey:@"user"];
    PhoneLoginController *logVC =  [PhoneLoginController new];
    [self.navigationController pushViewController:logVC animated:YES];
//    if ([TXCommonUtils simSupportedIsOK] && [TXCommonUtils checkDeviceCellularDataEnable]) {
//        LoginController *logVC =  [LoginController new];
//        [self.navigationController pushViewController:logVC animated:YES];
//    }else{
//        PhoneLoginController *logVC =  [PhoneLoginController new];
//        [self.navigationController pushViewController:logVC animated:YES];
//    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14*Width1];
    cell.textLabel.textColor = COLOR2(51);
    cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row == 0) {
        
        self.topimg = [[UIImageView alloc]initWithFrame:CGRectMake(Width - 90, 10, 50, 50)];
        self.topimg.backgroundColor = [UIColor whiteColor];
        self.topimg.layer.cornerRadius =25;
        self.topimg.layer.masksToBounds = YES;
        [cell.contentView addSubview:self.topimg];
        [self.topimg sd_setImageWithURL:[NSURL URLWithString:[UserModel shareInstance].headurl] placeholderImage:[UIImage imageNamed:@"默认头像"]];
      

    }
    
    
    if (indexPath.row == 3) {
        
       CGFloat size = [self totalSize];
        
        [UILabel initWithDFLable:CGRectMake(Width - 105, 10, 70, 30) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :[NSString stringWithFormat:@"%.1fM",size] :cell.contentView :2];
        
    }
    
    if (indexPath.row == 4) {
           
       
           
           [UILabel initWithDFLable:CGRectMake(Width - 105, 10, 70, 30) :[UIFont systemFontOfSize:14*Width1] :COLOR2(51) :@"v2.2.0" :cell.contentView :2];
           
       }
    

    
    return cell;
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        return 70;
    }else{
        return 50;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0){
        
        
        [self onTapGR];
        
    }else if (indexPath.row == 1){
        CancellationController *canVC = [CancellationController new];
          [self.navigationController pushViewController:canVC animated:YES];
    }else if (indexPath.row == 2){
        
        UpPhoneController *upVC = [UpPhoneController new];
        [self.navigationController pushViewController:upVC animated:YES];
        
    }else if(indexPath.row == 3){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清除缓存" message:@"您确定要清除缓存吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
      
         
         [UIView appearance].tintColor= [UIColor blackColor];
                   [alert show];
        
        
        
    }else{
        
        AboutController *abtVC = [AboutController new];
        [self.navigationController pushViewController:abtVC animated:YES];
        
        
//        [AFN_DF POST:@"/system/lawandnotice/getDocument" Parameters:@{@"id":@"0"} success:^(NSDictionary *responseObject) {
//            WKController *wkvc = [WKController new];
//            wkvc.urls = responseObject[@"documentUrl"];
//            wkvc.title = @"关于我们";
//            [self.navigationController pushViewController:wkvc animated:YES];
//
//        } failure:^(NSError *error) {
//
//        }];
//
        
    
        
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    // 获取您按下的是哪个按钮

   
    
    if (buttonIndex == 0) {
        //
        
        [self clanSize];
    }
      
    

}



-(CGFloat )totalSize{
    
    //计算结果
       int totalSize = 0;
       
       // 构建需要计算大小的文件或文件夹的路径，这里以Documents为例
       NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
       
       // 1.获得文件夹管理者
       NSFileManager *mgr = [NSFileManager defaultManager];
       
       // 2.检测路径的合理性
       BOOL dir = NO;
       BOOL exits = [mgr fileExistsAtPath:path isDirectory:&dir];
       if (!exits) return 0;
       
       // 3.判断是否为文件夹
       if (dir)//文件夹, 遍历文件夹里面的所有文件
       {
           //这个方法能获得这个文件夹下面的所有子路径(直接\间接子路径),包括子文件夹下面的所有文件及文件夹
           NSArray *subPaths = [mgr subpathsAtPath:path];
           
           //遍历所有子路径
           for (NSString *subPath in subPaths)
           {
               //拼成全路径
               NSString *fullSubPath = [path stringByAppendingPathComponent:subPath];
               
               BOOL dir = NO;
               [mgr fileExistsAtPath:fullSubPath isDirectory:&dir];
               if (!dir)//子路径是个文件
               {
                   //如果是数据库文件，不加入计算
                   if ([subPath isEqualToString:@"mySql.sqlite"])
                   {
                       continue;
                   }
                   NSDictionary *attrs = [mgr attributesOfItemAtPath:fullSubPath error:nil];
                   totalSize += [attrs[NSFileSize] intValue];
               }
           }
           totalSize = totalSize / (1024 * 1024.0);//单位M
       }
       else//文件
       {
           NSDictionary *attrs = [mgr attributesOfItemAtPath:path error:nil];
           totalSize = [attrs[NSFileSize] intValue] / (1024 * 1024.0);//单位M
       }
    
    
    return  totalSize;
    }


//清

-(void)clanSize{
    
    NSString *message = nil;//提示文字
       BOOL clearSuccess = YES;//是否删除成功
       NSError *error = nil;//错误信息
       
       //构建需要删除的文件或文件夹的路径，这里以Documents为例
       NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
       
       //拿到path路径的下一级目录的子文件夹
       NSArray *subPathArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
       
       for (NSString *subPath in subPathArray)
       {
           //如果是数据库文件，不做操作
           if ([subPath isEqualToString:@"mySql.sqlite"])
           {
               continue;
           }
           
           NSString *filePath = [path stringByAppendingPathComponent:subPath];
           //删除子文件夹
           [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
           if (error)
           {
               message = [NSString stringWithFormat:@"%@这个路径的文件夹删除失败了",filePath];
               clearSuccess = NO;
               
           }
           else
           {
                [self.view addSubview:[Toast makeText:@"清除成功"]];
            
           }
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

    [self postImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//协议中的方法，当用户取消时被调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)postImage:(UIImage *)img{
    
    
    [AFN_DF POST:@"/system/account/changeHead" Parameters:nil File:@[@"headFile"] ImageArr:@[img] ContVC:self success:^(NSDictionary *responseObject) {
        
        
        NSLog(@"%@",responseObject);
        self.topimg.image = img;
        [self getUserInfo];
        
    } failure:^(NSError *error) {
        
    }];
    
}


-(void)getUserInfo{
    
    
    [AFN_DF POST:@"/system/account/getUserInfo" Parameters:nil success:^(NSDictionary *responseObject) {
        
        [[UserModel shareInstance]setValuesForKeysWithDictionary:responseObject[@"data"]];
             
                NSDictionary *dic = responseObject[@"data"];
            id info = [PNSBuildModelUtils deleteEmpty:dic];

                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:info forKey:@"user"];
      
              
        
    } failure:^(NSError *error) {
        
    }];
    
    
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
