//
//  ReceOrderView.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/17.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "ReceOrderView.h"
#import "OrSuccessController.h"
@implementation ReceOrderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        [self setUI];
    }
    return self;
}

-(void)layoutSubviews{
    
    
    if (self.backVC == nil) {
        [self setUI];
    }
    
   
    
}


-(void)setUI{
//
    self.backVC = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
    self.backVC.backgroundColor = [UIColor blackColor];
    self.backVC.alpha = 0.5;
    UITapGestureRecognizer *TapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapGR)];
         self.backVC.userInteractionEnabled = YES;
         [ self.backVC addGestureRecognizer:TapGR];
    
    [self addSubview:self.backVC];
    
    UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake(66, 150, Width - 132, 300)];
    img.image = [UIImage imageNamed:@"抢单背景"];
    [self addSubview:img];
    img.userInteractionEnabled = YES;
    
    UIButton *closeBut = [UIButton initWithFrame:CGRectMake(CGRectGetMaxX(img.frame) - 18, 205, 20, 20) :@"关闭"];
    [closeBut addTarget:self action:@selector(closeAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:closeBut];
    
   [UILabel initWithDFLable:CGRectMake(0,120, Width - 132, 30) :[UIFont systemFontOfSize:20*Width1] :COLOR2(51) :@"是否立即抢单" :img :1];
    
    
    UILabel *tips =  [UILabel initWithDFLable:CGRectMake(20,160, Width - 162, 40) :[UIFont systemFontOfSize:13*Width1] :COLOR2(153) :@"接单成功后，请按指定时间发货否则将影响您的信用!" :img :1];
        tips.numberOfLines = 0;
    
    
    
    UIButton *endBut = [UIButton initWithFrame:CGRectMake(24, 220,img.frame.size.width - 48, 38) :@"确定" :17*Width1];
    endBut.backgroundColor = [UIColor redColor];
    endBut.layer.cornerRadius = 4;
    [endBut addTarget:self action:@selector(endAction) forControlEvents:(UIControlEventTouchUpInside)];
    endBut.userInteractionEnabled = YES;
  
    [img addSubview:endBut];
    self.endBut = endBut;

    
     UIButton *selectBut = [UIButton initWithFrame:CGRectMake(24, 265,20, 20) :@"没选中"];
    [selectBut setImage:[UIImage imageNamed:@"确定-1"] forState:(UIControlStateSelected)];
    selectBut.selected = YES;
    [selectBut addTarget:self action:@selector(selectAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [img addSubview:selectBut];
    self.sendBut = selectBut;
            _textView = [[UITextView alloc] initWithFrame:CGRectMake(45, 260,img.frame.size.width - 48, 30)];
            _textView.font = [UIFont systemFontOfSize:12*Width1];
        _textView.textColor = COLOR2(153);
            _textView.text = @"我已阅读并同意签署《司机承运合同》";
            _textView.textAlignment = 1;
            _textView.delegate = self;
            [img addSubview:_textView];
            [self setfwb:_textView :0:0];
    
}


-(void)selectAction:(UIButton *)send{
    
    if (send.isSelected) {
        send.selected = NO;
        self.endBut.backgroundColor = [UIColor grayColor];
        self.endBut.userInteractionEnabled = NO;
    }else{
        send.selected = YES;
         self.endBut.backgroundColor = [UIColor redColor];
        self.endBut.userInteractionEnabled = YES;
    }
 
}

-(void)endAction{
 

    if (self.sendBut.isSelected == NO) {

      return  [[AFN_DF topViewController].view addSubview:[Toast makeText:@"请选阅读同意协议"]];
    }

        NSDictionary *dic = @{
//        @"driverId":self.dic[@"driverId"],
        @"gsId":self.gsId,
//        @"truckId":self.dic[@"truckId"],

    };
WeakSelf
    [AFN_DF POST:@"/tsmanage/goodssource/robOrder" Parameters:dic success:^(NSDictionary *responseObject) {
        [[AFN_DF topViewController].navigationController popToRootViewControllerAnimated:YES];
        [[AFN_DF topViewController].navigationController.tabBarController setSelectedIndex:1];
        [NSNotificationCenter.defaultCenter postNotificationName:@"EndSendWayNotification" object:nil];
        [weakSelf closeAction];

    } failure:^(NSError *error) {

    }];

    
    
    
    
    
    

}

-(void)setfwb:(UITextView *)button :(NSInteger)start :(NSInteger)over{
    
    NSInteger font = 12*Width1;

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并同意签署《司机承运合同》"];

    [attributedString addAttribute:NSLinkAttributeName
    value:@"yonghu"
    range:[[attributedString string] rangeOfString:@"《司机承运合同》"]];
    
 
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, attributedString.length)];

    _textView.attributedText = attributedString;

    _textView.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor redColor],

    NSUnderlineColorAttributeName: [UIColor lightGrayColor],

    NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};

    _textView.delegate = self;

     //必须禁止输入，否则点击将弹出输入键盘
    _textView.editable = NO;
     
    _textView.scrollEnabled = NO;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{

     NSString *urlStr =[NSString stringWithFormat:@"%@",URL];
    if ([urlStr isEqualToString:@"yonghu"]) {
///用户协议
     
            WKController *wkVC = [WKController new];
            wkVC.urls = self.data[@"contractUrl"];
            wkVC.title = @"司机承运合同";
        if ([[AFN_DF topViewController].navigationController.topViewController isEqual:[AFN_DF topViewController].navigationController.viewControllers.firstObject]) {
            [self closeAction];
        }
        [[AFN_DF topViewController].navigationController pushViewController:wkVC animated:YES];

            return NO;

}

return YES;

}

-(void)closeAction{
    [[AFN_DF topViewController].navigationController setNavigationBarHidden:NO animated:YES];
    [self removeFromSuperview];
    
}


-(void)onTapGR{
      [[AFN_DF topViewController].navigationController setNavigationBarHidden:NO animated:YES];
      [self removeFromSuperview];
}

@end
