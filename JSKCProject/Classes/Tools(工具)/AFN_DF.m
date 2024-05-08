//
//  AFN_DF.m
//  YbtPrject
//
//  Created by aaa on 2018/6/23.
//  Copyright © 2018年 mdfs. All rights reserved.
//

#import "AFN_DF.h"
#import <sys/utsname.h>
#import "GTMBase64.h"
#import "NSData+AES.h"
#define requestTime 15
#import "PhoneLoginController.h"
#import "loginController.h"
#import "AlertView.h"

@implementation AFN_DF

#pragma mark - post方法上传图片
+ (void)POST:(NSString *)url Parameters:(NSMutableDictionary *)parameters File:(NSArray *)file ImageArr:(NSArray *)imageArr ContVC:(UIViewController *)vc success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSError *error))failure
{
    UIViewController *colletion  = vc;
    NSArray * keys = parameters.allKeys;
    for (int i = 0; i < keys.count; i++) {
        NSString * key = [keys objectAtIndex:i];
        if ([parameters valueForKey:key] == nil) {
            [parameters setValue:@"" forKey:key];
        }
    }
    if ([HUD_miss shareInstance].miss) {
//        colletion  = ;
        [LSProgressHUD showToView:colletion.view message:@"正在加载"];
    }
    
    
    NSInteger identity = [NSUserDefaults.standardUserDefaults integerForKey:LoginIdentityKey];
    
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = requestTime;
        
//        AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
//               [securityPolicy setAllowInvalidCertificates:YES];
//              [manager setSecurityPolicy:securityPolicy];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
        
        
        if ([UserModel shareInstance].accessToken != nil) {
              NSLog(@"%@",[UserModel shareInstance].accessToken);
                 AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
             [requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[UserModel shareInstance].accessToken] forHTTPHeaderField:@"authorization"];
           

                  manager.requestSerializer = requestSerializer;
             }
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:[NSString stringWithFormat:@"%@%@",HOMEURL(identity),url] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //
//         for (UIImage *image in imageArr)
//                {
//                    NSData *data = UIImageJPEGRepresentation(image, 0.2);
//                    [formData appendPartWithFileData:data name:file fileName:[file stringByAppendingString:@".jpg"] mimeType:@"image/jpg"];
//                }
        
        for (int i = 0; i < imageArr.count; i++) {
            NSData *data = UIImageJPEGRepresentation(imageArr[i], 0.2);
            NSLog(@"%@",[file[i] stringByAppendingString:@".jpg"]);
             [formData appendPartWithFileData:data name:file[i] fileName:[file[i] stringByAppendingString:@".jpg"] mimeType:@"image/jpg"];
        }
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
       if ([HUD_miss shareInstance].miss) {

                        dispatch_async(dispatch_get_main_queue(), ^{

                        [LSProgressHUD hideForView:colletion.view];
                            });

                        }


                    NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                    NSDictionary *dic =  [self dictionaryWithJsonString:string];

                NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
                    if ([code isEqual:@"200"]) {

                        success(dic);
                        }else{
                            
                            
                            if ([code isEqualToString:@"600"]) {
                                
                                if ([HUD_miss shareInstance].miss) {
                                    dispatch_async(dispatch_get_main_queue(), ^{

                                       [LSProgressHUD hideForView:colletion.view];
                                    });

                                }
                                [UserModel shareInstance].accessToken = nil;
                                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                                [user setObject:@{} forKey:@"user"];
                                if ([UIApplication.sharedApplication.keyWindow viewWithTag:1]) {
                                    UIView *subView = [UIApplication.sharedApplication.keyWindow viewWithTag:1];
                                    [subView removeFromSuperview];
                                }
                                [[AlertView alertWithTitle:@"提示" message:dic[@"msg"] cancelButtonTitle:nil otherButtonTitle:@"确认" handler:^(NSInteger actionIndex) {
                                    if (actionIndex > 0) {
                                        UINavigationController *nav = [UIApplication.sharedApplication.windows.firstObject rootViewController];
                                        if (![nav isKindOfClass:UINavigationController.class]) {
                                            if ([nav isKindOfClass:UITabBarController.class]) {
                                                UITabBarController *tabController = (UITabBarController *)nav;
                                                UIViewController *vc = tabController.selectedViewController;
                                                if ([vc isKindOfClass:UINavigationController.class]) {
                                                    nav = vc;
                                                }else{
                                                    nav = vc.navigationController;
                                                }
                                            }
                                        }
//                                        if ([TXCommonUtils simSupportedIsOK] && [TXCommonUtils checkDeviceCellularDataEnable]) {
//                                            LoginController *logVC =  [LoginController new];
//                                            [nav pushViewController:logVC animated:YES];
//                                        }else{
//                                            PhoneLoginController *logVC =  [PhoneLoginController new];
//                                            [nav pushViewController:logVC animated:YES];
//                                        }
                                        PhoneLoginController *logVC =  [PhoneLoginController new];
                                        [nav pushViewController:logVC animated:YES];
                                    }
                                }] show];
                                
                            }else{
                                
                                if ([HUD_miss shareInstance].miss) {
                                    dispatch_async(dispatch_get_main_queue(), ^{

                                       [LSProgressHUD hideForView:colletion.view];
                                    });

                                }
                                
                                dispatch_async(dispatch_get_main_queue(), ^{

                                   [[AFN_DF topViewController].view addSubview:[Toast makeText:dic[@"msg"]]];
                                });
                                
                            }
                            
                        

                        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if ([HUD_miss shareInstance].miss) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [LSProgressHUD hideForView:colletion.view];
            });
        }
        failure(error);
    }];
}

