//
//  AddCarNewViewController.h
//  JSKCProject
//
//  Created by 王宾 on 2022/3/30.
//  Copyright © 2022 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddCarNewViewController : UIViewController
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)NSDictionary *codedic;
@property(nonatomic,strong)NSString *addType;
@property(nonatomic,strong)AddCarBlock block;
@property(nonatomic,assign)NSInteger truckId;
@end

NS_ASSUME_NONNULL_END
