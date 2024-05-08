//
//  ScreenView.m
//  JSKCProject
//
//  Created by XHJ on 2020/9/25.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "ScreenView.h"

@implementation ScreenView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
           //设置item 的行间距的 (如果不设置,默认值是10)
           flowLayout.minimumInteritemSpacing = 1*Height1;
           //设置item 的列间距的
           flowLayout.minimumLineSpacing = 10;
           //设置item的大小
          CGFloat wid = Width/4 *3 - 20;
           flowLayout.itemSize = CGSizeMake((wid - 40)/3, 25);
           //设置滚动方向
           flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
           
           //设置UICollectionView 距离屏幕 上 下 左 右 的一个距离
           flowLayout.sectionInset = UIEdgeInsetsMake(0*Height1, 10*Height1, 10*Width1, 10*Width1);
           _collectVC = [[UICollectionView alloc]initWithFrame:CGRectMake(Width/4,135, Width/4 * 3  - 20,70) collectionViewLayout:flowLayout];
           //设置collectionView的两个代理方法
          _collectVC.dataSource = self;
          _collectVC.delegate = self;
           
          _collectVC.backgroundColor = [UIColor whiteColor];
           [self addSubview:_collectVC];
           //先注册collectionViewcell
           [_collectVC registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
          
        
        
        
    }
    return self;
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return 1;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
     
    cell.backgroundColor = [UIColor grayColor];
    
    return cell;
}


@end
