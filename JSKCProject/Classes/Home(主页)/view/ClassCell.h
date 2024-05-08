//
//  ClassCell.h
//  ExcellentCarProject
//
//  Created by 孟德峰 on 2020/9/23.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *titles;
@property(nonatomic,strong)UIImageView *imgs;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)UIImageView *codeimgs;
-(void)setUI;
@end

NS_ASSUME_NONNULL_END