#pragma mark - get方法
+ (void)GET:(NSString *)url Parameters:(NSDictionary *)parameters success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSError *error))failure
{
    
    NSArray * keys = parameters.allKeys;
    for (int i = 0; i < keys.count; i++) {
        NSString * key = [keys objectAtIndex:i];
        if ([parameters valueForKey:key] == nil) {
            [parameters setValue:@"" forKey:key];
        }
    }

    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = requestTime;
    if ([UserModel shareInstance].accessToken != nil) {
             NSLog(@"%@",[UserModel shareInstance].accessToken);
                AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
            [requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[UserModel shareInstance].accessToken] forHTTPHeaderField:@"authorization"];
    }
    [manager GET:[NSString stringWithFormat:@"%@",url] parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
        
//        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"status"]];
     
            
            success(responseObject);
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        failure(error);
    }];
}

#pragma mark - post方法
+ (void)POST:(NSString *)url Parameters:(NSMutableDictionary *)parameters success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSError *error))failure
{
    UIViewController *colletion;
    NSArray * keys = parameters.allKeys;
    for (int i = 0; i < keys.count; i++) {
        NSString * key = [keys objectAtIndex:i];
        if ([parameters valueForKey:key] == nil) {
            [parameters setValue:@"" forKey:key];
        }
    }
    if ([HUD_miss shareInstance].miss) {
       colletion  = [AFN_DF topViewController];
    }
   

    if ([HUD_miss shareInstance].miss) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
              [LSProgressHUD showToView:colletion.view message:@"正在加载"];
        });
        
    }
//authorization
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//       manager.securityPolicy.allowInvalidCertificates = YES;
    manager.requestSerializer.timeoutInterval = requestTime;
    
//    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
//           [securityPolicy setAllowInvalidCertificates:YES];
//          [manager setSecurityPolicy:securityPolicy];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if ([UserModel shareInstance].accessToken != nil) {
          NSLog(@"%@",[UserModel shareInstance].accessToken);
             AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
         [requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[UserModel shareInstance].accessToken] forHTTPHeaderField:@"authorization"];
       

              manager.requestSerializer = requestSerializer;
         }
