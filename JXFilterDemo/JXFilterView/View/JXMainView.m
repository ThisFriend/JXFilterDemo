//
//  JXMainView.m
//  JXFilterDemo
//
//  Created by 姬祥 on 2018/11/15.
//  Copyright © 2018 姬祥. All rights reserved.
//

#import "JXMainView.h"
#import "JXCollectionHeadView.h"
#import "JXCollCell.h"
#import "JXFilterModel.h"
#import "JXMacro.h"

@interface JXMainView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

// 底部按钮
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@end

@implementation JXMainView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    [self addSubview:self.collectionView];
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    
    [self reloadCollectionView];
}

#pragma mark - Action
- (void)leftBtnClick
{
//    self.dataArr = [self createBaseArr];
//    [self reloadCollectionView];
    
    [self createCopyArrAndReload];
}

- (void)rightBtnClick
{
    NSMutableArray *returnArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.dataArr.count; i++) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        
        JXFilterModel *model = [self.dataArr objectAtIndex:i];
        NSArray *listArr = model.listArray;
        for (int j = 0; j < listArr.count; j++) {
            NSDictionary *dic = [listArr objectAtIndex:j];
            if ([dic[@"select"] isEqualToString:@"1"]) {
                [arr addObject:dic[@"tagID"]];
            }
        }
        [returnArr addObject:arr];
    }
    if (self.returnFilterArr) {
        self.returnFilterArr([returnArr copy]);
    }
}

- (void)reloadCollectionView
{
    [self.collectionView reloadData];
}

- (void)createCopyArrAndReload
{
    for (int i = 0; i < self.dataArr.count; i++) {
        JXFilterModel *model = [self.dataArr objectAtIndex:i];
        model.isClick = NO;
        NSMutableArray *listArr = model.listArray;
        
        for (int j = 0; j < listArr.count; j++) {
            NSMutableDictionary *dic = [listArr objectAtIndex:j];
            dic[@"select"] = @"0";
            [listArr replaceObjectAtIndex:j withObject:dic];
        }
        [self.dataArr replaceObjectAtIndex:i withObject:model];
    }
    [self reloadCollectionView];
}

- (NSMutableArray *)createBaseArr
{
    NSArray *titleArr = @[@"品牌", @"种类", @"型号", @"售价"];
    int num = 10;
    
    NSMutableArray *baseDataList = [[NSMutableArray alloc] init];
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
        
        [baseDataList addObject:model];
    }
    return baseDataList;
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
//        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        //设置headerView的尺寸大小
        layout.headerReferenceSize = CGSizeMake(self.frame.size.width, CollHeader_Height);
        //该方法也可以设置itemSize
        layout.itemSize = CGSizeMake(Tag_Width, Tag_Height);
        
        CGFloat height = UI_SCREEN_HEIGHT - NavStatusBar_Height - IPhoneX_FixHeight - BottomBtn_Height;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.f, NavStatusBar_Height, self.frame.size.width, height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[JXCollCell class] forCellWithReuseIdentifier:@"cellId"];
        //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
        [_collectionView registerClass:[JXCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    }
    return _collectionView;
}

- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0.f, UI_SCREEN_HEIGHT - IPhoneX_FixHeight - BottomBtn_Height, MainView_Width/2, BottomBtn_Height);
        _leftBtn.backgroundColor = BottomBtn_Left_Color;
        [_leftBtn setTitle:@"重置" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:BottomBtn_Left_TxtColor forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:Bottom_Font];
        [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(MainView_Width/2, UI_SCREEN_HEIGHT - IPhoneX_FixHeight - BottomBtn_Height, MainView_Width/2, BottomBtn_Height);
        _rightBtn.backgroundColor = BottomBtn_Right_Color;
        [_rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:BottomBtn_Right_TxtColor forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:Bottom_Font];
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (NSMutableArray *)originalArr
{
    if (!_originalArr) {
        _originalArr = [[NSMutableArray alloc] init];
    }
    return _originalArr;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArr.count;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    JXFilterModel *model = [self.dataArr objectAtIndex:section];
    NSArray *arr = model.listArray;
    NSInteger count = arr.count;
    
    if (model.isClick) {
        return count;
    } else {
        CGFloat minCount = Tag_Custom_ItemNum * Tag_Custom_LineNum;
        return minCount >= count ? count : minCount;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JXCollCell *cell = (JXCollCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    JXFilterModel *model = [self.dataArr objectAtIndex:indexPath.section];
    NSArray *listArr = model.listArray;
    NSDictionary *dic = [listArr objectAtIndex:indexPath.row];
    
    cell.label.text = dic[@"tagName"];
    if ([dic[@"select"] isEqualToString:@"1"]) {
        cell.layer.borderWidth = 1.f;
        cell.layer.borderColor = Tag_Custom_SelectBg.CGColor;
        cell.label.textColor = Tag_Custom_TxtSelectColor;
    } else {
        cell.layer.borderWidth = 0.f;
        cell.label.textColor = Tag_Custom_TxtColor;
    }
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(Tag_Width, Tag_Height);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(Tag_Custom_ItemSpace, MainView_LeftRightSpace, Tag_Custom_ItemSpace, MainView_LeftRightSpace);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return Tag_Custom_ItemSpace;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return Tag_Custom_LineSpace;
}


//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    JXFilterModel *model = [self.dataArr objectAtIndex:indexPath.section];
    NSMutableArray *listArr = model.listArray;
    NSMutableString *str = [[NSMutableString alloc] init];
    for (int i = 0; i < listArr.count; i++) {
        NSDictionary *dic = [listArr objectAtIndex:i];
        if ([dic[@"select"] isEqualToString:@"1"]) {
            if (str.length > 0) {
                [str appendString:@","];
            }
            [str appendString:dic[@"tagName"]];
        }
    }
    
    JXCollectionHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    headerView.isClick = model.isClick;
    headerView.strSelect = str;
    WEAKSELF
    headerView.btnClickBlock = ^{
        model.isClick = !model.isClick;
        [weakSelf.dataArr replaceObjectAtIndex:indexPath.section withObject:model];
        [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    };
    return headerView;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JXFilterModel *model = [self.dataArr objectAtIndex:indexPath.section];
    NSMutableArray *listArr = model.listArray;
    NSMutableDictionary *dic = [listArr objectAtIndex:indexPath.row];
    if ([dic[@"select"] isEqualToString:@"1"]) {
        dic[@"select"] = @"0";
    } else {
        dic[@"select"] = @"1";
    }
    [listArr replaceObjectAtIndex:indexPath.row withObject:dic];
    model.listArray = listArr;
    [self.dataArr replaceObjectAtIndex:indexPath.section withObject:model];
    
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
//    JXCollCell *cell = (JXCollCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    NSString *msg = cell.label.text;
}

@end
