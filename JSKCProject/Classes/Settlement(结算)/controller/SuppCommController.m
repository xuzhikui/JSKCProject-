//
//  SuppCommController.m
//  JSKCProject
//
//  Created by 孟德峰 on 2020/12/26.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "SuppCommController.h"
#import "LHRatingView.h"
#import "EndCommController.h"
@interface SuppCommController ()<ratingViewDelegate,UITextViewDelegate>
@property(nonatomic,strong)UILabel *commLab;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)UITextView *textVC;
@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,strong)UILabel *numlab;
@property(nonatomic,strong)PtoVC *ptovc;
@end

@implementation SuppCommController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.index = 6;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"发布评价";
    
    [self postData];
//    [self setUI];
    
}


-(void)postData{
    
    
    [AFN_DF POST:@"/tsmanage/waybillsettle/getEvaluatedById" Parameters:@{@"waybillId":self.dic[@"waybillId"]} success:^(NSDictionary *responseObject) {
        
        
        self.data = responseObject[@"data"];
        [self setUI];
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

-(void)setUI{
    
    UIView *numVC =  [[UIView alloc]initWithFrame:CGRectMake(10,  NavaBarHeight  + 10, Width - 20, 40)];
     numVC.backgroundColor = [UIColor whiteColor];
     [self.view addSubview:numVC];
     
//     UIImageView *timeImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39, Width - 20, 1)];
//      timeImg.image = [UIImage imageNamed:@"线 拷贝"];
//     [numVC addSubview:timeImg];
     

     UILabel *timeLab = [UILabel initWithDFLable:CGRectMake(10,10,Width - 50, 20) :[UIFont systemFontOfSize:15*Width1] :[UIColor redColor] :[NSString stringWithFormat:@"订单号: %@",self.dic[@"waybillId"]] :numVC :0];
            [self setfwb:timeLab];
    
    
    
    
    UIView *addVC = [[UIView alloc]initWithFrame:CGRectMake(0, NavaBarHeight + 50,Width, 70)];
    addVC.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:addVC];
    
    UIImageView *oneImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 15, 15)];
    oneImg.image = [UIImage imageNamed:@"装"];
    [addVC addSubview:oneImg];
      
    [UILabel initWithDFLable:CGRectMake(40, 0, 120, 15) :[UIFont systemFontOfSize:13*Width1] :[UIColor blackColor] :[NSString stringWithFormat:@"%@-%@",self.data[@"loadCity"],self.data[@"loadArea"]] :addVC :0];
    
    
    UIImageView *xImg = [[UIImageView alloc]initWithFrame:CGRectMake(160, 10, 80, 5)];
    xImg.image = [UIImage imageNamed:@"箭头"];
    [addVC addSubview:xImg];
    
    [UILabel initWithDFLable:CGRectMake(160,0, 80, 10) :[UIFont systemFontOfSize:12*Width1] :[UIColor grayColor] :self.data[@"distanceStr"] :addVC :1];
    
    
    UIImageView *twoImg = [[UIImageView alloc]initWithFrame:CGRectMake(250, 0, 15, 15)];
    twoImg.image = [UIImage imageNamed:@"卸"];
    [addVC addSubview:twoImg];
    
    [UILabel initWithDFLable:CGRectMake(270, 0, 120, 15) :[UIFont systemFontOfSize:13*Width1] :[UIColor blackColor] :[NSString stringWithFormat:@"%@-%@",self.data[@"unloadCity"],self.data[@"unloadArea"]] :addVC :0];
    
    [UILabel initWithDFLable:CGRectMake(20, 35, Width - 40, 15) :[UIFont systemFontOfSize:13*Width1] :[UIColor grayColor] :self.data[@"otherMess"] :addVC :0];
    
    
    
    UIView *fg = [[UIView alloc]initWithFrame:CGRectMake(0, NavaBarHeight + 120, Width, 10)];
    fg.backgroundColor = COLOR2(240);
    [self.view addSubview:fg];
    
    
    
    UIView *commVC = [[UIView alloc]initWithFrame:CGRectMake(0, NavaBarHeight + 140, Width, 30)];
    commVC.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:commVC];
    
    
    [UILabel initWithDFLable:CGRectMake(20, 5, 40, 15) :[UIFont systemFontOfSize:14*Width1] :[UIColor blackColor] :@"评分:" :commVC :0];
    
    
    LHRatingView * rView = [[LHRatingView alloc]initWithFrame:CGRectMake(65,0, 100, 25)];
