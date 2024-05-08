//
//  WKController.m
//  ExcellentCarProject
//
//  Created by XHJ on 2020/10/15.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "WKController.h"
#import <WebKit/WebKit.h>
@interface WKController ()<WKNavigationDelegate>
@property(nonatomic,strong)WKWebView *wkView;
@end

@implementation WKController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if ([self.title isEqualToString:@""] ||  self.title == nil) {
        
        self.title = @"用户协议与隐私条款";
    }
    
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.view.backgroundColor = COLOR2(240);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
//    [self postData];
    [self setUI];
    
}


-(void)postData{
    
    
    [AFN_DF POST:self.urls Parameters:nil success:^(NSDictionary *responseObject) {
        
       
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)setUI{
    
    _wkView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
    _wkView.backgroundColor = [UIColor whiteColor];
    _wkView.allowsBackForwardNavigationGestures = YES;
    _wkView.navigationDelegate = self;


    [self.view addSubview:_wkView];
    
     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urls]];
    //        [self.wkView loadHTMLString:responseObject[@"data"][@"content"] baseURL:nil];
            [self.wkView loadRequest:request];
    
//    _wkView.userInteractionEnabled = NO;

    
    
    
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
