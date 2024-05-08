//
//  TwoCarNumCell.h
//  JSKCProject
//
//  Created by XHJ on 2020/10/30.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TwoCarNumCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *lab;
@property(nonatomic,strong)NSString *str;
@property(nonatomic,strong)UIImageView *but;
-(void)setUI;
@end

NS_ASSUME_NONNULL_END