//     [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    if (!parameters) {
        NSInteger identity = [NSUserDefaults.standardUserDefaults integerForKey:LoginIdentityKey];
            [manager POST: [NSString stringWithFormat:@"%@%@",HOMEURL(identity),url] parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

              if ([HUD_miss shareInstance].miss) {

                                    dispatch_async(dispatch_get_main_queue(), ^{

                                      [LSProgressHUD hideForView:colletion.view];
                                    });

                                }


                                NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                                 NSDictionary *dic =  [self dictionaryWithJsonString:string];




                                NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
                                if ([code isEqual:@"200"]) {

                                  success(dic);
                                }else{
                                    
                                    
                                    if ([code isEqualToString:@"600"]) {
                                        
                                        if ([HUD_miss shareInstance].miss) {
                                            dispatch_async(dispatch_get_main_queue(), ^{

                                               [LSProgressHUD hideForView:colletion.view];
                                            });

                                        }
                                        NSLog(@"%@",url);
                                        [UserModel shareInstance].accessToken = nil;
                                        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                                        [user setObject:@{} forKey:@"user"];
                                        if ([UIApplication.sharedApplication.keyWindow viewWithTag:1]) {
                                            UIView *subView = [UIApplication.sharedApplication.keyWindow viewWithTag:1];
                                            [subView removeFromSuperview];
                                        }
                                        [[AlertView alertWithTitle:@"提示" message:dic[@"msg"] cancelButtonTitle:nil otherButtonTitle:@"确认" handler:^(NSInteger actionIndex) {
                                            if (actionIndex > 0) {
                                                UINavigationController *nav = [UIApplication.sharedApplication.windows.firstObject rootViewController];
                                                if (![nav isKindOfClass:UINavigationController.class]) {
                                                    if ([nav isKindOfClass:UITabBarController.class]) {
                                                        UITabBarController *tabController = (UITabBarController *)nav;
                                                        UIViewController *vc = tabController.selectedViewController;
                                                        if ([vc isKindOfClass:UINavigationController.class]) {
                                                            nav = vc;
                                                        }else{
                                                            nav = vc.navigationController;
                                                        }
                                                    }
                                                }
//                                                if ([TXCommonUtils simSupportedIsOK] && [TXCommonUtils checkDeviceCellularDataEnable]) {
//                                                    LoginController *logVC =  [LoginController new];
//                                                    [nav pushViewController:logVC animated:YES];
//                                                }else{
//                                                    PhoneLoginController *logVC =  [PhoneLoginController new];
//                                                    [nav pushViewController:logVC animated:YES];
//                                                }
                                                PhoneLoginController *logVC =  [PhoneLoginController new];
                                                [nav pushViewController:logVC animated:YES];
                                            }
                                        }] show];
                                       
                                        
                                    }else{
                                        
                                        if ([HUD_miss shareInstance].miss) {
                                            dispatch_async(dispatch_get_main_queue(), ^{

                                               [LSProgressHUD hideForView:colletion.view];
                                            });

                                        }
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            
                                           [[UIApplication sharedApplication].delegate.window addSubview:[Toast makeText:dic[@"msg"]]];
                                        });
                                        
                                    }
                                    
                                

                                }


            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if ([HUD_miss shareInstance].miss) {

                                      dispatch_async(dispatch_get_main_queue(), ^{

                                        [LSProgressHUD hideForView:colletion.view];
                                      });

                                  }
      

                NSLog(@"%@",error);
                

            }];
    }else{
        NSInteger identity = [NSUserDefaults.standardUserDefaults integerForKey:LoginIdentityKey];

        NSLog(@"%@,%@",HOMEURL(identity),url);
        
            [manager POST:[NSString stringWithFormat:@"%@%@",HOMEURL(identity),url] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

               
                



    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          if ([HUD_miss shareInstance].miss) {

                    dispatch_async(dispatch_get_main_queue(), ^{

                      [LSProgressHUD hideForView:colletion.view];
                    });

                }


                NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                 NSDictionary *dic =  [self dictionaryWithJsonString:string];




                NSString *code = [NSString stringWithFormat:@"%@",dic[@"code"]];
                if ([code isEqual:@"200"]) {

                  success(dic);
                }else{
                    
                    
                    if ([code isEqualToString:@"600"]) {
                        
                        if ([HUD_miss shareInstance].miss) {
                            dispatch_async(dispatch_get_main_queue(), ^{

                               [LSProgressHUD hideForView:colletion.view];
                            });

                        }
                        
                        [UserModel shareInstance].accessToken = nil;
                        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                        [user setObject:@{} forKey:@"user"];
                        if ([UIApplication.sharedApplication.keyWindow viewWithTag:1]) {
                            UIView *subView = [UIApplication.sharedApplication.keyWindow viewWithTag:1];
                            [subView removeFromSuperview];
                        }
                        [[AlertView alertWithTitle:@"提示" message:dic[@"msg"] cancelButtonTitle:nil otherButtonTitle:@"确认" handler:^(NSInteger actionIndex) {
                            if (actionIndex > 0) {
                                UINavigationController *nav = [UIApplication.sharedApplication.windows.firstObject rootViewController];
                                if (![nav isKindOfClass:UINavigationController.class]) {
                                    if ([nav isKindOfClass:UITabBarController.class]) {
                                        UITabBarController *tabController = (UITabBarController *)nav;
                                        UIViewController *vc = tabController.selectedViewController;
                                        if ([vc isKindOfClass:UINavigationController.class]) {
                                            nav = vc;
                                        }else{
                                            nav = vc.navigationController;
                                        }
                                    }
                                }
//                                if ([TXCommonUtils simSupportedIsOK] && [TXCommonUtils checkDeviceCellularDataEnable]) {
//                                    LoginController *logVC =  [LoginController new];
//                                    [nav pushViewController:logVC animated:YES];
//                                }else{
//                                    PhoneLoginController *logVC =  [PhoneLoginController new];
//                                    [nav pushViewController:logVC animated:YES];
//                                }
                                PhoneLoginController *logVC =  [PhoneLoginController new];
                                [nav pushViewController:logVC animated:YES];
                            }
                        }] show];
                        
                    }else{
                        
                        if ([HUD_miss shareInstance].miss) {
                            dispatch_async(dispatch_get_main_queue(), ^{

                               [LSProgressHUD hideForView:colletion.view];
                            });

                        }
                        failure([NSError errorWithDomain:dic[@"msg"] code:[dic[@"code"] integerValue] userInfo:nil]);

                        dispatch_async(dispatch_get_main_queue(), ^{

                            
                            if ([url isEqualToString:@"/other/getCodeValue"]) {
                                
                                [[AFN_DF topViewController].navigationController popViewControllerAnimated:YES];
                            }
                            
                           [[AFN_DF topViewController].view.window addSubview:[Toast makeText:dic[@"msg"]]];
                        });
                        
                    }
                    
                

                }


            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //
                 failure(error);
                 [LSProgressHUD hideForView:[AFN_DF topViewController].view];

                [[AFN_DF topViewController].view addSubview:[Toast makeText:@"服务器错误"]];
            }];

    }

}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    
//    __weak typeof(UIViewController) *weakSelf = resultVC;
////    __weak void sultvc  = resultVC;
//    dispatch_async(dispatch_get_main_queue(), ^{
    
     resultVC =  [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
        
//
//    });
    
 
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
#pragma mark - 32位 小写
+(NSString *)MD5ForLower32Bate:(NSString *)str{
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
        
    }
    return digest;
}

