//
//  DF_SHopList.h
//  YbtPrject
//
//  Created by aaa on 2018/6/24.
//  Copyright © 2018年 mdfs. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DF_PickBlock)(NSInteger codes);
@interface DF_SHopList : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)NSMutableArray *proTimeList;
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,strong)DF_PickBlock block;
@property(nonatomic,strong)UIView *backVC;
@end
