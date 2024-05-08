//
//  CarNumView.h
//  JSKCProject
//
//  Created by XHJ on 2020/10/29.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarNumView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UIView *backVC;
@property(nonatomic,strong)UIButton *but1;
@property(nonatomic,strong)UIButton *but2;
@property(nonatomic,strong)UIButton *but3;
@property(nonatomic,strong)UICollectionView *collectVC;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSString *str;
@property(nonatomic,strong)NSString *code;
@end

NS_ASSUME_NONNULL_END