//base 64
+(NSString *)Base64Lower:(NSString *)str{
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
     NSString *base64String= [data base64EncodedStringWithOptions:0];
    
    
    
    return base64String;
}


+ (NSString *) sha1:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

///获取机型
+ (BOOL )getDeviceModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSArray *modelArray = @[ @"i386", @"x86_64", @"iPhone1,1", @"iPhone1,2", @"iPhone2,1", @"iPhone3,1", @"iPhone3,2", @"iPhone3,3", @"iPhone4,1", @"iPhone5,1", @"iPhone5,2", @"iPhone5,3", @"iPhone5,4", @"iPhone6,1", @"iPhone6,2", @"iPhone7,2", @"iPhone7,1", @"iPhone8,1", @"iPhone8,2", @"iPod1,1", @"iPod2,1", @"iPod3,1", @"iPod4,1", @"iPod5,1", @"iPad1,1", @"iPad2,1", @"iPad2,2", @"iPad2,3", @"iPad2,4", @"iPad3,1", @"iPad3,2", @"iPad3,3", @"iPad3,4", @"iPad3,5", @"iPad3,6", @"iPad2,5", @"iPad2,6", @"iPad2,7", ];
    NSArray *modelNameArray = @[ @"iPhone Simulator", @"iPhone Simulator", @"iPhone 2G", @"iPhone 3G", @"iPhone 3GS", @"iPhone 4(GSM)", @"iPhone 4(GSM Rev A)", @"iPhone 4(CDMA)", @"iPhone 4S", @"iPhone 5(GSM)", @"iPhone 5(GSM+CDMA)", @"iPhone 5c(GSM)", @"iPhone 5c(Global)", @"iphone 5s(GSM)", @"iphone 5s(Global)", @"iPhone 6", @"iPhone 6 Plus", @"iPhone 6s", @"iPhone 6s Plus", @"iPod Touch 1G", @"iPod Touch 2G", @"iPod Touch 3G", @"iPod Touch 4G", @"iPod Touch 5G", @"iPad", @"iPad 2(WiFi)", @"iPad 2(GSM)", @"iPad 2(CDMA)", @"iPad 2(WiFi + New Chip)", @"iPad 3(WiFi)", @"iPad 3(GSM+CDMA)", @"iPad 3(GSM)", @"iPad 4(WiFi)", @"iPad 4(GSM)", @"iPad 4(GSM+CDMA)", @"iPad mini (WiFi)", @"iPad mini (GSM)", @"ipad mini (GSM+CDMA)" ];
    NSInteger modelIndex = - 1;
    NSString *modelNameString = nil;
    modelIndex = [modelArray indexOfObject:deviceString];
    if (modelIndex >= 0 && modelIndex < [modelNameArray count]) { modelNameString = [modelNameArray objectAtIndex:modelIndex];
        
        
    }
      modelNameString = modelNameString ? modelNameString : @"iOS";
    
  NSString *str = [modelNameString substringToIndex:3];
    
    if (![str isEqual:@"iPh"] || [modelNameString isEqual:@"iPhone Simulator"]) {
        return YES;
    }else{
        
        return NO;
    }
 
}


