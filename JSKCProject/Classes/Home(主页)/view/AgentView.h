//
//  AgentView.h
//  JSKCProject
//
//  Created by XHJ on 2021/3/25.
//  Copyright © 2021 孟德峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgentView : UIView
@property(nonatomic,strong)UIView *backVC;
@property(nonatomic,strong)UIButton *selectBut;
@property(nonatomic,strong)UIButton *endBut;
@property(nonatomic,strong)UIButton *sendBut;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)NSString *gsId;
@end

NS_ASSUME_NONNULL_END
