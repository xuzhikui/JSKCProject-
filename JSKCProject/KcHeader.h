//
//  KcHeader.h
//  JSKCProject
//
//  Created by 孟德峰 on 2020/9/12.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#ifndef KcHeader_h
#define KcHeader_h
#import "PNSHttpsManager.h"
#import "SDImageCache.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#import "Toast.h"
#import "AFNetworking.h"
#import "LSProgressHUD.h"
#import "UIButton+DF.h"
#import "AFN_DF.h"
#import "HUD_miss.h"
#import "XFDaterView.h"
#import "UtilityMacro.h"
#import "CZHAddressPickerView.h"
#import "UILabel+DF.h"
#import "UIImageView+DF.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "NavController.h"
#import <ATAuthSDK/ATAuthSDK.h>
#import "UserModel.h"
#import "LoactionModel.h"
#import "THDatePickerView.h"
#import "ImageVC.h"
#import "WKController.h"
#import "UITextView+ZWPlaceHolder.h"
#import "PtoVC.h"
#import "PhoneLoginController.h"
#import "Macros.h"
#import "Masonry.h"
#import "InitializationUIMethod.h"
#import "InfoVC.h"
#import "CardInfoVC.h"
#import "VehicleInfoVC.h"
#import "ImageUrlModel.h"
#import <MapManager/MapManager.h>
#import "BRPickerView.h"
#import "IQKeyboardManager.h"
#import "PNSBuildModelUtils.h"
#import "AppDelegate.h"
#import "UITabBarController+ExtendedMethods.h"

#define PHONEXTAB [UIApplication sharedApplication].statusBarFrame.size.height + 24.0
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
#define Width1 [UIScreen mainScreen].bounds.size.width/414.0
#define Height1 [UIScreen mainScreen].bounds.size.height/736.0
#define NVAHEIGHT  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height

//#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define mc_Is_iphone ([UIDevice currentDevice].model == UIUserInterfaceIdiomPhone)
#define mc_Is_iphoneX SCREEN_WIDTH >=375.0f && SCREEN_HEIGHT >=812.0f&& mc_Is_iphone
    
/*状态栏高度*/
//#define StatusBarHeight (CGFloat)(mc_Is_iphoneX?(44.0):(20.0))
#define StatusBarHeight (@available(iOS 13.0, *)?[UIApplication sharedApplication].windows[0].windowScene.statusBarManager.statusBarFrame.size.height:[[UIApplication sharedApplication] statusBarFrame].size.height)


#define NavaBarHeight  (StatusBarHeight + 44.0)
#define TabBarHeight  (NavaBarHeight==64?49:83)
#define ScreenBottom  (NavaBarHeight==64?0:34)
#define UISafeAreaBottomHeight  ({\
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate; \
    appDelegate.window.safeAreaInsets.bottom; \
})\


//#define HOMEURL @"http://test.sdlssapp.com/v1/entry/"
//#define HOMEURL @"http://106.15.103.224:8083"
#ifdef DEBUG
//#define HOMEURL(identity) (identity == 0 ? @"http://106.15.103.224:8086" : @"http://106.15.103.224:8083")
#define HOMEURL(identity) (identity == 0 ? @"https://insideapi.yx56.net/cyrapp" : @"https://insideapi.yx56.net/agent")

#else
#define HOMEURL(identity) (identity == 0 ? @"https://insideapi.yx56.net/cyrapp" : @"https://insideapi.yx56.net/agent")
#endif

#define LoginIdentityKey @"LoginIdentityKey"

//https://api.sdlssapp.com
//#define HOMEURL @"https://insideapi.jskc56.com/cyrapp"
//#define HOMEURL @"http://192.168.31.35:8083"
//#define HOMEURL @"http://106.15.103.224:8083"
//#define ImgURL @"http://ty.biankekeji.com/"
#define STHEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
//#define HOMEURL @"http://tsing.s1.natapp.cc"
// 相机权限
#import<AVFoundation/AVCaptureDevice.h>
#import<AVFoundation/AVMediaFormat.h>

#define PNSATAUTHSDKINFOKEY @"ATAuthSDKInfoKey"
//#define PNSATAUTHSDKINFO @"+cIuL4jODbIamU5Gd6FhkR0oCLdDW3B4dUCT824Ctd7ATkWUCsF1Vf7cTALVUJmDTCBQtS3htdW9NVpF30iVeF/5NtEstv3zC4dWyqRQE2CoJvwOmCe8U4ft9LHqo+xgGKvt6LF+dbbwXTZzHLqS+6vDDnLPDPWXp9Hyy2vsnts6xvSmWo6wzY2DAZEywxA6N2PTbzU3pyJH6iOIpYqAQC+OX2shEbHLGa8MssYj6cURWOj/B2UHZg=="

//#define PNSATAUTHSDKINFO @"ru05goShrhbZOTlMaMOflL3YUwEzoWua/nIkFeawzxhip+m/Ug8BPCeG/Un14HSohTCQb5GZ/cOzY9FpgB8aQvURsFsuczy44iiNsRgfUDP0sWMdlnDTqJZQQ4EYPXSGK+5/xh204UTmynVVXqulYRsZBC4RiwvbZL1eQrFspkeNdPJjyCyANHZkcStHT9u8F8IxmdS1giidSxeOEci43ab9uk8sm2oubwJCVmB/EYNa6bBkNKyZgyKMKM2PUr5Tei1tIAai3+o="

#define PNSATAUTHSDKINFO @"ru05goShrhbZOTlMaMOflL3YUwEzoWua/nIkFeawzxhip+m/Ug8BPCeG/Un14HSohTCQb5GZ/cOzY9FpgB8aQvURsFsuczy44iiNsRgfUDP0sWMdlnDTqJZQQ4EYPXSGK+5/xh204UTmynVVXqulYRsZBC4RiwvbZL1eQrFspkeNdPJjyCyANHZkcStHT9u8F8IxmdS1giidSxeOEci43ab9uk8sm2oubwJCVmB/EYNa6bBkNKyZgyKMKM2PUr5Tei1tIAai3+o="


#define RefreHomeDataNotification   @"RefreHomeDataNotification"

#define Makes(a,b,c,d) CGRectMake(a)*Width1, b*Height1, c * Width1, d*Height1)
#define font(num) [UIFont systemFontOfSize:num]
#define COLOR(a, b, c) [UIColor colorWithRed:(a)/255.0 green:(b)/255.0 blue:(c)/255.0 alpha:1.0]
#define COLOR2(a) [UIColor colorWithRed:(a)/255.0 green:(a)/255.0 blue:(a)/255.0 alpha:1.0]
#define ColorRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define DFRGBHex(_STR_) ([UIColor colorWithRed:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(1, 2)] UTF8String], 0, 16)] intValue] / 255.0 green:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(3, 2)] UTF8String], 0, 16)] intValue] / 255.0 blue:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(5, 2)] UTF8String], 0, 16)] intValue] / 255.0 alpha:1.0])
#define navigationColor COLOR(255,125,9)

#define WeakSelf __weak typeof(self) weakSelf = self;
#define StrongSelf __strong typeof(weakSelf) strongSelf = weakSelf;
#endif /* KcHeader_h */
