
//
//  FeedBackController.m
//  JSKCProject
//
//  Created by XHJ on 2020/9/26.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "FeedBackController.h"
#import "SucellFeedController.h"
@interface FeedBackController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *textTF;
@property(nonatomic,strong)UILabel *tips;
@property(nonatomic,strong)PtoVC *ptovc;
@end

@implementation FeedBackController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = YES;
   

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"意见反馈";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    
}

-(void)setUI{
    
    
    [UILabel initWithDFLable:CGRectMake(20, NavaBarHeight + 30, 200, 20) :[UIFont systemFontOfSize:17*Width1] :[UIColor blackColor] :@"反馈内容" :self.view :0];
    
    
    self.textTF = [[UITextView alloc]initWithFrame:CGRectMake(20, NavaBarHeight + 65, Width - 40, 200)];
    
    self.textTF.font = [UIFont systemFontOfSize:12*Width1];
    self.textTF.layer.cornerRadius = 4;
    self.textTF.delegate = self;
    self.textTF.zw_placeHolder = @"请在此输入您的宝贵意见，感谢您的支持!";
    self.textTF.layer.borderColor = [COLOR2(204)CGColor];
    self.textTF.layer.borderWidth = 1;
    [self.view addSubview:self.textTF];
    
//    self.tips = [UILabel initWithDFLable:CGRectMake(Width - 100, 180,50, 20) :[UIFont systemFontOfSize:11*Width1] :[UIColor grayColor] :@"0/500" :self.textTF :2];
    
    
    
     [UILabel initWithDFLable:CGRectMake(20, NavaBarHeight + 290, 200, 20) :[UIFont systemFontOfSize:17*Width1] :[UIColor blackColor] :@"上传截图(最多三张)" :self.view :0];
    
    
    self.ptovc = [[PtoVC alloc]initWithFrame:CGRectMake(10, NavaBarHeight + 330, Width - 20, 100)];
    self.ptovc.vc = self;
    self.ptovc.block = ^(UIImage * _Nonnull img) {
        
    };
    [self.view addSubview:self.ptovc];
    
    
    
    
    
    
    
    
    UIButton *suppBut = [UIButton initWithFrame:CGRectMake(25, NavaBarHeight +   450, Width - 50, 45) :@"提交反馈" :16];
    suppBut.backgroundColor = [UIColor redColor];
    [self.view addSubview:suppBut];
    [suppBut addTarget:self action:@selector(suppButActrion) forControlEvents:(UIControlEventTouchUpInside)];
    suppBut.layer.cornerRadius = 4;

}


-(void)suppButActrion{
    

    
  
    
    NSDictionary *dic = @{
        @"content":self.textTF.text,
        @"phone":[UserModel shareInstance].username,
     
    };
    NSMutableArray *files = [NSMutableArray array];
    for (int i = 0; i < self.ptovc.dataArray.count; i++) {
        [files addObject:@"files"];
    }
    
    [AFN_DF POST:@"/system/feedback/add" Parameters:dic File:files ImageArr:self.ptovc.dataArray ContVC:self success:^(NSDictionary *responseObject) {
        
      
        SucellFeedController *VC = [SucellFeedController new];
        [self.navigationController pushViewController:VC animated:YES];
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}


- (void)textViewDidChange:(UITextView *)textView
{
   
    if (textView.text.length <= 500) {
        self.tips.text  = [NSString stringWithFormat:@"%ld/500",self.textTF.text.length];
    }else{
        
        [self.view addSubview:[Toast makeText:@"您最多输入500字反馈内容"]];
        
    }
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

        if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
                [self.view endEditing: YES];
//在这里做你响应return键的代码

                return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行

}

            return YES;

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
