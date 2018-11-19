//
//  JXScreenView.m
//  JXFilterDemo
//
//  Created by 姬祥 on 2018/11/15.
//  Copyright © 2018 姬祥. All rights reserved.
//

#import "JXScreenView.h"
#import "JXMacro.h"

@interface JXScreenView()

@property (nonatomic, strong) UIView *blackView;

@end

@implementation JXScreenView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    [self addSubview:self.blackView];
    [self addSubview:self.mainView];
}

#pragma mark - 懒加载
- (JXMainView *)mainView
{
    if (!_mainView) {
        _mainView = [[JXMainView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH*MainView_Left, 0, UI_SCREEN_WIDTH*(1-MainView_Left), UI_SCREEN_HEIGHT)];
        _mainView.backgroundColor = [UIColor whiteColor];
        WEAKSELF
        _mainView.returnFilterArr = ^(NSArray * _Nonnull arr) {
            [weakSelf clickTheSureBtn:arr];
        };
    }
    return _mainView;
}

- (UIView *)blackView
{
    if (!_blackView) {
        _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH*MainView_Left, UI_SCREEN_HEIGHT)];
        _blackView.backgroundColor = [UIColor colorWithWhite:0.f alpha:ScreenView_Alpha];
        
        // 添加轻扫手势
        UISwipeGestureRecognizer *swipRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipFrom:)];
        swipRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [_blackView addGestureRecognizer:swipRecognizer];
        
        // 添加点击手势
        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_blackView addGestureRecognizer:tap];
    }
    return _blackView;
}

#pragma mark - Action
- (void)clickTheSureBtn:(NSArray *)arr
{
    if (self.returnFilterArr) {
        self.returnFilterArr(arr);
    }
    [self tapAction];
}

#pragma mark - 手势
//判断清扫手势方向
- (void)handleSwipFrom:(UISwipeGestureRecognizer *)swipRecognizer
{
    if (swipRecognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self tapAction];
    }
}

//没有点击确定按钮 都走这个方法
- (void)tapAction
{
    [self tapSureFilterButton];
}

/**
 *  筛选框向右消失
 */
- (void)tapSureFilterButton
{
    WEAKSELF
    [UIView animateWithDuration:ScreenView_Duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         weakSelf.frame = CGRectMake(UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
                     } completion:^(BOOL finished) {
//                         [weakSelf.mainView reloadInputViews]
                     }];
}

@end
