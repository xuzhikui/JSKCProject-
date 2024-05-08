//
//  UITableView+DF.m
//  SecretaryProject
//
//  Created by 孟德峰 on 2019/3/11.
//  Copyright © 2019年 孟德峰. All rights reserved.
//

#import "UITableView+DF.h"

@implementation UITableView (DF)
+(UITableView *)initWithDFTablbleView:(UITableViewStyle *)style :(CGRect )cgrect :(UIViewController *)delegate :(UIColor *)tableBackColor :(NSString *)cell :(UIView *)contViews{
    
    UITableView *table = [[UITableView alloc]initWithFrame:cgrect style:UITableViewStylePlain];
//    table.delegate = delegate;
//    table.dataSource = delegate;
    
    
    return table;
}

@end
