#ifndef LiveHeader_h
#define LiveHeader_h

#import "Livedefined.h"

#define Zero                        0

#define IOS_VERSION_LOWER_THAN_8 (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1)

#define SCREENWIDTH (IOS_VERSION_LOWER_THAN_8 ? (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height) : [[UIScreen mainScreen] bounds].size.width)

#define SCREENHEIGHT (IOS_VERSION_LOWER_THAN_8 ? (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width) : [[UIScreen mainScreen] bounds].size.height)

#define  isLandscape  ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight)

#define NavBarPadding ((isLandscape?SCREENWIDTH>=780:SCREENHEIGHT>=780)?24:0)
#define HomeBarPadding ((isLandscape?SCREENWIDTH>=780:SCREENHEIGHT>=780)?34:0)

#define HSBaseColor [UIColor colorWithRed:106/255.0 green:128/255.0 blue:250/255.0 alpha:1.0]
#define HSRedColor [UIColor colorWithRed:1.0 green:0 blue:0 alpha:1.0]
#define HSYellowColor [UIColor colorWithRed:1.0 green:1.0 blue:0 alpha:1.0]
#define HSGreenColor [UIColor colorWithRed:69/255.0 green:241/255.0 blue:254/255.0 alpha:1.0]
#define HSCyanColor [UIColor colorWithRed:0 green:1.0 blue:1.0 alpha:1.0]
#define HSBlueColor [UIColor colorWithRed:20/255.0 green:36/255.0 blue:135/255.0 alpha:1.0]
#define HSMagentaColor [UIColor colorWithRed:1.0 green:0 blue:1.0 alpha:1.0]

//产品
#define LIVEDETECT_BGCOLOR [UIColor colorWithRed:(2/ 255.0) green:(105 / 255.0) blue:(134 / 255.0) alpha:1]
#define NAVIGATION_COLOR [UIColor colorWithRed:(0/ 255.0) green:(133 / 255.0) blue:(170 / 255.0) alpha:1]
#define PROGRESS_NORMALCOLOR [UIColor colorWithRed:0 green:75/255.0 blue:94/255.0 alpha:1]

#define COUNTDOWN           @"audio_imitateAnimation.mp3"      //请模仿屏幕中的动画操作
#define GOODNEXT            @"audio_okNext.mp3"                //好的，下一个
#define NODHEAD             @"audio_nodheadSlowly.mp3"         //请缓慢点头
#define SHAKEHEAD           @"audio_shakeheadSlowly.mp3"       //请缓慢摇头
#define KEEPSTILL           @"audio_watchScreen.mp3"           //请注视屏幕
#define OPENMOUTH           @"audio_openMouth.mp3"             //请张下嘴
#define BLINKEYE            @"audio_blinkEyes.mp3"             //请眨下眼
#define MOVEPHONE           @"audio_movePhone.mp3"             //请上下移动手机
#define FACEGUIDE           @"audio_placeFaceInPromptView.mp3" //请将脸部置于提示框内
#define THROUGHDETECT       @"audio_detectSucceed.mp3"         //检测通过
#define NOTTHROUGHDETECT    @"audio_detectFailed.mp3"          //未检测通过


// IVLiveSdk 与 IVRecordSdk 定义的错误码
/**
 * 无错误
 */
#define IV_ERROR_NONE       0
/**
 * 非活体失败
 */
#define IV_ERROR_NOTLIVE    1
/**
 * 初始化失败
 */
#define IV_ERROR_INIT       2
/**
 * 相机打开失败
 */
#define IV_ERROR_CAMERA     3
/**
 * 超时失败
 */
#define IV_ERROR_TIMEOUT    4
/**
 * 无人脸失败
 */
#define IV_ERROR_NOFACE     5
/**
 * 多人脸失败
 */
#define IV_ERROR_MULTIFACE  6
/**
 *  连续性失败
 */
#define IV_ERROR_CONTINUE   7
/**
 * 未采集到合格的活体照片
 */
#define IV_ERROR_PICTURE    8
/**
 *  视频录制失败
 */
#define IV_ERROR_VIDEO      9
/**
 *  检测中断退出
 */
#define IV_ERROR_BREAK     10
/**
 *  传参错误失败
 */
#define IV_ERROR_PARAM     11

#endif /* LiveHeader_h */
