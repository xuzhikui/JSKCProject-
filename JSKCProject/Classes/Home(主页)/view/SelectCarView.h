//
//  SelectCarView.h
//  JSKCProject
//
//  Created by XHJ on 2020/9/22.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectCarBlock)(NSDictionary *dic);
@interface SelectCarView : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)SelectCarBlock bindblock;
@property(nonatomic,strong)SelectCarBlock selectblock;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITextField *carTF;
@property(nonatomic,strong)UIImageView *backImg;
@property(nonatomic,strong)UILabel *backTitle;
@property(nonatomic,strong)UITextField *searchTF;
@property(nonatomic,strong)NSMutableArray *searArray;
@property(nonatomic,strong)NSString  *codes;
@end

NS_ASSUME_NONNULL_END
