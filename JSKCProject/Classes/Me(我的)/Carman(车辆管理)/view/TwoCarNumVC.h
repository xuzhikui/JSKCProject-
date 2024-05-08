//
//  TwoCarNumVC.h
//  JSKCProject
//
//  Created by XHJ on 2020/10/30.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^TwoCarNumVCBlock)(NSDictionary *code);
@interface TwoCarNumVC : UIView
<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UIView *backVC;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)UICollectionView *collectVC;
@property(nonatomic,strong)UICollectionView *numVC;
@property(nonatomic,strong)NSString *str;
@property(nonatomic,strong)NSString *carType;
@property(nonatomic,strong)NSMutableArray *strArray;
@property(nonatomic,strong)NSString *butCode;
@property(nonatomic,strong)UIColor *color;
@property(nonatomic,assign)NSInteger num;
@property(nonatomic,strong)TwoCarNumVCBlock block;
@end

NS_ASSUME_NONNULL_END