+(NSString *)convertToJsonData:(NSDictionary *)dict{
       NSError *error;
    
   NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
     NSString *jsonString;
       if (!jsonData) {
             NSLog(@"%@",error);
       }else{
    jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
     NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    
      return mutStr;
    
}
    



+ (NSString *)sortedDictionary:(NSDictionary *)dict{
    
    
//    NSMutableArray *dataArray = [NSMutableArray array];
    
    //将所有的key放进数组
    NSArray *allKeyArray = [dict allKeys];
    
    //序列化器对数组进行排序的block 返回值为排序后的数组
    
    
   NSArray *afterSortKeyArray =  [allKeyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
         NSComparisonResult resuest = [obj1 compare:obj2];
                return resuest;
    }];
//    NSArray *afterSortKeyArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id
//    Nonnull obj) {
//        /**
//          In the compare: methods, the range argument specifies the
//          subrange, rather than the whole, of the receiver to use in the
//          comparison. The range is not applied to the search string.  For
//          example, [@"AB" compare:@"ABC" options:0 range:NSMakeRange(0,1)]
//          compares "A" to "ABC", not "A" to "A", and will return
//          NSOrderedAscending. It is an error to specify a range that is
//          outside of the receiver's bounds, and an exception may be raised.
//
//        - (NSComparisonResult)compare:(NSString *)string;
//
//         compare方法的比较原理为,依次比较当前字符串的第一个字母:
//         如果不同,按照输出排序结果
//         如果相同,依次比较当前字符串的下一个字母(这里是第二个)
//         以此类推
//
//         排序结果
//         NSComparisonResult resuest = [obj1 compare:obj2];为从小到大,即升序;
//         NSComparisonResult resuest = [obj2 compare:obj1];为从大到小,即降序;
//
//         注意:compare方法是区分大小写的,即按照ASCII排序
//         */
//        //排序操作
//
//    }];
    NSLog(@"afterSortKeyArray:%@",afterSortKeyArray);
    
    //通过排列的key值获取value
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *sortsing in afterSortKeyArray) {
        NSString *valueString = [dict objectForKey:sortsing];
        [valueArray addObject:valueString];
    }
   
    NSString *valueStr = @"";
    
    for (int i = 0; i <valueArray.count; i++) {
        
        NSString *str = @"";
        if (valueArray[i]) {
            str = valueArray[i];
            
            valueStr = [NSString stringWithFormat:@"%@%@%@",valueStr,afterSortKeyArray[i],str];
            
            
        }
        
//        NSDictionary *dic = @{afterSortKeyArray[i]:str};
        
       
        
        
        
//        [dataArray addObject:dic];
        
    }
    
    
     return valueStr;
}


+(NSString *)signDict:(NSMutableDictionary *)parameters{
    NSString *sign =  @"";
//    if ([UserModel shareInstance].appkey != nil) {
//      
//          NSLog(@"%@",[self getTIme]);
//          
//          NSDictionary *dic = @{
//               @"timestamp":[self getTIme],
//               @"format":@"json",
//               @"token":[UserModel shareInstance].appkey,
//               @"ver":@"1.0",
//              
//          };
//
//           NSArray *allKeyArray = [dic allKeys];
//          
//          for (NSString *key in allKeyArray) {
//              
//              [parameters setObject:dic[key] forKey:key];
//              
//          }
//
//          
//         sign =  [self sortedDictionary:parameters];
//             
//             
//              sign = [NSString stringWithFormat:@"%@%@%@",[UserModel shareInstance].appcert,sign,[UserModel shareInstance].appcert];
//                    
//                     sign =  [self MD5ForLower32Bate:sign];
//    }
//        
        
        return sign;
}

+(NSString *)getTIme{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSLog(@"formatted time is: %@",dateTime);
    
    return dateTime;
    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate:dateTime];
//    NSDate *localDate = [dateTime dateByAddingTimeInterval:interval];
//    NSLog(@"localtime is:%@",localDate);
}


@end
