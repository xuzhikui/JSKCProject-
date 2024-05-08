//
//  ImageVC.h
//  JSKCProject
//
//  Created by XHJ on 2020/10/27.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ImageBlock)(UIImage *img);
@interface ImageVC : UIView<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)UIImageView *imgBut;
@property(nonatomic,strong)UIButton *closeBut;
@property(nonatomic,strong)NSString *imgs;
@property(nonatomic,strong)UIButton *ptoBut;
@property(nonatomic,strong)UIViewController *vc;
@property(nonatomic,strong)ImageBlock block;
@property(nonatomic,strong)ImageBlock removerblock;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *typess;
@property(nonatomic,strong)NSString *code;
@end

NS_ASSUME_NONNULL_END
