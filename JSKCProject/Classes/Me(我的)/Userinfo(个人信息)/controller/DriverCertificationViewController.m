//
//  DriverCertificationViewController.m
//  JSKCProject
//
//  Created by 王宾 on 2022/3/28.
//  Copyright © 2022 孟德峰. All rights reserved.
//

#import "DriverCertificationViewController.h"
#import "InfoAuthViewController.h"

@interface DriverCertificationViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    UIButton *frontDriverButton;
    UIButton *backDriverMainButton;
    UIButton *backDriverButton;
    UIButton *qualificationMainButton;
    UIButton *qualificationButton;
    
    UIButton *suppBut;
}

@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)UILabel *statusLabel;
@end

@implementation DriverCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = YES;
}

-(void)setUI{
    
    [self.view addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.top.mas_equalTo(0.0f);
        make.height.mas_equalTo(30.0f);
    }];
    _table = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.showsVerticalScrollIndicator = NO;
    self.table.backgroundColor = COLOR2(240);
    self.table.layer.cornerRadius = 4;
    self.table.layer.masksToBounds = YES;
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell3"];

    self.table.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([self.cyrVerify integerValue] >= 2 || [self.cyrVerify integerValue] <= 5) {
            make.top.mas_equalTo(40.0f);
        }else
            make.top.mas_equalTo(10.0f);
        make.bottom.mas_equalTo(-10.0f);
        make.left.mas_equalTo(10.0f);
        make.right.mas_equalTo(-10.0f);
    }];
//
//    UIView *tabvc = [[UIView alloc]initWithFrame:CGRectMake(0, Height - 60 - ScreenBottom, Width,60)];
//    tabvc.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:tabvc];
//
//   suppBut =  [UIButton initWithFrame:CGRectMake(20, 10, Width - 40, 40) :@"提交审核" :16*Width1];
//    suppBut.backgroundColor = COLOR2(238);
//    suppBut.layer.cornerRadius = 4;
//    [suppBut setTitleColor:COLOR2(153) forState:0];
//    suppBut.userInteractionEnabled = NO;
//    [suppBut addTarget:self action:@selector(suppAction) forControlEvents:(UIControlEventTouchUpInside)];
//    [tabvc addSubview:suppBut];
}

- (UILabel *)statusLabel{
    if (_statusLabel == nil) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = [UIFont systemFontOfSize:10.0f];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.hidden = YES;
    }
    return _statusLabel;
}

- (void)setInfo:(id)info{
    _info = info;
    [self.table reloadData];
}

