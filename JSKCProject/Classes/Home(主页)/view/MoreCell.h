//
//  MoreCell.h
//  JSKCProject
//
//  Created by XHJ on 2020/10/12.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoreCell : UICollectionViewCell
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)UILabel *labs;
@property(nonatomic,strong)NSString *code;
-(void)setUI;
@end

NS_ASSUME_NONNULL_END
