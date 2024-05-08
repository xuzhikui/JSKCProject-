//
//  UserModel.h
//  LssProject
//
//  Created by lss on 2020/5/18.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject
+(instancetype) shareInstance;
@property(nonatomic,strong)NSString *createtime;
@property(nonatomic,strong)NSString *balance;
@property(nonatomic,strong)NSString *creditScore;
@property(nonatomic,strong)NSString *cyrVerify;     //认证状态，0、未认证，1、认证成功，2、认证失败，3、身份证过期，4、身份证即将过期, 5、认证中
@property(nonatomic,strong)NSString *headurl;
@property(nonatomic,strong)NSString *idcard;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *accessToken;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *refreshToken;
@property(nonatomic,strong)NSString *tokenType;
@property(nonatomic,strong)NSString *hasBankCard;
@property(nonatomic,strong)NSNumber *bandTruckId;       //绑定车辆Id
@property(nonatomic,strong)NSNumber *bandTruckCount;    //绑定车辆数
@property(nonatomic,assign)NSInteger type;              //身份类型：1、经纪人，2、司机
@property(nonatomic,assign)BOOL sourceCompanyOpen;      //货源公司开关（0、不显示，1、显示）
@property(nonatomic,assign)BOOL entrustOpen;            //委托收款人开关（0、不显示，1、显示）

@end

NS_ASSUME_NONNULL_END
