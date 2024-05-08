//
//  CarNumView.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/29.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "CarNumView.h"
#import "CarNumCell.h"
#import "TwoCarNumVC.h"
@implementation CarNumView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
       
    }
    return self;
}


-(void)layoutSubviews{
    
    self.code = @"";
    [self setUI];
    
}


-(void)setUI{
    
    
    self.dataArray = @[@"陕",@"京",@"津",@"沪",@"翼",@"豫",@"云",@"辽",@"黑",@"湘",@"皓",@"鲁",@"新",@"苏",@"浙",@"赣",@"鄂",@"桂",@"甘",@"晋",@"蒙",@"吉",@"闽",@"贵",@"粤",@"川",@"青",@"藏",@"琼",@"宁",@"渝",@"完成"];
    
       self.backVC = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
          self.backVC.backgroundColor = [UIColor blackColor];
          self.backVC.alpha = 0.5;
          UITapGestureRecognizer *TapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapGR)];
               self.backVC.userInteractionEnabled = YES;
               [ self.backVC addGestureRecognizer:TapGR];
    
            [self addSubview:self.backVC];
    
         

    
    UIView *numVC = [[UIView alloc]initWithFrame:CGRectMake(0,Height - 375, self.frame.size.width,375)];
    numVC.backgroundColor = [UIColor whiteColor];
    [self addSubview:numVC];
    
    [UILabel initWithDFLable:CGRectMake(0,20, Width, 30) :[UIFont boldSystemFontOfSize:19*Width1] :[UIColor blackColor] :@"请选择车牌类型" :numVC :1];
    
    
    UIButton *closeBut = [UIButton initWithFrame:CGRectMake(Width - 40, 20, 30, 30) :@"关闭"];
    [closeBut addTarget:self action:@selector(onTapGR) forControlEvents:(UIControlEventTouchUpInside)];
    [numVC addSubview:closeBut];
    
    
    self.but1 = [UIButton initWithFrame:CGRectMake(20 + (Width/3 * 0), 75, Width/3 - 40, 66) :@"黄牌1"];
    self.but1.tag = 3000;
    [self.but1 addTarget:self action:@selector(butAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [numVC addSubview:self.but1];
    
    self.but2 = [UIButton initWithFrame:CGRectMake(20 + (Width/3 * 1), 75, Width/3 - 40, 66) :@"蓝牌1"];
       self.but2.tag = 3001;
       [self.but2 addTarget:self action:@selector(butAction:) forControlEvents:(UIControlEventTouchUpInside)];
       [numVC addSubview:self.but2];
    
    self.but3 = [UIButton initWithFrame:CGRectMake(20 + (Width/3 * 2), 75, Width/3 - 40, 66) :@"绿牌1"];
       self.but3.tag = 3002;
       [self.but3 addTarget:self action:@selector(butAction:) forControlEvents:(UIControlEventTouchUpInside)];
       [numVC addSubview:self.but3];
    

   
     UICollectionViewFlowLayout  *flowLayout = [[UICollectionViewFlowLayout alloc]init];
           //设置item 的行间距的 (如果不设置,默认值是10)
           flowLayout.minimumInteritemSpacing = 5;
           //设置item 的列间距的
           flowLayout.minimumLineSpacing = 5;
           //设置item的大小
           flowLayout.itemSize = CGSizeMake((Width-55)/8 , 45);
           //设置滚动方向
           flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
           
           //设置UICollectionView 距离屏幕 上 下 左 右 的一个距离
           flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
           

           _collectVC = [[UICollectionView alloc]initWithFrame:CGRectMake(0,160 , Width, 215) collectionViewLayout:flowLayout];
           //设置collectionView的两个代理方法
           _collectVC.dataSource = self;
           _collectVC.delegate = self;
           _collectVC.tag = 1001;
        _collectVC.scrollEnabled = NO;
       //    _collectVC.scrollEnabled =NO;
            _collectVC.backgroundColor = COLOR2(240);
           [numVC addSubview:_collectVC];
           //先注册collectionViewcell
           [_collectVC registerClass:[CarNumCell class] forCellWithReuseIdentifier:@"cell"];
    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.dataArray.count;
    
    
    
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CarNumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.str = self.dataArray[indexPath.row];
    cell.layer.cornerRadius = 4;
    cell.layer.masksToBounds = YES;
    [cell setUI];
    return cell;
    
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
   
    
    if (indexPath.row + 1 == self.dataArray.count) {
        
        
        if ([self.str isEqualToString:@""] || self.str == nil) {
            
            return [[AFN_DF topViewController].view addSubview:[Toast makeText:@"请选择车牌照区域"]];
         
        }
            
        
        if ([self.code isEqualToString:@""]) {
                   
                   return [[AFN_DF topViewController].view addSubview:[Toast makeText:@"请选择牌照类型"]];
                
               }
        
        
        
             
                        [self onTapGR];
                     TwoCarNumVC *vc = [[TwoCarNumVC alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
                            vc.carType = self.str;
                                vc.butCode = self.code;
                            [[AFN_DF topViewController].view addSubview:vc];
            
        
        
        
        
        
    }else{
        
        for (int i = 0; i < self.dataArray.count; i++) {
            
            CarNumCell *cell = (CarNumCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            
            cell.layer.borderWidth = 0;
            
            if (indexPath.row == i) {
                 cell.layer.borderWidth = 1;
             self.str = self.dataArray[indexPath.row];
              cell.layer.borderColor = [[UIColor redColor]CGColor];
                
            }
            
        }
        
        
    }
    
    
   
    
    
    
    
}


-(void)butAction:(UIButton *)but{
    
    
    if (but.tag == 3000) {
        self.code = @"1";
        self.but1.layer.borderWidth = 1;
        self.but1.layer.borderColor = [[UIColor redColor]CGColor];
        self.but2.layer.borderWidth = 0;
         self.but3.layer.borderWidth = 0;
        
    }else if(but.tag == 3001){
        self.code  =@"2";
        self.but2.layer.borderWidth = 1;
             self.but2.layer.borderColor = [[UIColor redColor]CGColor];
             self.but1.layer.borderWidth = 0;
              self.but3.layer.borderWidth = 0;
        
        
    }else{
        self.code = @"3";
        
        self.but3.layer.borderWidth = 1;
                    self.but3.layer.borderColor = [[UIColor redColor]CGColor];
                    self.but1.layer.borderWidth = 0;
                     self.but2.layer.borderWidth = 0;
        
    }
    

    
}

-(void)onTapGR{
      [[AFN_DF topViewController].navigationController setNavigationBarHidden:NO animated:YES];
      [self removeFromSuperview];
}


@end