//    rView.center = self.view.center;
        rView.ratingType = INTEGER_TYPE;//整颗星
//    rView.score = 2;
    rView.delegate = self;
    [commVC addSubview:rView];
    
    self.commLab =  [UILabel initWithDFLable:CGRectMake(190, 5, 120, 15) :[UIFont systemFontOfSize:14*Width1] :COLOR2(53) :@"请选择评分" :commVC :0];
    
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(20, NavaBarHeight + 170, Width - 40, 300)];
    back.layer.cornerRadius = 4;
    back.layer.masksToBounds = YES;
    back.layer.borderWidth = 1;
    back.layer.borderColor = [COLOR2(230)CGColor];
    [self.view addSubview:back];
    
    
    self.textVC = [[UITextView alloc]initWithFrame:CGRectMake(10, 5, Width - 60, 140)];
    self.textVC.font = [UIFont systemFontOfSize:14];
    self.textVC.delegate = self;
    self.textVC.placeholder = @"本次运输体验如何呢？赶紧来评价一下吧！";
//    [self.textVC addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [back addSubview:self.textVC];
    
    
//   self.numlab = [UILabel initWithDFLable:CGRectMake(back.frame.size.width - 100, 150, 80, 15) :[UIFont systemFontOfSize:13*Width1] :[UIColor blackColor] :@"0/500" :back :2];
    
    
    self.ptovc = [[PtoVC alloc]initWithFrame:CGRectMake(10, 180, Width - 20, 90)];
    self.ptovc.vc = self;
    self.ptovc.type = @"1";
    self.ptovc.block = ^(UIImage * _Nonnull img) {
        
    };
  [back addSubview:self.ptovc];
    
    
    
    UIButton *suppBut = [UIButton initWithFrame:CGRectMake(20, NavaBarHeight + 490, Width - 40, 40) :@"提交" :16];
    suppBut.layer.cornerRadius = 4;
    suppBut.layer.masksToBounds = YES;
    suppBut.backgroundColor = [UIColor redColor];
    [suppBut addTarget:self action:@selector(suppAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:suppBut];
    
}


-(void)suppAction{
    
    
    
   
   
    
    if (self.index == 6) {

        return [self.view addSubview:[Toast makeText:@"请选择评分"]];
    }


    if (_index < 3) {

        if ([self.textVC.text isEqualToString:@""]) {

            return [self.view addSubview:[Toast makeText:@"请您输入原因，我们将进行改正"]];
        }




    }


    NSDictionary *dic = @{

        @"content":self.textVC.text,
        @"star":[NSString stringWithFormat:@"%ld",(long)self.index],
        @"waybillId":self.dic[@"waybillId"],
    };


    [AFN_DF POST:@"/tsmanage/waybillsettle/evaluate" Parameters:dic File:@[@"files"] ImageArr:self.ptovc.dataArray ContVC:self success:^(NSDictionary *responseObject) {


        EndCommController *endVC = [EndCommController new];
        endVC.dic = self.data;
        [self.navigationController pushViewController:endVC animated:YES];


//        [self.navigationController popViewControllerAnimated:YES];
//        [[AFN_DF topViewController].view addSubview:[Toast makeText:@"提交成功"]];

    } failure:^(NSError *error) {

    }];
//    
    
    
    
    
}
#pragma mark - ratingViewDelegate
- (void)ratingView:(LHRatingView *)view score:(CGFloat)score
{
    NSLog(@"分数  %f",score);
    self.index = (NSInteger )score;
    switch (self.index) {
        
        case 1:
            self.commLab.text = @"非常差";
            break;
        case 2:
            self.commLab.text = @"差";
            break;
        case 3:
            self.commLab.text = @"一般";
            break;
        case 4:
            self.commLab.text = @"好";
            break;
        case 5:
            self.commLab.text = @"非常好";
            break;
            
        default:
            break;
    }
    
    
    
}

-(void)setfwb:(UILabel *)las{
    
    NSString *str = las.text;
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    //给富文本添加属性1-字体大小
//        [attributedStr addAttribute:NSFontAttributeName
//                              value:[UIFont systemFontOfSize:14*Width1]
//                              range:NSMakeRange(0, 3)];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor blackColor]
                          range:NSMakeRange(0, 4)];
    
    
    las.attributedText = attributedStr;
//    las.textAlignment = YES;
    
   
    
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

        if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
                [self.view endEditing: YES];
//在这里做你响应return键的代码

                return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行

}

            return YES;

}

//记得释放通知


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
