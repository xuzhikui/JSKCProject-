//
//  UserModel.m
//  LssProject
//
//  Created by lss on 2020/5/18.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

static  UserModel *_instance = nil;
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
