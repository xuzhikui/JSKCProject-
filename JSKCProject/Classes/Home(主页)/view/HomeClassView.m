//
//  HomeClassView.m
//  ExcellentCarProject
//
//  Created by 孟德峰 on 2020/9/23.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "HomeClassView.h"
#import "ClassCell.h"
#import "MeSettingController.h"
#import "CarManController.h"
#import "DriverListController.h"
#import "NoticeController.h"
#import "FeedBackController.h"
#import "ComplaintController.h"
#import "InfoController.h"
#import "MeassListController.h"
#import "kFController.h"
#import "InfoAuthViewController.h"
#import "AddCarNewViewController.h"
#import "EntrustListViewController.h"
#import "SupplyListViewController.h"
#import "loginController.h"
@implementation HomeClassView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
   
        
        UICollectionViewFlowLayout  *flowLayout = [[UICollectionViewFlowLayout alloc]init];
                   //设置item 的行间距的 (如果不设置,默认值是10)
                   flowLayout.minimumInteritemSpacing = 10;
                   //设置item 的列间距的
                   flowLayout.minimumLineSpacing = 30;
                   //设置item的大小
                   flowLayout.itemSize = CGSizeMake((Width - 90)/4 ,50);
                   //设置滚动方向
                   flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
                   
                   //设置UICollectionView 距离屏幕 上 下 左 右 的一个距离
                   flowLayout.sectionInset = UIEdgeInsetsMake(0*Height1, 20, 0,20);
                   
                   _collectVC = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, Width,240) collectionViewLayout:flowLayout];
                   //设置collectionView的两个代理方法
                   _collectVC.dataSource = self;
                   _collectVC.delegate = self;
               //    _collectVC.scrollEnabled =NO;
                    _collectVC.backgroundColor =[UIColor clearColor];
                   [self addSubview:_collectVC];
                   //先注册collectionViewcell
                   [_collectVC registerClass:[ClassCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return self;
}

- (void)reloadData{
    if (UserModel.shareInstance.type == 1) {
        self.ImgArry = @[@{@"img":@"我-司机-1",@"tit":@"身份认证"},
                         @{@"img":@"我-公告-1",@"tit":@"法律公告"},
                         @{@"img":@"我-客服-1",@"tit":@"意见反馈"},
                         @{@"img":@"我-反馈-1",@"tit":@"联系客服"},
                         @{@"img":@"我的消息",@"tit":@"我的消息"},
                         @{@"img":@"我-设置-1",@"tit":@"设置",},
        ];
    }else{
        if (UserModel.shareInstance.sourceCompanyOpen && UserModel.shareInstance.entrustOpen) {
            self.ImgArry = @[@{@"img":@"我-司机-1",@"tit":@"司机认证"},
                              @{@"img":@"车车-1",@"tit":@"绑定车辆"},
                             @{@"img":@"我-委托收款人-1",@"tit":@"委托收款人",},
                             @{@"img":@"我-货源公司-1",@"tit":@"货源公司",},
                             @{@"img":@"我-投诉-1",@"tit":@"我要投诉"},
                             @{@"img":@"我-客服-1",@"tit":@"意见反馈"},
                             @{@"img":@"我的消息",@"tit":@"我的消息"},
                             @{@"img":@"我-设置-1",@"tit":@"设置",},
                             @{@"img":@"我-反馈-1",@"tit":@"联系客服"},
                             @{@"img":@"我-公告-1",@"tit":@"法律公告"},
            ];
        }else if (UserModel.shareInstance.sourceCompanyOpen && !UserModel.shareInstance.entrustOpen){
            self.ImgArry = @[@{@"img":@"我-司机-1",@"tit":@"司机认证"},
                              @{@"img":@"车车-1",@"tit":@"绑定车辆"},
                             @{@"img":@"我-货源公司-1",@"tit":@"货源公司",},
                             @{@"img":@"我-投诉-1",@"tit":@"我要投诉"},
                             @{@"img":@"我-客服-1",@"tit":@"意见反馈"},
                             @{@"img":@"我的消息",@"tit":@"我的消息"},
                             @{@"img":@"我-设置-1",@"tit":@"设置",},
                             @{@"img":@"我-反馈-1",@"tit":@"联系客服"},
                             @{@"img":@"我-公告-1",@"tit":@"法律公告"},
            ];
        }else if (!UserModel.shareInstance.sourceCompanyOpen && UserModel.shareInstance.entrustOpen){
            self.ImgArry = @[@{@"img":@"我-司机-1",@"tit":@"司机认证"},
                              @{@"img":@"车车-1",@"tit":@"绑定车辆"},
                             @{@"img":@"我-委托收款人-1",@"tit":@"委托收款人",},
                             @{@"img":@"我-投诉-1",@"tit":@"我要投诉"},
                             @{@"img":@"我-客服-1",@"tit":@"意见反馈"},
                             @{@"img":@"我的消息",@"tit":@"我的消息"},
                             @{@"img":@"我-设置-1",@"tit":@"设置",},
                             @{@"img":@"我-反馈-1",@"tit":@"联系客服"},
                             @{@"img":@"我-公告-1",@"tit":@"法律公告"},
            ];
        }else{
            self.ImgArry = @[@{@"img":@"我-司机-1",@"tit":@"司机认证"},
                              @{@"img":@"车车-1",@"tit":@"绑定车辆"},
                             @{@"img":@"我-投诉-1",@"tit":@"我要投诉"},
                             @{@"img":@"我-客服-1",@"tit":@"意见反馈"},
                             @{@"img":@"我的消息",@"tit":@"我的消息"},
                             @{@"img":@"我-设置-1",@"tit":@"设置",},
                             @{@"img":@"我-反馈-1",@"tit":@"联系客服"},
                             @{@"img":@"我-公告-1",@"tit":@"法律公告"},
            ];
        }

    }
    [self.collectVC reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.ImgArry.count;
}



-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
  
        
        ClassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//        cell.layer.cornerRadius = cell.frame.size.height/2;
//           cell.layer.masksToBounds = YES;
    for (UIView *vc in cell.contentView.subviews) {
        
        [vc removeFromSuperview];
    }
    cell.backgroundColor = [UIColor clearColor];
//           cell.backgroundColor = [UIColor grayColor];
        cell.dic = self.ImgArry[indexPath.row];
    if (UserModel.shareInstance.type == 1) {
        if (indexPath.row == 4) {
            cell.code = self.code;
        }else{
            
            cell.code = @"0";
        }
    }else{
        if (indexPath.row == 6) {
            cell.code = self.code;
        }else{
            
            cell.code = @"0";
        }
    }
  
    
                [cell setUI];
//           UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
//            [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOMEURL,self.ppArray[indexPath.row][@"image"]]]];
    
            
           return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([UserModel shareInstance].accessToken == nil) {
//        if ([TXCommonUtils simSupportedIsOK] && [TXCommonUtils checkDeviceCellularDataEnable]) {
//            LoginController *logVC =  [LoginController new];
//            [[AFN_DF topViewController].navigationController pushViewController:logVC animated:YES];
//        }else{
//            PhoneLoginController *logVC =  [PhoneLoginController new];
////            logVC.code = @"1";
//            [[AFN_DF topViewController].navigationController pushViewController:logVC animated:YES];
//        }
        PhoneLoginController *logVC =  [PhoneLoginController new];
//            logVC.code = @"1";
        [[AFN_DF topViewController].navigationController pushViewController:logVC animated:YES];
        return;
    }
    
    if ([UserModel shareInstance].type == 1) {
        switch (indexPath.item) {
            case 0:
            {
                InfoController *infoVC = [InfoController new];
                infoVC.cyrVerify = [NSString stringWithFormat:@"%@",UserModel.shareInstance.cyrVerify];
                [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
            }
                break;
            case 1:
            {
                NoticeController *driVC = [NoticeController new];
                [[AFN_DF topViewController].navigationController pushViewController:driVC animated:YES];
            }
                break;
            case 2:
            {
                FeedBackController *fedVC = [FeedBackController new];
                [[AFN_DF topViewController].navigationController pushViewController:fedVC animated:YES];
            }
                break;
            case 3:
            {
                /// 联系客服
                   kFController *kfVC = [kFController new];
                   [[AFN_DF topViewController].navigationController pushViewController:kfVC animated:YES];
           //     NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"18051257891"];
           //     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
                break;
            case 4:
            {
                MeassListController *list  = [MeassListController new];
                [[AFN_DF topViewController].navigationController pushViewController:list animated:YES];
            }
                break;
            case 5:
            {
                MeSettingController *setVC = [MeSettingController new];
                [[AFN_DF topViewController].navigationController pushViewController:setVC animated:YES];
        
            }
                break;
        }

    }else{
        if (UserModel.shareInstance.sourceCompanyOpen && UserModel.shareInstance.entrustOpen) {
            switch (indexPath.item) {
                case 0:
                {
                    UserModel *userInfo = [UserModel shareInstance];
                    if ([[NSString stringWithFormat:@"%@",userInfo.cyrVerify] isEqualToString:@"1"]) {
                        
                        InfoAuthViewController *infoVC = [InfoAuthViewController new];
                        infoVC.cyrVerify = [NSString stringWithFormat:@"%@",UserModel.shareInstance.cyrVerify];
                        [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
                    }else if ([[NSString stringWithFormat:@"%@",userInfo.cyrVerify] isEqualToString:@"0"]){
                        InfoAuthViewController *infoVC = [InfoAuthViewController new];
                        infoVC.cyrVerify = [NSString stringWithFormat:@"%@",UserModel.shareInstance.cyrVerify];
                        [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
                    }else{
                        InfoAuthViewController *infoVC = [InfoAuthViewController new];
                        infoVC.cyrVerify = [NSString stringWithFormat:@"%@",userInfo.cyrVerify];
                        [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
                    }
                }
                    break;
                case 1:
                {
                    UserModel *userInfo = [UserModel shareInstance];
                    if ([[NSString stringWithFormat:@"%@",userInfo.cyrVerify] isEqualToString:@"0"]) {
                        
                        InfoVC *infoVC = [[InfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                        infoVC.tag = 1;
                        [UIApplication.sharedApplication.keyWindow addSubview:infoVC];
                    }else{
                        if ((userInfo.bandTruckId == nil || [userInfo.bandTruckId integerValue] == 0 ) && (userInfo.bandTruckCount == nil || [userInfo.bandTruckCount integerValue] == 0) ) {
                            //绑定车辆
                            AddCarNewViewController *cardNewVC = [AddCarNewViewController new];
                            cardNewVC.addType = @"1";
                            [[AFN_DF topViewController].navigationController pushViewController:cardNewVC animated:YES];
                        }else if ((userInfo.bandTruckId == nil || [userInfo.bandTruckId integerValue] == 0 ) && [userInfo.bandTruckCount integerValue] != 0){
                            CarManController *manVC = [CarManController new];
                            [[AFN_DF topViewController].navigationController pushViewController:manVC animated:YES];
                        }else{
                            AddCarNewViewController *cardNewVC = [AddCarNewViewController new];
                            cardNewVC.truckId = [userInfo.bandTruckId integerValue];
                            [[AFN_DF topViewController].navigationController pushViewController:cardNewVC animated:YES];
                        }
                    }
                }
                    break;
                case 2:
                {
                    if ([UserModel shareInstance].idcard == nil || [UserModel shareInstance].idcard.length == 0) {
                        return [[AFN_DF topViewController].view addSubview:[Toast makeText:@"身份认证通过后，才可以委托收款人"]];
                    }else{
                        EntrustListViewController *entrustListVC = [EntrustListViewController new];
                        [[AFN_DF topViewController].navigationController pushViewController:entrustListVC animated:YES];
                    }
                   
                }
                    break;
                case 3:
                {
                    SupplyListViewController *supplyListVC = [SupplyListViewController new];
                    [[AFN_DF topViewController].navigationController pushViewController:supplyListVC animated:YES];
                }
                    break;
                case 4:
                {

                    if ([[NSString stringWithFormat:@"%@",[UserModel shareInstance].cyrVerify] isEqualToString:@"0"]) {
                        
                        InfoVC *infoVC = [[InfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                        infoVC.tag = 1;
                        [UIApplication.sharedApplication.keyWindow addSubview:infoVC];
                    }else{
                        ComplaintController *compVC = [ComplaintController new];
                        [[AFN_DF topViewController].navigationController pushViewController:compVC animated:YES];
                    }
                }
                    break;
                case 5:
                {
                    FeedBackController *fedVC = [FeedBackController new];
                    [[AFN_DF topViewController].navigationController pushViewController:fedVC animated:YES];
                    
                }
                    break;
                case 6:
                {
                    //我的消息
                    MeassListController *list  = [MeassListController new];
                    [[AFN_DF topViewController].navigationController pushViewController:list animated:YES];
                   
                }
                    break;
                case 7:
                {
                    MeSettingController *setVC = [MeSettingController new];
                    [[AFN_DF topViewController].navigationController pushViewController:setVC animated:YES];
            
                }
                    break;
                case 8:
                {
                    /// 联系客服
                       kFController *kfVC = [kFController new];
                       [[AFN_DF topViewController].navigationController pushViewController:kfVC animated:YES];
               //     NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"18051257891"];
               //     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                }
                    break;
                    
                default:
                {
                    NoticeController *driVC = [NoticeController new];
                    [[AFN_DF topViewController].navigationController pushViewController:driVC animated:YES];
                }
                    break;
            }
        }else if (UserModel.shareInstance.sourceCompanyOpen && !UserModel.shareInstance.entrustOpen){
            switch (indexPath.item) {
                case 0:
                {
                    UserModel *userInfo = [UserModel shareInstance];
                    if ([[NSString stringWithFormat:@"%@",userInfo.cyrVerify] isEqualToString:@"1"]) {
                        
                        InfoAuthViewController *infoVC = [InfoAuthViewController new];
                        infoVC.cyrVerify = [NSString stringWithFormat:@"%@",UserModel.shareInstance.cyrVerify];
                        [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
                    }else if ([[NSString stringWithFormat:@"%@",userInfo.cyrVerify] isEqualToString:@"0"]){
                        InfoAuthViewController *infoVC = [InfoAuthViewController new];
                        infoVC.cyrVerify = [NSString stringWithFormat:@"%@",UserModel.shareInstance.cyrVerify];
                        [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
                    }else{
                        InfoAuthViewController *infoVC = [InfoAuthViewController new];
                        infoVC.cyrVerify = [NSString stringWithFormat:@"%@",userInfo.cyrVerify];
                        [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
                    }
                }
                    break;
                case 1:
                {
                    UserModel *userInfo = [UserModel shareInstance];
                    if ([[NSString stringWithFormat:@"%@",userInfo.cyrVerify] isEqualToString:@"0"]) {
                        
                        InfoVC *infoVC = [[InfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                        infoVC.tag = 1;
                        [UIApplication.sharedApplication.keyWindow addSubview:infoVC];
                    }else{
                        if ((userInfo.bandTruckId == nil || [userInfo.bandTruckId integerValue] == 0 ) && (userInfo.bandTruckCount == nil || [userInfo.bandTruckCount integerValue] == 0) ) {
                            //绑定车辆
                            AddCarNewViewController *cardNewVC = [AddCarNewViewController new];
                            cardNewVC.addType = @"1";
                            [[AFN_DF topViewController].navigationController pushViewController:cardNewVC animated:YES];
                        }else if ((userInfo.bandTruckId == nil || [userInfo.bandTruckId integerValue] == 0 ) && [userInfo.bandTruckCount integerValue] != 0){
                            CarManController *manVC = [CarManController new];
                            [[AFN_DF topViewController].navigationController pushViewController:manVC animated:YES];
                        }else{
                            AddCarNewViewController *cardNewVC = [AddCarNewViewController new];
                            cardNewVC.truckId = [userInfo.bandTruckId integerValue];
                            [[AFN_DF topViewController].navigationController pushViewController:cardNewVC animated:YES];
                        }
                    }
                }
                    break;
                case 2:
                {
                    SupplyListViewController *supplyListVC = [SupplyListViewController new];
                    [[AFN_DF topViewController].navigationController pushViewController:supplyListVC animated:YES];
                }
                    break;
                case 3:
                {

                    if ([[NSString stringWithFormat:@"%@",[UserModel shareInstance].cyrVerify] isEqualToString:@"0"]) {
                        
                        InfoVC *infoVC = [[InfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                        infoVC.tag = 1;
                        [UIApplication.sharedApplication.keyWindow addSubview:infoVC];
                    }else{
                        ComplaintController *compVC = [ComplaintController new];
                        [[AFN_DF topViewController].navigationController pushViewController:compVC animated:YES];
                    }
                }
                    break;
                case 4:
                {
                    FeedBackController *fedVC = [FeedBackController new];
                    [[AFN_DF topViewController].navigationController pushViewController:fedVC animated:YES];
                    
                }
                    break;
                case 5:
                {
                    //我的消息
                    MeassListController *list  = [MeassListController new];
                    [[AFN_DF topViewController].navigationController pushViewController:list animated:YES];
                   
                }
                    break;
                case 6:
                {
                    MeSettingController *setVC = [MeSettingController new];
                    [[AFN_DF topViewController].navigationController pushViewController:setVC animated:YES];
            
                }
                    break;
                case 7:
                {
                    /// 联系客服
                       kFController *kfVC = [kFController new];
                       [[AFN_DF topViewController].navigationController pushViewController:kfVC animated:YES];
               //     NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"18051257891"];
               //     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                }
                    break;
                    
                default:
                {
                    NoticeController *driVC = [NoticeController new];
                    [[AFN_DF topViewController].navigationController pushViewController:driVC animated:YES];
                }
                    break;
            }
        }else if (!UserModel.shareInstance.sourceCompanyOpen && UserModel.shareInstance.entrustOpen){
            switch (indexPath.item) {
                case 0:
                {
                    UserModel *userInfo = [UserModel shareInstance];
                    if ([[NSString stringWithFormat:@"%@",userInfo.cyrVerify] isEqualToString:@"1"]) {
                        
                        InfoAuthViewController *infoVC = [InfoAuthViewController new];
                        infoVC.cyrVerify = [NSString stringWithFormat:@"%@",UserModel.shareInstance.cyrVerify];
                        [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
                    }else if ([[NSString stringWithFormat:@"%@",userInfo.cyrVerify] isEqualToString:@"0"]){
                        InfoAuthViewController *infoVC = [InfoAuthViewController new];
                        infoVC.cyrVerify = [NSString stringWithFormat:@"%@",UserModel.shareInstance.cyrVerify];
                        [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
                    }else{
                        InfoAuthViewController *infoVC = [InfoAuthViewController new];
                        infoVC.cyrVerify = [NSString stringWithFormat:@"%@",userInfo.cyrVerify];
                        [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
                    }
                }
                    break;
                case 1:
                {
                    UserModel *userInfo = [UserModel shareInstance];
                    if ([[NSString stringWithFormat:@"%@",userInfo.cyrVerify] isEqualToString:@"0"]) {
                        
                        InfoVC *infoVC = [[InfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                        infoVC.tag = 1;
                        [UIApplication.sharedApplication.keyWindow addSubview:infoVC];
                    }else{
                        if ((userInfo.bandTruckId == nil || [userInfo.bandTruckId integerValue] == 0 ) && (userInfo.bandTruckCount == nil || [userInfo.bandTruckCount integerValue] == 0) ) {
                            //绑定车辆
                            AddCarNewViewController *cardNewVC = [AddCarNewViewController new];
                            cardNewVC.addType = @"1";
                            [[AFN_DF topViewController].navigationController pushViewController:cardNewVC animated:YES];
                        }else if ((userInfo.bandTruckId == nil || [userInfo.bandTruckId integerValue] == 0 ) && [userInfo.bandTruckCount integerValue] != 0){
                            CarManController *manVC = [CarManController new];
                            [[AFN_DF topViewController].navigationController pushViewController:manVC animated:YES];
                        }else{
                            AddCarNewViewController *cardNewVC = [AddCarNewViewController new];
                            cardNewVC.truckId = [userInfo.bandTruckId integerValue];
                            [[AFN_DF topViewController].navigationController pushViewController:cardNewVC animated:YES];
                        }
                    }
                }
                    break;
                case 2:
                {
                    if ([UserModel shareInstance].idcard == nil || [UserModel shareInstance].idcard.length == 0) {
                        return [[AFN_DF topViewController].view addSubview:[Toast makeText:@"身份认证通过后，才可以委托收款人"]];
                    }else{
                        EntrustListViewController *entrustListVC = [EntrustListViewController new];
                        [[AFN_DF topViewController].navigationController pushViewController:entrustListVC animated:YES];
                    }
                   
                }
                    break;
                case 3:
                {

                    if ([[NSString stringWithFormat:@"%@",[UserModel shareInstance].cyrVerify] isEqualToString:@"0"]) {
                        
                        InfoVC *infoVC = [[InfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                        infoVC.tag = 1;
                        [UIApplication.sharedApplication.keyWindow addSubview:infoVC];
                    }else{
                        ComplaintController *compVC = [ComplaintController new];
                        [[AFN_DF topViewController].navigationController pushViewController:compVC animated:YES];
                    }
                }
                    break;
                case 4:
                {
                    FeedBackController *fedVC = [FeedBackController new];
                    [[AFN_DF topViewController].navigationController pushViewController:fedVC animated:YES];
                    
                }
                    break;
                case 5:
                {
                    //我的消息
                    MeassListController *list  = [MeassListController new];
                    [[AFN_DF topViewController].navigationController pushViewController:list animated:YES];
                   
                }
                    break;
                case 6:
                {
                    MeSettingController *setVC = [MeSettingController new];
                    [[AFN_DF topViewController].navigationController pushViewController:setVC animated:YES];
            
                }
                    break;
                case 7:
                {
                    /// 联系客服
                       kFController *kfVC = [kFController new];
                       [[AFN_DF topViewController].navigationController pushViewController:kfVC animated:YES];
               //     NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"18051257891"];
               //     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                }
                    break;
                    
                default:
                {
                    NoticeController *driVC = [NoticeController new];
                    [[AFN_DF topViewController].navigationController pushViewController:driVC animated:YES];
                }
                    break;
            }
        }else{
            switch (indexPath.item) {
                case 0:
                {
                    UserModel *userInfo = [UserModel shareInstance];
                    if ([[NSString stringWithFormat:@"%@",userInfo.cyrVerify] isEqualToString:@"1"]) {
                        
                        InfoAuthViewController *infoVC = [InfoAuthViewController new];
                        infoVC.cyrVerify = [NSString stringWithFormat:@"%@",UserModel.shareInstance.cyrVerify];
                        [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
                    }else if ([[NSString stringWithFormat:@"%@",userInfo.cyrVerify] isEqualToString:@"0"]){
                        InfoAuthViewController *infoVC = [InfoAuthViewController new];
                        infoVC.cyrVerify = [NSString stringWithFormat:@"%@",UserModel.shareInstance.cyrVerify];
                        [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
                    }else{
                        InfoAuthViewController *infoVC = [InfoAuthViewController new];
                        infoVC.cyrVerify = [NSString stringWithFormat:@"%@",userInfo.cyrVerify];
                        [[AFN_DF topViewController].navigationController pushViewController:infoVC animated:YES];
                    }
                }
                    break;
                case 1:
                {
                    UserModel *userInfo = [UserModel shareInstance];
                    if ([[NSString stringWithFormat:@"%@",userInfo.cyrVerify] isEqualToString:@"0"]) {
                        
                        InfoVC *infoVC = [[InfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                        infoVC.tag = 1;
                        [UIApplication.sharedApplication.keyWindow addSubview:infoVC];
                    }else{
                        if ((userInfo.bandTruckId == nil || [userInfo.bandTruckId integerValue] == 0 ) && (userInfo.bandTruckCount == nil || [userInfo.bandTruckCount integerValue] == 0) ) {
                            //绑定车辆
                            AddCarNewViewController *cardNewVC = [AddCarNewViewController new];
                            cardNewVC.addType = @"1";
                            [[AFN_DF topViewController].navigationController pushViewController:cardNewVC animated:YES];
                        }else if ((userInfo.bandTruckId == nil || [userInfo.bandTruckId integerValue] == 0 ) && [userInfo.bandTruckCount integerValue] != 0){
                            CarManController *manVC = [CarManController new];
                            [[AFN_DF topViewController].navigationController pushViewController:manVC animated:YES];
                        }else{
                            AddCarNewViewController *cardNewVC = [AddCarNewViewController new];
                            cardNewVC.truckId = [userInfo.bandTruckId integerValue];
                            [[AFN_DF topViewController].navigationController pushViewController:cardNewVC animated:YES];
                        }
                    }
                }
                    break;
                case 2:
                {

                    if ([[NSString stringWithFormat:@"%@",[UserModel shareInstance].cyrVerify] isEqualToString:@"0"]) {
                        
                        InfoVC *infoVC = [[InfoVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                        infoVC.tag = 1;
                        [UIApplication.sharedApplication.keyWindow addSubview:infoVC];
                    }else{
                        ComplaintController *compVC = [ComplaintController new];
                        [[AFN_DF topViewController].navigationController pushViewController:compVC animated:YES];
                    }
                }
                    break;
                case 3:
                {
                    FeedBackController *fedVC = [FeedBackController new];
                    [[AFN_DF topViewController].navigationController pushViewController:fedVC animated:YES];
                    
                }
                    break;
                case 4:
                {
                    //我的消息
                    MeassListController *list  = [MeassListController new];
                    [[AFN_DF topViewController].navigationController pushViewController:list animated:YES];
                   
                }
                    break;
                case 5:
                {
                    MeSettingController *setVC = [MeSettingController new];
                    [[AFN_DF topViewController].navigationController pushViewController:setVC animated:YES];
            
                }
                    break;
                case 6:
                {
                    /// 联系客服
                       kFController *kfVC = [kFController new];
                       [[AFN_DF topViewController].navigationController pushViewController:kfVC animated:YES];
               //     NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"18051257891"];
               //     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                }
                    break;
                    
                default:
                {
                    NoticeController *driVC = [NoticeController new];
                    [[AFN_DF topViewController].navigationController pushViewController:driVC animated:YES];
                }
                    break;
            }
        }
    }
}

@end
