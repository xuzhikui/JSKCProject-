//
//  MoreView.m
//  JSKCProject
//
//  Created by XHJ on 2020/10/12.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "MoreView.h"
#import "MoreCell.h"
#import "MoerHeadView.h"
#import "JYEqualCellSpaceFlowLayout.h"
@implementation MoreView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)layoutSubviews{
    
    if (self.selectArray == nil ||self.selectArray.count == 0) {
           
           self.selectArray = [NSMutableArray arrayWithObjects:@{},@{},@{},[NSMutableArray array],[NSMutableArray array],[NSMutableArray array], nil];
       }
}

-(void)setUI{
    
   
    
    [UILabel initWithDFLable:CGRectMake(22, 15 , Width, 30) :[UIFont boldSystemFontOfSize:22*Width1]:[UIColor blackColor] :
           @"货源":self:0];
    
    JYEqualCellSpaceFlowLayout  *flowLayout = [[JYEqualCellSpaceFlowLayout alloc]initWithType:AlignWithLeft betweenOfCell:10];
            //设置item 的行间距的 (如果不设置,默认值是10)
            flowLayout.minimumInteritemSpacing = 10;
            //设置item 的列间距的
            flowLayout.minimumLineSpacing = 10;
            //设置item的大小
            flowLayout.itemSize = CGSizeMake((Width - 60) /5 ,30);
            //设置滚动方向
            flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
            
            //设置UICollectionView 距离屏幕 上 下 左 右 的一个距离
            flowLayout.sectionInset = UIEdgeInsetsMake(5*Height1, 10*Height1, 10*Width1, 10*Width1);
            
      
            _collectVC = [[UICollectionView alloc]initWithFrame:CGRectMake(10,  50, Width  - 20, self.frame.size.height - 150) collectionViewLayout:flowLayout];
            //设置collectionView的两个代理方法
                _collectVC.dataSource = self;
                _collectVC.delegate = self;
        //    _collectVC.scrollEnabled =NO;
                _collectVC.backgroundColor = [UIColor whiteColor];
                [self addSubview:_collectVC];
                //先注册collectionViewcell
                [_collectVC registerClass:[MoreCell class] forCellWithReuseIdentifier:@"cell"];
//            [_collectVC registerClass:[MoerHeadView class]
//           forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
//                 withReuseIdentifier:@"cellID"];
    
    
            UIButton *czbut = [UIButton initWithFrame:CGRectMake((Width/2 - 120)/2, self.frame.size.height - 60, 120, 35) :@"重置" :16*Width1];
            czbut.layer.cornerRadius = 4;
            [czbut addTarget:self action:@selector(czAction) forControlEvents:(UIControlEventTouchUpInside)];
            czbut.backgroundColor = COLOR(239, 155, 69);
            [self addSubview:czbut];
    
    
    UIButton *endbut = [UIButton initWithFrame:CGRectMake(Width/2 + (Width/2 - 120)/2, self.frame.size.height - 60,120, 35) :@"确定" :16*Width1];
    endbut.layer.cornerRadius = 4;
    endbut.backgroundColor = COLOR(227, 23, 23);
    [endbut addTarget:self action:@selector(endButAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:endbut];
    
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableView = nil;
    [collectionView registerClass:[MoerHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView"];
           MoerHeadView *tempHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView" forIndexPath:indexPath];
           reusableView = tempHeaderView;
    
    for (UIView *vc in reusableView.subviews) {
        
        [vc removeFromSuperview];
    }
     
    
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:16*Width1]};
    CGFloat width = [self.dataArray[indexPath.section][@"name"] boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
    [UILabel initWithDFLable:CGRectMake(10, 10, width, 40) :[UIFont systemFontOfSize:16*Width1] :[UIColor blackColor] :self.dataArray[indexPath.section][@"name"] : reusableView :0];
    
    
   
    
      
    
    
    
    if (indexPath.section > 2) {
        
         [UILabel initWithDFLable:CGRectMake(width + 15, 10, 50, 40) :[UIFont systemFontOfSize:14*Width1] :[UIColor redColor] :@"(多选)": reusableView :0];
        
        
    }else{
        
         [UILabel initWithDFLable:CGRectMake(width + 15, 10, 50, 40) :[UIFont systemFontOfSize:14*Width1] :[UIColor redColor] :@"(单选)": reusableView :0];
    }
    
//    [tempHeaderView add]
    
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    
     
        return  CGSizeMake(Width, 50);
   
  
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.dataArray.count;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray *arr = self.dataArray[section][@"screens"];
    return arr.count;
}


#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = self.dataArray[indexPath.section][@"screens"];
    NSDictionary *dic = arr[indexPath.row];
    NSString *str = dic[@"factor"];
  CGSize size =  [self getMultiLineWithFont:14*Width1 andText:str];
    
    
    
    return  CGSizeMake(size.width + 15, 30);
}
//根据文字计算cell大小
- (CGSize)getMultiLineWithFont:(NSInteger)font andText:(NSString *)text
{
    CGSize size  = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width -30, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return size;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *arr = self.dataArray[indexPath.section][@"screens"];
    
    MoreCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView *vc in cell.contentView.subviews) {
        [vc removeFromSuperview];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 4;
    cell.layer.borderWidth = 1;

    
    
    
    if (indexPath.section < 3) {
        cell.layer.borderColor = [COLOR2(204)CGColor];
        cell.backgroundColor =[UIColor whiteColor];
         cell.code = @"1";
        
        if (indexPath.row == 0) {
            if ( [self.selectArray[indexPath.section]  isEqual: @{}]) {
                cell.layer.borderColor = [[UIColor redColor] CGColor];
                cell.backgroundColor = COLOR(252, 245, 246);
                cell.code = @"2";
            }
          
        }
        
        
        
        if (self.selectArray[indexPath.section] == arr[indexPath.row]) {
             cell.layer.borderColor = [[UIColor redColor] CGColor];
            cell.code = @"2";
                cell.backgroundColor = COLOR(252, 245, 246);
       }

    }else{
        
   
          cell.layer.borderColor = [COLOR2(204)CGColor];
            cell.backgroundColor = [UIColor whiteColor];
         cell.code = @"1";
        
        if (indexPath.row == 0) {
            
            if ( [self.selectArray[indexPath.section]  isEqual:@[]]) {

                cell.layer.borderColor = [[UIColor redColor] CGColor];
                cell.backgroundColor = COLOR(252, 245, 246);
                cell.code = @"2";
             }
        }
        
        
        
        if ([self.selectArray[indexPath.section] containsObject: arr[indexPath.row]] ) {
            cell.layer.borderColor = [[UIColor redColor] CGColor];
             cell.backgroundColor = COLOR(252, 245, 246);
             cell.code = @"2";
              
        }
        
        }

    cell.dic = arr[indexPath.row];
    [cell setUI];
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
     NSArray *arr = self.dataArray[indexPath.section][@"screens"];

    for (int i = 0; i < arr.count; i++) {
        
        MoreCell *cell = (MoreCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
       
        if (indexPath.section  < 3) {
            
            cell.backgroundColor = [UIColor whiteColor];
             cell.layer.borderColor = [COLOR2(204) CGColor];
            cell.labs.textColor =  COLOR2(68);
        }
        
        if (indexPath.section >= 3) {
            
            if (indexPath.row == 0) {
         
                cell.backgroundColor = [UIColor whiteColor];
                 cell.layer.borderColor = [COLOR2(204) CGColor];
                cell.labs.textColor =  COLOR2(68);
            }else{
               
                MoreCell *cell = (MoreCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]];
                cell.backgroundColor = [UIColor whiteColor];
                 cell.layer.borderColor = [COLOR2(204) CGColor];
                cell.labs.textColor =  COLOR2(68);
                
                
            }
            
            
        }
        
        
        if (indexPath.row == i) {
            
                BOOL isbool = [self.selectArray[indexPath.section] containsObject: arr[indexPath.row]];
            
                if (! isbool) {
                cell.backgroundColor = COLOR(252, 245, 246);
                         cell.layer.borderColor = [[UIColor redColor]CGColor];
                         cell.labs.textColor = [UIColor redColor];
                    
                
                }else{
                    
                    cell.backgroundColor = [UIColor whiteColor];
                                cell.layer.borderColor = [COLOR2(204) CGColor];
                               cell.labs.textColor =  COLOR2(68);
                    
                }
            
            
          
        }
        
    }
    
    
    switch (indexPath.section) {
        case 0:
              self.selectArray[0] = arr[indexPath.row];
            break;
            case 1:
            self.selectArray[1] = arr[indexPath.row];
            break;
            case 2:
                   self.selectArray[2] = arr[indexPath.row];
                   break;
          case 3:
        {
                BOOL isbool = [self.selectArray[3] containsObject: arr[indexPath.row]];
            if (isbool) {
                [self.selectArray[3] removeObject:arr[indexPath.row]];
            }else{
                
                [self.selectArray[3] addObject: arr[indexPath.row]];
            }
            
        }
                   break;
           case 4:
        {
            if (indexPath.row == 0) {
                [self.selectArray[4]  removeAllObjects];
            }else{
                
                BOOL isbool = [self.selectArray[4] containsObject: arr[indexPath.row]];
                        if (isbool) {
                            [self.selectArray[4] removeObject:arr[indexPath.row]];
                        }else{
                            
                            [self.selectArray[4] addObject: arr[indexPath.row]];
                        }
                
            }
                    
        }
                break;
            break;
           case 5:
                  {
            BOOL isbool = [self.selectArray[5] containsObject: arr[indexPath.row]];
                        if (isbool) {
                        [self.selectArray[5] removeObject:arr[indexPath.row]];
                            }else{
                                          
                            [self.selectArray[5] addObject: arr[indexPath.row]];
                        }
                                      
                    }
                   break;
            
        default:
            break;
    }
    

    
}




-(void)czAction{
    
    self.czblock(self.selectArray);
       
       [self.vc removeFromSuperview];
       [self removeFromSuperview];
    
}

-(void)endButAction{
    
    
    self.block(self.selectArray);
    
    [self.vc removeFromSuperview];
    [self removeFromSuperview];
    
    
}


@end
