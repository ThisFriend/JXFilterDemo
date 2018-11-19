//
//  ViewController.m
//  JXFilterDemo
//
//  Created by 姬祥 on 2018/11/15.
//  Copyright © 2018 姬祥. All rights reserved.
//

#import "ViewController.h"
#import "JXScreenView.h"
#import "JXMacro.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *showBtn;
@property (nonatomic, strong) JXScreenView *screenView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *copyArr; // 暂时没用到，没想好

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addSubviews];
}

- (void)addSubviews
{
    [self.view addSubview:self.showBtn];
}

#pragma mark - Action
- (void)startFilter
{
    self.screenView.hidden = NO;
    self.screenView.mainView.dataArr = self.dataArr;
    WEAKSELF
    [UIView animateWithDuration:ScreenView_Duration animations:^{
        weakSelf.screenView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    }];
}

#pragma mark - 懒加载
- (UIButton *)showBtn
{
    if (!_showBtn) {
        _showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _showBtn.frame = CGRectMake(0, 0, 100.f, 100.f);
        _showBtn.center = CGPointMake(UI_SCREEN_WIDTH/2, UI_SCREEN_HEIGHT/2);
        _showBtn.backgroundColor = RandomColor;
        [_showBtn setTitle:@"开始筛选" forState:UIControlStateNormal];
        [_showBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_showBtn addTarget:self action:@selector(startFilter) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showBtn;
}

- (JXScreenView *)screenView
{
    if (!_screenView) {
        _screenView = [[JXScreenView alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        _screenView.hidden = YES;
        WEAKSELF
        _screenView.returnFilterArr = ^(NSArray * _Nonnull arr) {
            // 点击确定按钮之后的操作
            NSLog(@"arr = %@", arr);
        };
        [self.view addSubview:_screenView];
    }
    return _screenView;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        NSArray *titleArr = @[@"品牌", @"种类", @"型号", @"售价"];
        int num = 10;
        NSMutableArray *dataList = [[NSMutableArray alloc] init];
        for (int i = 0; i < titleArr.count; i++) {
            JXFilterModel *model = [[JXFilterModel alloc] init];
            
            model.sectionName = titleArr[i];
            model.sectionID = [NSString stringWithFormat:@"%i", i];
            NSMutableArray *listArr = [[NSMutableArray alloc] init];
            for (int j = 0; j < num; j++) {
                NSString *tagName = [NSString stringWithFormat:@"%@%i", titleArr[i], j];
                NSString *tagID = [NSString stringWithFormat:@"%i", j];
                NSString *select = @"0";
                NSDictionary *dic = @{@"tagName":tagName, @"tagID":tagID, @"select":select};
                [listArr addObject:[dic mutableCopy]];
            }
            model.listArray = listArr;
            model.isClick = NO;
            
            [dataList addObject:model];
        }
        
        _dataArr = dataList;
    }
    return _dataArr;
}

- (NSMutableArray *)copyArr
{
    if (!_copyArr) {
        NSArray *titleArr = @[@"品牌", @"种类", @"型号", @"售价"];
        int num = 10;
        NSMutableArray *dataList = [[NSMutableArray alloc] init];
        for (int i = 0; i < titleArr.count; i++) {
            JXFilterModel *model = [[JXFilterModel alloc] init];
            
            model.sectionName = titleArr[i];
            model.sectionID = [NSString stringWithFormat:@"%i", i];
            NSMutableArray *listArr = [[NSMutableArray alloc] init];
            for (int j = 0; j < num; j++) {
                NSString *tagName = [NSString stringWithFormat:@"%@%i", titleArr[i], j];
                NSString *tagID = [NSString stringWithFormat:@"%i", j];
                NSString *select = @"0";
                NSDictionary *dic = @{@"tagName":tagName, @"tagID":tagID, @"select":select};
                [listArr addObject:[dic mutableCopy]];
            }
            model.listArray = listArr;
            model.isClick = NO;
            
            [dataList addObject:model];
        }
        
        _copyArr = dataList;
    }
    return _copyArr;
}

@end
