//
//  PtoVC.m
//  ExcellentCarProject
//
//  Created by 孟德峰 on 2020/9/13.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "PtoVC.h"

@implementation PtoVC

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
       
    }
    return self;
}

-(void)layoutSubviews{
    [self setUI];
    
}

-(void)setUI{
    
    if (self.dataArray.count == 0) {
         self.dataArray = [NSMutableArray array];
    }
   
    
    UICollectionViewFlowLayout  *flowLayout = [[UICollectionViewFlowLayout alloc]init];
          //设置item 的行间距的 (如果不设置,默认值是10)
          flowLayout.minimumInteritemSpacing = 10;
          //设置item 的列间距的
          flowLayout.minimumLineSpacing = 15;
          //设置item的大小
        
          //设置滚动方向
    
    if ([self.type isEqualToString:@"1"]) {
        
        flowLayout.itemSize = CGSizeMake((Width - 80) /5 ,(Width - 80) /5);
        
    }
    
          flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
          
          //设置UICollectionView 距离屏幕 上 下 左 右 的一个距离
          flowLayout.sectionInset = UIEdgeInsetsMake(10*Height1, 10*Height1, 10*Width1, 10*Width1);
          
    
          _collectVC = [[UICollectionView alloc]initWithFrame:CGRectMake(0,  0, Width, 100) collectionViewLayout:flowLayout];
          //设置collectionView的两个代理方法
          _collectVC.dataSource = self;
          _collectVC.delegate = self;
          _collectVC.scrollEnabled =NO;
          _collectVC.backgroundColor = [UIColor whiteColor];
          [self addSubview:_collectVC];
      
          //先注册collectionViewcell
          [_collectVC registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if ([self.type isEqualToString:@"1"]) {
        
        if (self.dataArray.count < 5) {
            return self.dataArray.count + 1;
        }else{
            
            return self.dataArray.count;
        }
        
    }else{
        
        if (self.dataArray.count < 3) {
            return self.dataArray.count + 1;
        }else{
            
            return self.dataArray.count;
        }
        
    }
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    for (UIView *vc in cell.contentView.subviews) {
        
        [vc removeFromSuperview];
    }
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    img.userInteractionEnabled = YES;
    if (self.dataArray.count > indexPath.row) {
        
        img.image = self.dataArray[indexPath.row];
        
        UIButton *closeBut = [UIButton initWithFrame:CGRectMake(cell.frame.size.width - 20, 0, 20,20) :@"sss关闭"];
        closeBut.tag =  1000 + indexPath.row;
//        closeBut.backgroundColor = [UIColor whiteColor];
        [closeBut addTarget:self action:@selector(closeButAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [img addSubview:closeBut];
        
//        [cell bringSubviewToFront:closeBut];
        
    }else{
        
        if ([self.type isEqualToString:@"1"]) {
            
            img.image = [UIImage imageNamed:@"添加照片"];
        }else{
            
            img.image = [UIImage imageNamed:@"上传凭证"];
            
        }
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:img];
    return cell;
    
    
}

-(void)closeButAction:(UIButton *)but{
    
    [self.dataArray removeObjectAtIndex:but.tag - 1000];
    
    [self.collectVC reloadData];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
        
    if (self.dataArray.count == indexPath.row) {
         [self onTapGR];
    }
   
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
    
    [self.dataArray addObject:image];
    self.block(image);
    [self.collectVC reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//协议中的方法，当用户取消时被调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}




- (UIImage *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size
{
    UIImage *OriginalImage = image;
    
    // 执行这句代码之后会有一个范围 例如500m 会是 100m～500k
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.5f;
    
    // 执行while循环 如果第一次压缩不会小雨100k 那么减小尺寸在重新开始压缩
    while (dataKBytes > size)
    {
        while (dataKBytes > size && maxQuality > 0.1f)
        {
            maxQuality = maxQuality - 0.1f;
            data = UIImageJPEGRepresentation(image, maxQuality);
            dataKBytes = data.length / 1000.0;
            if(dataKBytes <= size )
            {
                
                return [[UIImage alloc]initWithData:data];
            }
        }
        OriginalImage =[self compressOriginalImage:OriginalImage toWidth:OriginalImage.size.width * 0.8];
        image = OriginalImage;
        data = UIImageJPEGRepresentation(image, 1.0);
        dataKBytes = data.length / 1000.0;
        maxQuality = 0.5f;
    }
    return [[UIImage alloc]initWithData:data];
}

-(UIImage *)compressOriginalImage:(UIImage *)image toWidth:(CGFloat)targetWidth
{
    CGSize imageSize = image.size;
    CGFloat Originalwidth = imageSize.width;
    CGFloat Originalheight = imageSize.height;
    CGFloat targetHeight = Originalheight / Originalwidth * targetWidth;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [image drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
