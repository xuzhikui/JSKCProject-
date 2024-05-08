//
//  ImageVC.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/27.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "ImageVC.h"

@implementation ImageVC

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.code = @"1";
        [self setUI];
    }
    return self;
}

-(void)layoutSubviews{
    
    
    if (![self.code isEqualToString:@"1"]) {
        return;
    }
  
    
    self.imgBut.image = [UIImage imageNamed:self.imgs];
    
    if ([self.typess isEqualToString:@"1"]) {
         [self.imgBut sd_setImageWithURL:[NSURL URLWithString:self.url] placeholderImage:[UIImage imageNamed:self.imgs]];
                    self.closeBut.hidden = YES;
                   self.imgBut.userInteractionEnabled = YES;
                   self.closeBut.userInteractionEnabled = YES;
                   self.ptoBut.hidden = YES;
    }else{
        
        if (self.url && ![self.url isEqualToString:@""]) {

             [self.imgBut sd_setImageWithURL:[NSURL URLWithString:self.url] placeholderImage:[UIImage imageNamed:self.imgs]];
             self.closeBut.hidden = NO;
             self.imgBut.userInteractionEnabled = YES;
             self.closeBut.userInteractionEnabled = YES;
             self.ptoBut.hidden = YES;
        
         }
        
    }
 
    self.code = @"2";
    
    
}

-(void)setUI{

    
    
    self.imgBut = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
       [self addSubview:self.imgBut];
    
    self.ptoBut =  [UIButton initWithFrame:CGRectMake(self.frame.size.width/2 - 25, self.frame.size.height/2 - 25,50,  50) :@"相机"];
       [self.ptoBut addTarget:self action:@selector(imgButAction) forControlEvents:(UIControlEventTouchUpInside)];
       [self addSubview:self.ptoBut];
    
    self.closeBut = [UIButton initWithFrame:CGRectMake(self.frame.size.width - 20, 0, 20, 20) :@"关闭"];
    [self.closeBut addTarget:self action:@selector(closeAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.imgBut addSubview:self.closeBut];
    self.closeBut.hidden = YES;
    

    
}

-(void)closeAction{
    
    
    self.imgBut.image = [UIImage imageNamed:self.imgs];
    self.ptoBut.hidden = NO;
    self.closeBut.hidden = YES;
    self.removerblock([UIImage new]);
    
}

-(void)imgButAction{
    
    
    [self onTapGR];
}


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
            [_vc presentViewController:picker animated:YES completion:nil];
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
        [_vc presentViewController:picker animated:YES completion:nil];
    }
}
#pragma mark - 相册delegate
//协议中的方法，当用户选择某个图片时被调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    ///可编辑为 UIImagePickerControllerEditedImage
    
    self.imgBut.image = image;
    self.block(image);
    self.closeBut.hidden = NO;
    self.imgBut.userInteractionEnabled = YES;
    self.ptoBut.hidden = YES;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//协议中的方法，当用户取消时被调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
