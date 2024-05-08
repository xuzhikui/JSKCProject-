//
//  JurisdictionController.m
//  JSKCProject
//
//  Created by XHJ on 2020/11/2.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "JurisdictionController.h"
#import "JurisdCell.h"
#import "MainController.h"
#import "PhoneLoginController.h"
#import "loginController.h"
@interface JurisdictionController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)UITextView *textView;
@end

@implementation JurisdictionController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.tabBarController.tabBar.hidden = YES;
   

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.dataArray = @[
        @{@"tit":@"摄像头(相机)权限",@"img":@"权限牌照",@"det":@"如您通过拍摄添加身份证、驾驶证、行驶证等信息时，我们会使用该权限"},
                @{@"tit":@"位置信息",@"img":@"权限位置",@"det":@"如您使用找货源功能或使用导航功能服务时，我们将使用该权限"},
                @{@"tit":@"相册权限",@"img":@"权限照片",@"det":@"如您通过手机相册添加身份证、驾驶证、行驶证等信息时，我们会使用该权限"},
                @{@"tit":@"消息通知",@"img":@"权限消息",@"det":@"我们会随时为您提供货源、运单等资源同步服务"},
    ];
    
    [self setUI];
    
}

-(void)setUI{
    
   
    [UILabel initWithDFLable:CGRectMake(20, 50, Width - 60, 30) :[UIFont boldSystemFontOfSize:26*Width1] :[UIColor blackColor] :@"欢迎使用" :self.view :0];
    
    
    UILabel *onetipLab =  [UILabel initWithDFLable:CGRectMake(20, 90, Width/2 +20, 40) :[UIFont systemFontOfSize:12*Width1] :COLOR2(119) :@"为了保证您能正常使用相关功能需要向您申请一下权限" :self.view :0];
    onetipLab.numberOfLines = 2;
    
    
     self.table = [[UITableView alloc]initWithFrame:CGRectMake(20, 140 , Width - 40, 360) style:(UITableViewStylePlain)];
     self.table.delegate = self;
     self.table.dataSource = self;
     self.table.backgroundColor = [UIColor whiteColor];
     [self.view addSubview:self.table];
     [self.table registerClass:[JurisdCell class] forCellReuseIdentifier:@"cell"];
    
    
    
    
    UILabel *twotipLab =  [UILabel initWithDFLable:CGRectMake(20, 500, Width - 40, 40) :[UIFont systemFontOfSize:12*Width1] :COLOR2(119) :@"您可以在提示授权时拒绝，也可以在系统中关闭授权，拒绝或关闭授权可能影响到部分功能的正常使用。" :self.view :0];
       twotipLab.numberOfLines = 2;
    
    
    
    
    
    
    
    
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(20,Height - 85 , Width  - 40, 25)];
       _textView.font = [UIFont systemFontOfSize:8*Width1];
//        _textView.textColor = [UIColor yellowColor];
       _textView.text = @"使用APP前请仔细阅读并同意《用户使用协议》、《隐私条款》。";
       [self.view addSubview:_textView];


       
       [self setfwb:_textView :31 :12];
    
    UIButton *senBut = [UIButton initWithFrame:CGRectMake(20, Height - 55, Width - 40, 40) :@"同意并继续使用APP" :15*Width1];
    senBut.layer.cornerRadius = 4;
    [senBut addTarget:self action:@selector(senButAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    senBut.backgroundColor = [UIColor redColor];
    [self.view addSubview:senBut];
       
    
}

-(void)senButAction{

//    if ([TXCommonUtils simSupportedIsOK] && [TXCommonUtils checkDeviceCellularDataEnable]) {
//        LoginController *logVC =  [LoginController new];
//        [self.navigationController pushViewController:logVC animated:YES];
//    }else{
//        PhoneLoginController *logVC =  [PhoneLoginController new];
//        logVC.code = @"1";
//        [self.navigationController pushViewController:logVC animated:YES];
//    }
    PhoneLoginController *logVC =  [PhoneLoginController new];
    logVC.code = @"1";
    [self.navigationController pushViewController:logVC animated:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
          
    JurisdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor =[UIColor whiteColor];
    cell.layer.cornerRadius = 4;
    cell.layer.borderColor = [COLOR2(221)CGColor];
    cell.dic = self.dataArray[indexPath.row];
    cell.layer.borderWidth = 1;
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 90;
}


-(void)setfwb:(UITextView *)button :(NSInteger)start :(NSInteger)over{
    
 

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"使用APP前请仔细阅读并同意《用户使用协议》、《隐私条款》。"];

    [attributedString addAttribute:NSLinkAttributeName

    value:@"user"

    range:[[attributedString string] rangeOfString:@"《用户使用协议》"]];

    [attributedString addAttribute:NSLinkAttributeName

    value:@"yinsifuwu"

    range:[[attributedString string] rangeOfString:@"《隐私条款》"]];


    _textView.attributedText = attributedString;

    _textView.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor redColor],

//    NSUnderlineColorAttributeName: [UIColor lightGrayColor],

//    NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)
                                     
    };

    _textView.delegate = self;

     //必须禁止输入，否则点击将弹出输入键盘
    _textView.editable = NO;
    _textView.textColor = COLOR2(153);
    _textView.font = [UIFont systemFontOfSize:12*Width1];
    _textView.scrollEnabled = NO;

   

}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{

     NSString *urlStr =[NSString stringWithFormat:@"%@",URL];
if ([urlStr isEqualToString:@"user"]) {
//用户使用

    WKController *wkVC = [WKController new];
    wkVC.urls = @"https://kcwl-pro-oss.jskc56.com/jskcwl_file/jsyx_file/agreement.html";
    [self.navigationController pushViewController:wkVC animated:YES];
    
return NO;

} else if ([urlStr isEqualToString:@"yinsifuwu"]) {

///隐私条款
    WKController *wkVC = [WKController new];
    wkVC.urls = @"https://kcwl-pro-oss.jskc56.com/jskcwl_file/jsyx_file/agreement.html";
    [self.navigationController pushViewController:wkVC animated:YES];

return NO;

}

return YES;

}




@end
