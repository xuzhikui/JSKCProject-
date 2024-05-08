//
//  ReceOrderView.h
//  JSKCProject
//
//  Created by XHJ on 2020/10/17.
//  Copyright © 2020 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReceOrderView : UIView<UITextViewDelegate>

@property(nonatomic,strong)UIView *backVC;
@property(nonatomic,strong)UIButton *selectBut;
@property(nonatomic,strong)UIButton *endBut;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIButton *sendBut;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)NSString *gsId;
@property(nonatomic,strong)NSDictionary *data;
@end

NS_ASSUME_NONNULL_END
