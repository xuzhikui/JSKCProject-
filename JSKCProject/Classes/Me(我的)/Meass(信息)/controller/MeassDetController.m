//
//  MeassDetController.m
//  JSKCProject
//
//  Created by 孟德峰 on 2021/2/3.
//  Copyright © 2021 孟德峰. All rights reserved.
//

#import "MeassDetController.h"

@interface MeassDetController ()
@property (nonatomic, strong) UITextView *text;
@end

@implementation MeassDetController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"消息详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self postData];
}

-(void)setUI{
    
    
    [UILabel initWithDFLable:CGRectMake(20, NavaBarHeight + 20, Width, 20) :[UIFont systemFontOfSize:18*Width1] :[UIColor blackColor] :self.dic[@"title"] :self.view :0];
    
    [UILabel initWithDFLable:CGRectMake(20, NavaBarHeight + 45, Width, 20) :[UIFont systemFontOfSize:12*Width1] :COLOR2(153) :self.dic[@"createTime"] :self.view :0];

    
    _text = [[UITextView alloc]initWithFrame:CGRectMake(20, NavaBarHeight + 80, Width-40, Height - NavaBarHeight - 100)];
    self.text.text = self.dic[@"summary"];
    self.text.font = [UIFont systemFontOfSize:12*Width1];
    self.text.textColor = COLOR2(51);
    [self.view addSubview:self.text];

    
}


-(void)postData{
    WeakSelf
    [AFN_DF POST:@"/system/mess/getMessDetail" Parameters:@{@"id":self.dic[@"id"]} success:^(NSDictionary *responseObject) {
        weakSelf.text.text = responseObject[@"data"][@"content"];
    } failure:^(NSError *error) {
        
    }];

    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
