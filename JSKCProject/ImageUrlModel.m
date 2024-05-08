//
//  ImageUrlModel.m
//  JSKCProject
//
//  Created by 孟德峰 on 2021/4/30.
//  Copyright © 2021 孟德峰. All rights reserved.
//

#import "ImageUrlModel.h"

@implementation ImageUrlModel
static  ImageUrlModel *_instance = nil;
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
