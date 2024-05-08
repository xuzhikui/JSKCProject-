//
//  AddressVC.m
//  JSKCProject
//
//  Created by XHJ on 2020/9/21.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import "AddressVC.h"
#import "SelectCell.h"
#import "AddressCollCell.h"
@implementation AddressVC

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUI];
    }
    return self;
}

-(void)layoutSubviews{
    
    if ([self.code isEqualToString:@"0"]) {
        
        self.addressLab.text = @"装货地";
    }else{
        self.addressLab.text = @"卸货地";
        
    }
    
    self.searArray = [NSMutableArray array];
    
    if (self.selectCollArray.count == 0) {
              self.selectCollArray = [NSMutableArray array];
       }else{
            self.dataArray = [NSMutableArray array];
           for (int i = 0; i<self.selectCollArray.count; i++) {
               
               NSDictionary *dic = self.selectCollArray[i];
               [self.dataArray addObject:dic[@"place"]];
               
           }
       }
    
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.listArray];
    
    
  
    for (int i = 0; i < arr.count; i++) {
        
        NSDictionary *dic = arr[i];
        NSString *str =  [NSString stringWithFormat:@"%@",dic[@"place"]];
        
        if ([str isEqualToString:[LoactionModel shareInstance].city]) {
            
            [arr removeObject:dic];
            
        }
        
        
    }
    
    self.listArray = arr;
    [self.table reloadData];
    [self.collectVC reloadData];
}


-(void)setUI{
   
   self.dataArray = [NSMutableArray array];
    
   self.addressLab = [UILabel initWithDFLable:CGRectMake(22, 15 , Width, 30) :[UIFont boldSystemFontOfSize:22*Width1]:[UIColor blackColor] :
        @"":self:0];
    
    
    self.addresTF = [[UITextField alloc]initWithFrame:CGRectMake(22, 75, Width - 100, 20)];
    self.addresTF.placeholder = @"请输入装货地";
    self.addresTF.font = [UIFont systemFontOfSize:15*Width1];
    [self.addresTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.addresTF.delegate = self;
    [self  addSubview:self.addresTF];
    
    
    
    
    
    
    
    UIView  *fg = [[UIView alloc]initWithFrame:CGRectMake(22, 115, self.frame.size.width - 44, 1)];
    fg.backgroundColor = COLOR2(240);
    [self addSubview:fg];
    
    
    [self setcollectionVCs];
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0,220, self.frame.size.width, self.frame.size.height - 320) style:(UITableViewStylePlain)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor =[UIColor whiteColor];
    [self addSubview:self.table];
    [self.table registerClass:[SelectCell class] forCellReuseIdentifier:@"cell"];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        
        if (self.searArray.count != 0 || ![self.addresTF.text isEqualToString:@""]) {
            return self.searArray.count;
        }else{
        return self.listArray.count;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSArray *arr;
    
    if (self.searArray.count != 0) {

        arr = self.searArray;
    }else{
          arr =self.listArray;
    }
    
    SelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
   
  
    if (indexPath.section == 0) {
          cell.code = @"1";
        cell.titStr = [LoactionModel shareInstance].city;
    }else{
        

          cell.code = @"1";
         cell.titStr = arr[indexPath.row][@"place"];
    }
    
    
    cell.seleArray = self.dataArray;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    

    SelectCell *cell = (SelectCell *)[tableView cellForRowAtIndexPath:indexPath];
          
          BOOL isbool = [self.dataArray containsObject:cell.titles.text];
    
    if (self.dataArray.count < 5 || isbool == YES) {
      
        if (isbool) {
            cell.titles.textColor = [UIColor grayColor];
            [self.dataArray removeObject:cell.titles.text];
                 cell.imgs.hidden = YES;
            
            if (indexPath.section == 0) {
                [self.selectCollArray removeObject:self.cityDic];
            }else{
                
                [self.selectCollArray removeObject:self.listArray[indexPath.row]];
            }
         
           
            
            
        }else{
            
            cell.titles.textColor = [UIColor redColor];
                    [self.dataArray addObject:cell.titles.text];
            if (indexPath.section == 0) {
                [self.selectCollArray addObject:self.cityDic];
            }else{
                
                [self.selectCollArray addObject:self.listArray[indexPath.row]];
            
            }
                 cell.imgs.hidden = NO;
        }
        
        
        self.numLab.text = [NSString stringWithFormat:@"已选择(%lu/5)",(unsigned long)self.self.selectCollArray.count];
        [self.collectVC reloadData];
        
     
        
    }else{
        
        [[AFN_DF topViewController].view addSubview:[Toast makeText:@"您已经选择（5/5）个城市"]];
    }
    
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.frame.size.width, 30)];
    UIImageView *imgs = [[UIImageView alloc]initWithFrame:CGRectMake(20, 9, 12, 12)];
    back.backgroundColor = COLOR2(241);
 
    
    if (section == 0) {
        imgs.image = [UIImage imageNamed:@"位置-1"];
        [back addSubview:imgs];
          [UILabel initWithDFLable:CGRectMake(38, 7.5, Width -100,15) :[UIFont systemFontOfSize:14*Width1] :[UIColor grayColor] :@"当前城市" :back :0];
    }else{
        imgs.image = [UIImage imageNamed:@"城市-1"];
              [back addSubview:imgs];
          [UILabel initWithDFLable:CGRectMake(38, 7.5, Width -100,15) :[UIFont systemFontOfSize:14*Width1] :[UIColor grayColor] :@"所有城市" :back :0];
    }
    
    

    
  
    
    return back;
    
}




