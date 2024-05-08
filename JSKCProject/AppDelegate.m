//
//  AppDelegate.m
//  JSKCProject
//
//  Created by 孟德峰 on 2020/9/12.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginController.h"
#import "PhoneLoginController.h"
#import "LoginController.h"
#import <ATAuthSDK/TXCommonHandler.h>//;
#import "MainController.h"
#import "MCTabBarController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "JurisdictionController.h"
#import "JPUSHService.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<JPUSHRegisterDelegate>
@property(nonatomic,strong)CLLocationManager *locationManager;
@end

@implementation AppDelegate

static NSString *channel = @"Publish channel";
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *authSDKInfo = [[NSUserDefaults standardUserDefaults] objectForKey:PNSATAUTHSDKINFOKEY];
    if (!authSDKInfo || authSDKInfo.length == 0) {
        authSDKInfo = PNSATAUTHSDKINFO;
    }
    [PNSHttpsManager requestATAuthSDKInfo:^(BOOL isSuccess, NSString * _Nonnull authSDKInfo) {
        if (isSuccess) {
            [[NSUserDefaults standardUserDefaults] setObject:authSDKInfo forKey:PNSATAUTHSDKINFOKEY];
        }
    }];
    [[TXCommonHandler sharedInstance] setAuthSDKInfo:authSDKInfo
                                            complete:^(NSDictionary * _Nonnull resultDic) {
        NSLog(@"设置秘钥结果：%@", resultDic);
    }];
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestAlwaysAuthorization];
    
//    MapService *map = [[MapService alloc]init];
//    [map openServiceWithAppId:@"com.df.JSKCProjectD" appSecurity:@"7d6dc9998a0e4bc08f60fc480ae13e967d6dc9998a0e4bc08f60fc480ae13e96" enterpriseSenderCode:@"32963" environment:@"release" listener:^(id  _Nonnull model, NSError * _Nonnull error) {
//
//        NSLog(@"%@",model);
//
//
//
//    }];
    
//    [[MapService init]
    
    
    NSUserDefaults *iamges = [NSUserDefaults standardUserDefaults];
    NSDictionary *imagesdata = [iamges objectForKey:@"images"];
    [[ImageUrlModel shareInstance] setValuesForKeysWithDictionary:imagesdata];
    
#pragma make ----获取网络加载等替换图片 -----
    
    [AFN_DF POST:@"/public/getPublicData" Parameters:nil success:^(NSDictionary *responseObject) {
         
        
        if (imagesdata == nil) {
            [[ImageUrlModel shareInstance]setValuesForKeysWithDictionary:responseObject[@"data"]];
        }

          ///每次请求保存下来，默认使用上一次请求的方式，第一次为空
        
                    NSDictionary *dic = responseObject[@"data"];
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                   [user setObject:dic forKey:@"images"];
       
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        // Fallback on earlier versions
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:@"d463ae6d43a29bb1fc579ebd"
                          channel:channel
                 apsForProduction:YES
            advertisingIdentifier:nil];
    
    
    
    
      [HUD_miss shareInstance].miss = YES;
    
        [AMapServices sharedServices].apiKey =@"cfab604292b8617395edf83a32376cd3";
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
         
    
          NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
          NSDictionary *data = [user objectForKey:@"user"];
          NSString *oneLaunScreen = [user objectForKey:@"one"];

    if ([oneLaunScreen isEqualToString:@"1"]) {

        if (data[@"accessToken"]) {

            [[UserModel shareInstance]setValuesForKeysWithDictionary:data];
            [self postNUmmeass];
                self.window.rootViewController = [MainController new];
            }else{
//                if ([TXCommonUtils simSupportedIsOK] && [TXCommonUtils checkDeviceCellularDataEnable]) {
//                    LoginController *logVC =  [LoginController new];
//                    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:logVC];
//                }else{
//                    PhoneLoginController *logVC =  [PhoneLoginController new];
//                    logVC.code = @"1";
//                    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:logVC];
//                }
                PhoneLoginController *logVC =  [PhoneLoginController new];
                logVC.code = @"1";
                self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:logVC];
            }
    }else{
        JurisdictionController *jusVC = [JurisdictionController new];
        self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:jusVC];
        ///设置权限页启动图
        [self setOneLaunchScreen];
    }

        self.window.backgroundColor = [UIColor whiteColor];
//    self.window.rootViewController = [MainController new];
     [self.window makeKeyAndVisible];
  
//    self.window.rootViewController = [[NavController alloc]initWithRootViewController:[PhoneLoginController new]];
    

    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    keyboardManager.shouldShowToolbarPlaceholder = NO; // 是否显示占位文字
    keyboardManager.placeholderFont = [UIFont systemFontOfSize:15.0f]; // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
    keyboardManager.toolbarTintColor = COLOR2(51);
    keyboardManager.toolbarDoneBarButtonItemText = keyboardManager.toolbarDoneBarButtonItemAccessibilityLabel = @"完成";

    return YES;
}

-(void)postNUmmeass{
    
    
    [AFN_DF POST:@"/system/mess/getUnreadCount" Parameters:nil success:^(NSDictionary *responseObject) {
        
        NSLog(@"%@",responseObject);
        
        
        NSString *tag = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"unread"]];
        
        UITabBarController *tabBarVC = (UITabBarController*)self.window.rootViewController;

            //获取指定item

            UITabBarItem *item = [[[tabBarVC tabBar] items] objectAtIndex:3];

            //设置item角标数字

        
        if ([tag isEqualToString:@"0"]) {
            item.badgeValue=nil;
        }else{
            
            item.badgeValue=tag;
        }
           
        
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


-(void)setOneLaunchScreen{
    
                           
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:@"1" forKey:@"one"];
    
}

- (void)amapLocationManager:(AMapLocationManager *)manager doRequireLocationAuth:(CLLocationManager*)locationManager
{
    [locationManager requestAlwaysAuthorization];
}


///极光
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//      [MQManager registerDeviceToken:deviceToken];
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}




- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0)){
    if (@available(iOS 10.0, *)) {
        if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //从通知界面直接进入应用
        }else{
            //从通知设置界面进入应用
        }
    } else {
        // Fallback on earlier versions
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)) API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}





#pragma mark - UISceneSession lifecycle



@end
