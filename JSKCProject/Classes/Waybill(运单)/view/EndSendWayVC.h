//
//  EndSendWayVC.h
//  JSKCProject
//
//  Created by XHJ on 2020/10/24.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#define DefaultLocationTimeout 10
#define DefaultReGeocodeTimeout 5
NS_ASSUME_NONNULL_BEGIN

typedef void(^EndSendBlock)(NSDictionary *dic);

@interface EndSendWayVC : UIView<UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,THDatePickerViewDelegate,AMapLocationManagerDelegate>
@property(nonatomic,strong)UIButton *selectTimeBut;
@property(nonatomic,strong)UITextField *numTF;
@property(nonatomic,strong)UIButton *contImageBut;
@property(nonatomic,strong)UIButton *selectBut;
@property(nonatomic,strong)UIView *backVC;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIViewController *vc;
@property(nonatomic,strong)UIImage *img;
@property(nonatomic,strong)THDatePickerView *dateView;
@property(nonatomic,strong)NSString *strTime;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,assign)BOOL code;
@property(nonatomic,strong)UIButton *colseBut;
@property(nonatomic,strong)EndSendBlock block;
@property(nonatomic,strong)NSString *canlCode;
@property(nonatomic,strong)UILabel *unitLab;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;
@property(nonatomic,strong)NSString *lont;
@end

NS_ASSUME_NONNULL_END
