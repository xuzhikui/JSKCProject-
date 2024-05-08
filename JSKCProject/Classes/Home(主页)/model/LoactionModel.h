//
//  LoactionModel.h
//  LeagueMatchProject
//
//  Created by 孟德峰 on 2019/2/28.
//  Copyright © 2019年 孟德峰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoactionModel : NSObject
@property(nonatomic,strong)NSString *lo;
@property(nonatomic,strong)NSString *lat;
@property(nonatomic,strong)NSString *city;
+(instancetype) shareInstance;
@end

NS_ASSUME_NONNULL_END
