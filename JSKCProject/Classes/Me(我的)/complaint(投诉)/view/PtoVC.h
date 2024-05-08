//
//  PtoVC.h
//  ExcellentCarProject
//
//  Created by 孟德峰 on 2020/9/13.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PtoBlock)(UIImage *img);
@interface PtoVC : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)UICollectionView *collectVC;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,strong)UIViewController *vc;
@property(nonatomic,strong)PtoBlock block;
@property(nonatomic,strong)NSString *type;

@end

NS_ASSUME_NONNULL_END
