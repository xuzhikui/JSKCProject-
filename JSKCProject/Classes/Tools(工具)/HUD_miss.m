//
//  HUD_miss.m
//  YbtPrject
//
//  Created by aaa on 2018/7/3.
//  Copyright © 2018年 mdfs. All rights reserved.
//

#import "HUD_miss.h"

@implementation HUD_miss

static HUD_miss  *_instance = nil;
+(instancetype) shareInstance {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