- (void)setCyrVerify:(NSString *)cyrVerify{
    _cyrVerify = cyrVerify;
    switch ([_cyrVerify integerValue]) {
        case 0:
        case 1:
        {
            self.statusLabel.hidden = YES;
            [self.table mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(10.0f);
            }];
        }
            break;
        case 2:
        case 4:
        case 3:{
            self.statusLabel.hidden = NO;
            self.statusLabel.text = @"审核失败：请更新资料重新提交认证";
            self.statusLabel.textColor = COLOR(245, 12, 12);
            self.statusLabel.backgroundColor = COLOR(255, 235, 235);
            [self.table mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(40.0f);
            }];
        }
            break;
        case 5:
        {
            self.statusLabel.hidden = NO;
            self.statusLabel.backgroundColor = COLOR(255, 236, 211);
            self.statusLabel.textColor = COLOR(204, 124, 19);
            self.statusLabel.text = @"身份审核中，请耐心等待";
            [self.table mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(40.0f);
            }];
        }
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        CGRect bounds = CGRectMake(0, 0, Width-20 , 315.0f);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(4, 4)];
        layer.frame = bounds;
        layer.path = maskPath.CGPath;
        cell.layer.mask = layer;
        
        [UILabel initWithDFLable:CGRectMake(10, 17, 85, 13) :[UIFont systemFontOfSize:13] :COLOR2(51) :@"驾驶证信息" :cell.contentView :0];
        
        
        UIImageView *frontDiverImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15.0f,50, 145,90.0f)];
        frontDiverImageView.contentMode = UIViewContentModeScaleAspectFill;
        frontDiverImageView.layer.masksToBounds = YES;
        frontDiverImageView.image = [UIImage imageNamed:@"驾驶证正_new"];
        [cell.contentView addSubview:frontDiverImageView];
        [UILabel initWithDFLable:CGRectMake((CGRectGetWidth(frontDiverImageView.frame) - 145)*0.5+frontDiverImageView.frame.origin.x, 150, 145, 20) :[UIFont systemFontOfSize:10] :COLOR2(68) :@"点击拍摄/上传驾驶证主页" :cell.contentView :1];
        
        frontDriverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        frontDriverButton.frame = frontDiverImageView.frame;
        [frontDriverButton addTarget:self action:@selector(selectedImageFunction:) forControlEvents:(UIControlEventTouchUpInside)];
        frontDriverButton.contentMode = UIViewContentModeScaleAspectFill;
        frontDriverButton.layer.masksToBounds = YES;
        frontDriverButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        frontDriverButton.imageView.layer.masksToBounds = YES;
        frontDriverButton.tag = 1;
        if ([self.cyrVerify integerValue] == 0) {
            [frontDriverButton setImage:self.frontDriverImage forState:UIControlStateNormal];
        }else{
            frontDriverButton.userInteractionEnabled = NO;
            [frontDriverButton sd_setImageWithURL:[NSURL URLWithString:self.info[@"iddriveFront"]] forState:UIControlStateNormal];
        }

        [cell.contentView addSubview:frontDriverButton];

        if ([self.cyrVerify integerValue] == 0) {
            UIButton *frontDiverDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [frontDiverDeleteButton setImage:[UIImage imageNamed:@"delete_small"] forState:UIControlStateNormal];
            frontDiverDeleteButton.frame = CGRectMake(CGRectGetMaxX(frontDiverImageView.frame) - 10.0f, frontDiverImageView.frame.origin.y - 10.0f, 20, 20);
            frontDiverDeleteButton.tag = 1;
            frontDiverDeleteButton.hidden = self.frontDriverImage == nil;
            [frontDiverDeleteButton addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:frontDiverDeleteButton];
        }
             
        UIImageView *backDiverMainImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Width - 180.0f,50.0f, 145,90)];
        backDiverMainImageView.image = [UIImage imageNamed:@"驾驶证反_new"];
        backDiverMainImageView.contentMode = UIViewContentModeScaleAspectFill;
        backDiverMainImageView.layer.masksToBounds = YES;
        [cell.contentView addSubview:backDiverMainImageView];
        [UILabel initWithDFLable:CGRectMake((CGRectGetWidth(backDiverMainImageView.frame) - 145)*0.5+backDiverMainImageView.frame.origin.x, 150, 145, 20) :[UIFont systemFontOfSize:10] :COLOR2(68) :@"点击拍摄/上传驾驶证副页" :cell.contentView :1];

        backDriverMainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backDriverMainButton.frame = backDiverMainImageView.frame;
        [backDriverMainButton addTarget:self action:@selector(selectedImageFunction:) forControlEvents:(UIControlEventTouchUpInside)];
        backDriverMainButton.contentMode = UIViewContentModeScaleAspectFill;
        backDriverMainButton.layer.masksToBounds = YES;
        backDriverMainButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        backDriverMainButton.imageView.layer.masksToBounds = YES;
        backDriverMainButton.tag = 2;
        if ([self.cyrVerify integerValue] == 0) {
            [backDriverMainButton setImage:self.backDriverMainImage forState:UIControlStateNormal];
        }else{
            backDriverMainButton.userInteractionEnabled = NO;
            [backDriverMainButton sd_setImageWithURL:[NSURL URLWithString:self.info[@"iddriveBack"]] forState:UIControlStateNormal];
        }
        [cell.contentView addSubview:backDriverMainButton];
        
        if ([self.cyrVerify integerValue] == 0) {
            UIButton *backDiverDeleteMainButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [backDiverDeleteMainButton setImage:[UIImage imageNamed:@"delete_small"] forState:UIControlStateNormal];
            backDiverDeleteMainButton.frame = CGRectMake(CGRectGetMaxX(backDiverMainImageView.frame) - 10.0f, backDiverMainImageView.frame.origin.y - 10.0f, 20, 20);
            backDiverDeleteMainButton.tag = 2;
            [backDiverDeleteMainButton addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
            backDiverDeleteMainButton.hidden = self.backDriverMainImage == nil;
            [cell.contentView addSubview:backDiverDeleteMainButton];
        }
        
        if ([self.cyrVerify integerValue] == 0 || (self.info[@"iddriveBackBack"] && [self.info[@"iddriveBackBack"] length] != 0)) {
            UIImageView *backDiverImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15.0f,185.0f, 145,90)];
            backDiverImageView.image = [UIImage imageNamed:@"驾驶证反_new"];
            backDiverImageView.contentMode = UIViewContentModeScaleAspectFill;
            backDiverImageView.layer.masksToBounds = YES;
            [cell.contentView addSubview:backDiverImageView];
            [UILabel initWithDFLable:CGRectMake((CGRectGetWidth(backDiverImageView.frame) - 145)*0.5+backDiverImageView.frame.origin.x, 285.0f, 145, 20) :[UIFont systemFontOfSize:10] :COLOR2(68) :@"拍摄/上传驾驶证副页(选填)" :cell.contentView :1];

            backDriverButton = [UIButton buttonWithType:UIButtonTypeCustom];
            backDriverButton.frame = backDiverImageView.frame;
            [backDriverButton addTarget:self action:@selector(selectedImageFunction:) forControlEvents:(UIControlEventTouchUpInside)];
            backDriverButton.contentMode = UIViewContentModeScaleAspectFill;
            backDriverButton.layer.masksToBounds = YES;
            backDriverButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
            backDriverButton.imageView.layer.masksToBounds = YES;
            [backDriverButton setImage:self.backDriverImage forState:UIControlStateNormal];
            backDriverButton.tag = 3;
            backDriverButton.userInteractionEnabled = [self.cyrVerify integerValue] == 0;
            if ([self.cyrVerify integerValue] == 0) {
                [backDriverButton setImage:self.backDriverImage forState:UIControlStateNormal];
            }else{
                backDriverButton.userInteractionEnabled = NO;
                [backDriverButton sd_setImageWithURL:[NSURL URLWithString:self.info[@"iddriveBackBack"]] forState:UIControlStateNormal];
            }
            [cell.contentView addSubview:backDriverButton];
            
            if ([self.cyrVerify integerValue] == 0) {
                UIButton *backDiverDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [backDiverDeleteButton setImage:[UIImage imageNamed:@"delete_small"] forState:UIControlStateNormal];
                backDiverDeleteButton.frame = CGRectMake(CGRectGetMaxX(backDiverImageView.frame) - 10.0f, backDiverImageView.frame.origin.y - 10.0f, 20, 20);
                backDiverDeleteButton.tag = 3;
                [backDiverDeleteButton addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
                backDiverDeleteButton.hidden = self.backDriverImage == nil;
                [cell.contentView addSubview:backDiverDeleteButton];
            }
        }
  

        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        CGRect bounds = CGRectMake(0, 0, Width-20 , 180.0f);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(4, 4)];
        layer.frame = bounds;
        layer.path = maskPath.CGPath;
        cell.layer.mask = layer;
        
        [UILabel initWithDFLable:CGRectMake(10, 17, 185, 13) :[UIFont systemFontOfSize:13] :COLOR2(51) :@"驾驶员从业资格证" :cell.contentView :0];
    
        
        UIImageView *qualificationMainImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15.0f,50, 145,90.0f)];
        qualificationMainImageView.contentMode = UIViewContentModeScaleAspectFill;
        qualificationMainImageView.layer.masksToBounds = YES;
        qualificationMainImageView.image = [UIImage imageNamed:@"从业资格证_new"];
        [cell.contentView addSubview:qualificationMainImageView];
        [UILabel initWithDFLable:CGRectMake((CGRectGetWidth(qualificationMainImageView.frame) - 145)*0.5+qualificationMainImageView.frame.origin.x, 150, 145, 20) :[UIFont systemFontOfSize:10] :COLOR2(68) :@"点击拍摄/上传从业资格证" :cell.contentView :1];
        
        qualificationMainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        qualificationMainButton.frame = qualificationMainImageView.frame;
        [qualificationMainButton addTarget:self action:@selector(selectedImageFunction:) forControlEvents:(UIControlEventTouchUpInside)];
        qualificationMainButton.contentMode = UIViewContentModeScaleAspectFill;
        qualificationMainButton.layer.masksToBounds = YES;
        qualificationMainButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        qualificationMainButton.imageView.layer.masksToBounds = YES;
        qualificationMainButton.tag = 4;
        if ([self.cyrVerify integerValue] == 0) {
            [qualificationMainButton setImage:self.frontQualificationImage forState:UIControlStateNormal];
        }else{
            qualificationMainButton.userInteractionEnabled = NO;
            [qualificationMainButton sd_setImageWithURL:[NSURL URLWithString:self.info[@"qualificateFront"]] forState:UIControlStateNormal];
        }
        [cell.contentView addSubview:qualificationMainButton];

        if ([self.cyrVerify integerValue] == 0) {
            UIButton *qualificationMainDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [qualificationMainDeleteButton setImage:[UIImage imageNamed:@"delete_small"] forState:UIControlStateNormal];
            qualificationMainDeleteButton.frame = CGRectMake(CGRectGetMaxX(qualificationMainImageView.frame) - 10.0f, qualificationMainImageView.frame.origin.y - 10.0f, 20, 20);
            qualificationMainDeleteButton.tag = 4;
            qualificationMainDeleteButton.hidden = self.frontQualificationImage == nil;
            [qualificationMainDeleteButton addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:qualificationMainDeleteButton];
        }
        
        if ([self.cyrVerify integerValue] == 0 || (self.info[@"qualificateBack"] && [self.info[@"qualificateBack"] length] != 0)) {
            UIImageView *qualificationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Width - 180.0f,50.0f, 145,90)];
            qualificationImageView.image = [UIImage imageNamed:@"从业资格证_new"];
            qualificationImageView.contentMode = UIViewContentModeScaleAspectFill;
            qualificationImageView.layer.masksToBounds = YES;
            [cell.contentView addSubview:qualificationImageView];
            [UILabel initWithDFLable:CGRectMake((CGRectGetWidth(qualificationImageView.frame) - 145)*0.5+qualificationImageView.frame.origin.x, 150, 145, 20) :[UIFont systemFontOfSize:10] :COLOR2(68) :@"上传从业资格证副页(选填)" :cell.contentView :1];

            qualificationButton = [UIButton buttonWithType:UIButtonTypeCustom];
            qualificationButton.frame = qualificationImageView.frame;
            [qualificationButton addTarget:self action:@selector(selectedImageFunction:) forControlEvents:(UIControlEventTouchUpInside)];
            qualificationButton.contentMode = UIViewContentModeScaleAspectFill;
            qualificationButton.layer.masksToBounds = YES;
            qualificationButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
            qualificationButton.imageView.layer.masksToBounds = YES;
            qualificationButton.tag = 5;
            if ([self.cyrVerify integerValue] == 0) {
                [qualificationButton setImage:self.backQualificationImage forState:UIControlStateNormal];
            }else{
                qualificationButton.userInteractionEnabled = NO;
                [qualificationButton sd_setImageWithURL:[NSURL URLWithString:self.info[@"qualificateBack"]] forState:UIControlStateNormal];
            }
            [cell.contentView addSubview:qualificationButton];
            
            if ([self.cyrVerify integerValue] == 0) {
                UIButton *qualificationDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [qualificationDeleteButton setImage:[UIImage imageNamed:@"delete_small"] forState:UIControlStateNormal];
                qualificationDeleteButton.frame = CGRectMake(CGRectGetMaxX(qualificationImageView.frame) - 10.0f, qualificationImageView.frame.origin.y - 10.0f, 20, 20);
                qualificationDeleteButton.tag = 5;
                [qualificationDeleteButton addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
                qualificationDeleteButton.hidden = self.backQualificationImage == nil;
                [cell.contentView addSubview:qualificationDeleteButton];
            }
        }
       
        return cell;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *vc = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 10)];
    vc.backgroundColor = COLOR2(240);
    return vc;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if ([self.cyrVerify integerValue] == 0 || (self.info[@"iddriveBackBack"] && [self.info[@"iddriveBackBack"] length] != 0)) {
            return 315.0f;
        }
        return 180.0f;
    }else{
        return 180.0f;
    }
}

