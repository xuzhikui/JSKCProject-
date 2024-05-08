//
//  LoactionModel.m
//  LeagueMatchProject
//
//  Created by 孟德峰 on 2019/2/28.
//  Copyright © 2019年 孟德峰. All rights reserved.
//

#import "LoactionModel.h"

@implementation LoactionModel
static LoactionModel  *_instance = nil;
+(instancetype) shareInstance {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance ;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
