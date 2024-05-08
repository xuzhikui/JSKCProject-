//
//  MoreView.h
//  JSKCProject
//
//  Created by XHJ on 2020/10/12.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^MoerCellBlock)(NSMutableArray *arr);
@interface MoreView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectVC;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSMutableArray *selectArray;
@property(nonatomic,strong)MoerCellBlock block;
@property(nonatomic,strong)MoerCellBlock czblock;
@property(nonatomic,strong)UIView *vc;
@end

NS_ASSUME_NONNULL_END