- (void)selectedImageFunction:(UIButton *)sender{
    self.code = [NSString stringWithFormat:@"%ld",sender.tag];
    [self onTapGR];
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
            [self.viewController presentViewController:picker animated:YES completion:nil];
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
        [self.viewController presentViewController:picker animated:YES completion:nil];
    }
}
#pragma mark - 相册delegate
//协议中的方法，当用户选择某个图片时被调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
      [picker dismissViewControllerAnimated:YES completion:nil];
    ///可编辑为 UIImagePickerControllerEditedImage
    if (self.code) {
        switch ([self.code integerValue]) {
            case 1:
            {
                self.frontDriverImage = image;
            }
                break;
            case 2:
            {
                self.backDriverMainImage = image;
            }
                break;
            case 3:
            {
                self.backDriverImage = image;
            }
                break;
            case 4:
            {
                self.frontQualificationImage = image;
            }
                break;
            case 5:
            {
                self.backQualificationImage = image;
            }
                break;
        }
    }
    [self.table reloadData];
    if (self.reloadBlock) {
        self.reloadBlock();
    }
}

- (void)deleteImageAction:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            self.frontDriverImage = nil;
        }
            break;
        case 2:
        {
            self.backDriverMainImage = nil;
        }
            break;
        case 3:
        {
            self.backDriverImage = nil;
        }
            break;
        case 4:
        {
            self.frontQualificationImage = nil;
        }
            break;
        case 5:
        {
            self.backQualificationImage = nil;
        }
            break;
    }
    [self.table reloadData];
}

//协议中的方法，当用户取消时被调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
