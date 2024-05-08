//
//  HomeClassView.h
//  ExcellentCarProject
//
//  Created by 孟德峰 on 2020/9/23.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeClassView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectVC;
@property(nonatomic,strong)NSArray *ImgArry;
@property(nonatomic,strong)NSString *code;

- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
