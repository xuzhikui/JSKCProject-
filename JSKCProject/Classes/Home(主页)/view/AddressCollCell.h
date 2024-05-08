//
//  AddressCollCell.h
//  JSKCProject
//
//  Created by XHJ on 2020/9/21.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressCollCell : UICollectionViewCell
-(void)initUIs;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)NSString *tit;
@property(nonatomic,strong)UIImageView *imgVC;
@end

NS_ASSUME_NONNULL_END
