//
//  AddressVC.h
//  JSKCProject
//
//  Created by XHJ on 2020/9/21.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^AddressBlock)(NSArray *arr);

@interface AddressVC : UIView<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITextField *addresTF;
@property(nonatomic,strong)UICollectionView *collectVC;
@property(nonatomic,strong)NSArray *listArray;
@property(nonatomic,strong)NSMutableArray *searArray;
@property(nonatomic,strong)NSMutableArray *selectCollArray;
@property(nonatomic,strong)AddressBlock block;
@property(nonatomic,strong)AddressBlock czblock;
@property(nonatomic,strong)UIView *vc;
@property(nonatomic,strong)UILabel *numLab;
@property(nonatomic,strong)NSDictionary *cityDic;
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)UILabel *addressLab;
@end

NS_ASSUME_NONNULL_END