-(void)setcollectionVCs{
    
    
   self.numLab = [UILabel initWithDFLable:CGRectMake(0, 135, Width/4 -10,15) :[UIFont systemFontOfSize:14] :[UIColor blackColor] :@"已选择(0/5)" :self :2];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
     //设置item 的行间距的 (如果不设置,默认值是10)
     flowLayout.minimumInteritemSpacing = 1*Height1;
     //设置item 的列间距的
     flowLayout.minimumLineSpacing = 10;
     //设置item的大小
    CGFloat wid = Width/4 *3 - 20;
     flowLayout.itemSize = CGSizeMake((wid - 40)/3, 25);
     //设置滚动方向
     flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
     
     //设置UICollectionView 距离屏幕 上 下 左 右 的一个距离
     flowLayout.sectionInset = UIEdgeInsetsMake(0*Height1, 10*Height1, 10*Width1, 10*Width1);
     _collectVC = [[UICollectionView alloc]initWithFrame:CGRectMake(Width/4,135, Width/4 * 3  - 20,80) collectionViewLayout:flowLayout];
     //设置collectionView的两个代理方法
    _collectVC.dataSource = self;
    _collectVC.delegate = self;
     
    _collectVC.backgroundColor = [UIColor whiteColor];
     [self addSubview:_collectVC];
     //先注册collectionViewcell
     [_collectVC registerClass:[AddressCollCell class] forCellWithReuseIdentifier:@"cellID"];
    
}


#pragma Mark ----- UICollectionViewDelegate ------

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    return 1;
}


  


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}


-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddressCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    for (UIView *vc in cell.contentView.subviews) {
        
        [vc removeFromSuperview];
    }
    cell.layer.cornerRadius = 4;
    cell.tit = self.dataArray[indexPath.row];
    cell.layer.borderColor = [COLOR2(220)CGColor];
    cell.layer.borderWidth = 1;
    [cell initUIs];
    return cell;
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self.dataArray removeObjectAtIndex:indexPath.row];
//    [self.selectCollArray removeObject:self.listArray[indexPath.row]];
    [self.selectCollArray removeObjectAtIndex:indexPath.row];
    [self.collectVC reloadData];
    
    [self.table reloadData];
    
    self.numLab.text = [NSString stringWithFormat:@"已选择(%lu/5)",(unsigned long)self.self.selectCollArray.count];
    
    
}


- (void)textFieldDidChange:(UITextField *)textField {
  
    
     NSString *search =  textField.text;
    self.searArray  = [NSMutableArray array];
    for (NSDictionary *dic in self.listArray) {
        
       NSString *dataStr = dic[@"place"];
        
        if ([dataStr  containsString:search]) {
            
            [self.searArray addObject:dic];
        }
        
        
    }
    
    
        [self.table reloadData];
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)endButAction{
    
    self.block(self.selectCollArray);
    
    [self removeFromSuperview];
    [self.vc removeFromSuperview];
}

-(void)czAction{
    
    
      self.czblock(self.selectCollArray);
        [self removeFromSuperview];
    [self.vc removeFromSuperview];
}


@end
