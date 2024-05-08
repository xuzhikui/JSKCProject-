//
//  TwoCarNumVC.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/30.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "TwoCarNumVC.h"
#import "CarNumCell.h"
#import "CarNumView.h"
#import "TwoCarNumCell.h"
@implementation TwoCarNumVC

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
       
    }
    return self;
}


-(void)layoutSubviews{
    
    
    self.strArray = [NSMutableArray arrayWithObjects:self.carType, nil];
    if ([self.butCode isEqualToString:@"1"]) {
        
        self.color = COLOR(247, 193, 29);
        self.num = 7;
    }else  if ([self.butCode isEqualToString:@"2"]) {
           
        self.color = COLOR(34, 98, 195);
            self.num = 7;
    }else{
        
         self.color = COLOR(51, 171, 45);
          self.num = 8;
    }
    
    
    [self setUI];
    
    
    
    
    
    
    
    
}


-(void)setUI{
    
    
    self.dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"*",@"Z",@"X",@"C",@"V",@"B",@"N",@"M"];
    
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
    
    [UILabel initWithDFLable:CGRectMake(0,20, Width, 30) :[UIFont boldSystemFontOfSize:19*Width1] :[UIColor blackColor] :@"请输入车牌号" :numVC :1];
    
    
    UIButton *closeBut = [UIButton initWithFrame:CGRectMake(Width - 40, 20, 30, 30) :@"关闭"];
    [closeBut addTarget:self action:@selector(onTapGR) forControlEvents:(UIControlEventTouchUpInside)];
    [numVC addSubview:closeBut];
    
    
    {
        UICollectionViewFlowLayout  *flowLayout1 = [[UICollectionViewFlowLayout alloc]init];
                  //设置item 的行间距的 (如果不设置,默认值是10)
                  flowLayout1.minimumInteritemSpacing = 5;
                  //设置item 的列间距的
                  flowLayout1.minimumLineSpacing = 5;
                  //设置item的大小
     
                  //设置滚动方向
                  flowLayout1.scrollDirection = UICollectionViewScrollDirectionVertical;
                  
                  //设置UICollectionView 距离屏幕 上 下 左 右 的一个距离
                  flowLayout1.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0);
                  

                 
        
        if ([self.butCode isEqualToString:@"3"]) {
            flowLayout1.itemSize = CGSizeMake((Width-80)/(self.num + 1) , 50);
                                _numVC = [[UICollectionView alloc]initWithFrame:CGRectMake(10,70 , Width - 20, 60) collectionViewLayout:flowLayout1];
            
            
        }else{
          
            flowLayout1.itemSize = CGSizeMake((Width-95)/(self.num + 1) , 50);
                      _numVC = [[UICollectionView alloc]initWithFrame:CGRectMake(30,70 , Width - 60, 60) collectionViewLayout:flowLayout1];
        }
        
                  //设置collectionView的两个代理方法
                   _numVC.dataSource = self;
                  _numVC.delegate = self;
                   _numVC.tag = 1003;
//                _numVC.scrollEnabled = NO;
              //    _collectVC.scrollEnabled =NO;
            _numVC.backgroundColor = [UIColor whiteColor];
                  [numVC addSubview: _numVC];
                  //先注册collectionViewcell
                  [_numVC registerClass:[TwoCarNumCell class] forCellWithReuseIdentifier:@"cellID"];
        
    }
    
    
    
    
     UICollectionViewFlowLayout  *flowLayout = [[UICollectionViewFlowLayout alloc]init];
           //设置item 的行间距的 (如果不设置,默认值是10)
           flowLayout.minimumInteritemSpacing = 5;
           //设置item 的列间距的
           flowLayout.minimumLineSpacing = 5;
           //设置item的大小
           flowLayout.itemSize = CGSizeMake((Width-65)/10 , 45);
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
    

    UIButton *endBut = [UIButton initWithFrame:CGRectMake(Width - (Width-65)/10 * 3 - 20,_collectVC.frame.size.height - 55,(Width-65)/10 * 3 + 10 , 45) :@"确认" :15*Width1];
    
    
    endBut.layer.cornerRadius = 4;
    [endBut addTarget:self action:@selector(endAction) forControlEvents:(UIControlEventTouchUpInside)];
    endBut.backgroundColor = self.color;
    [_collectVC addSubview:endBut];
    
    
    
}

