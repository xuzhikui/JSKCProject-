//  MXSCycleScrollView.h
//  YilidiSeller
//
//  Created by yld on 16/6/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MXSCycleScrollViewDelegate;
@protocol MXSCycleScrollViewDatasource;

@interface MXSCycleScrollView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    
    NSInteger _totalPages;
    NSInteger _curPage;
    
    NSMutableArray *_curViews;
}

@property (nonatomic,readonly) UIScrollView *scrollView;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign,setter = setDataource:) id<MXSCycleScrollViewDatasource> datasource;
@property (nonatomic,assign,setter = setDelegate:) id<MXSCycleScrollViewDelegate> delegate;

- (void)setCurrentSelectPage:(NSInteger)selectPage; //设置初始化页数
- (void)reloadData;
- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;

@end

@protocol MXSCycleScrollViewDelegate <NSObject>

@optional
- (void)didClickPage:(MXSCycleScrollView *)csView atIndex:(NSInteger)index;
- (void)scrollviewDidChangeNumber;

@end

@protocol MXSCycleScrollViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages:(MXSCycleScrollView*)scrollView;
- (UIView *)pageAtIndex:(NSInteger)index andScrollView:(MXSCycleScrollView*)scrollView;

@end