-(void)endAction{
    
    
    
         if (self.strArray.count != self.num) {
                    
             return [[AFN_DF topViewController].view addSubview:[Toast makeText:@"请填写完整车牌号"]];
                    
                }else{
                      NSString *str = @"";
                                      
                      for (int i = 0; i < self.strArray.count; i++) {
                                          
                          str = [NSString stringWithFormat:@"%@%@",str,self.strArray[i]];
                          }
                                      
                                      
                          NSDictionary *dic = @{
                              @"color":self.butCode,
                              @"num":str
                              };
                    
                  
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"carnum" object:dic];
                    [self onTapGR];
                    
                }

}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    if (collectionView.tag == 1003) {
        return self.num + 1;
       
    }else{
        
         return self.dataArray.count;
    }
    
   
    
    
    
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (collectionView.tag == 1003) {
        
        TwoCarNumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
        

        for (UIView *vc in cell.contentView.subviews) {
            
            [vc removeFromSuperview];
        }
        
                 cell.backgroundColor = [UIColor whiteColor];
            
                 cell.layer.cornerRadius = 4;
                    cell.layer.masksToBounds = YES;

       
        if (indexPath.row != 2) {
            
            if (indexPath.row > 2) {
                 //            3   2
                             
                             if (self.strArray.count  >= indexPath.row) {
                                        cell.str = self.strArray[indexPath.row - 1];
                                   }else{
                                       
                                       cell.str = @"";
                                       
                                   }
                                   
                             
                         }else{
                             
                             if (self.strArray.count  > indexPath.row) {
                                        cell.str = self.strArray[indexPath.row];
                                   }else{
                                       
                                       cell.str = @"";
                                       
                                   }
        }

    }
       
        if (indexPath.row == 2) {
                cell.layer.borderWidth = 0;
                cell.str = @"*";
                cell.layer.borderColor = [[UIColor whiteColor] CGColor];
        }else{
//
            cell.layer.borderWidth = 1;
//
//
            
            if (indexPath.row > 1) {
                if (self.strArray.count == indexPath.row - 1) {
                    cell.layer.borderColor = [self.color CGColor];
                           }else{

                                cell.layer.borderColor = [COLOR2(203)CGColor];
                           }
            }else{
                if (self.strArray.count == indexPath.row) {
                    cell.layer.borderColor = [self.color CGColor];
                           }else{

                                cell.layer.borderColor = [COLOR2(203)CGColor];
                           }
                
            }
            

//
        }

                 [cell setUI];
                 return cell;
        
        
    }else{
        
        CarNumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
          cell.backgroundColor = [UIColor whiteColor];
          cell.str = self.dataArray[indexPath.row];
          cell.layer.cornerRadius = 4;
             cell.layer.masksToBounds = YES;

          
          [cell setUI];
          return cell;
        
    }
    
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    

    
    if (indexPath.row + 1 == self.dataArray.count) {
        
 
        
    }else if(indexPath.row == 29){
        
     
        if (self.strArray.count == 1) {

            [self onTapGR];
            
           CarNumView *vc = [[CarNumView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];

                [[AFN_DF topViewController].view addSubview:vc];
            
        }else{
            
                [self.strArray removeLastObject];
                   [self.numVC reloadData];
        }
        
       
        
        
    }else{
    
    for (int i = 0; i < self.dataArray.count; i++) {
        
        CarNumCell *cell = (CarNumCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        cell.layer.borderWidth = 0;
        
        if (indexPath.row == i) {
            if (self.strArray.count == self.num) {
                
                return;
            }
            
//             cell.layer.borderWidth = 1;
            self.str = self.dataArray[indexPath.row];
            [self.strArray addObject:self.str];
//          cell.layer.borderColor = [[UIColor orangeColor]CGColor];
            [self.numVC reloadData];
        }
        
    }
    
    }
   
    
    
    
    
}


-(void)onTapGR{
      [[AFN_DF topViewController].navigationController setNavigationBarHidden:NO animated:YES];
      [self removeFromSuperview];
}

@end
