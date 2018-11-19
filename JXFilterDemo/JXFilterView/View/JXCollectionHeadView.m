//
//  JXCollectionHeadView.m
//  JXFilterDemo
//
//  Created by 姬祥 on 2018/11/15.
//  Copyright © 2018 姬祥. All rights reserved.
//

#import "JXCollectionHeadView.h"
#import "JXMacro.h"

#define lbl_width 60.f
#define igv_width 15.f
#define igv_height 9.f
#define space 5.f
@interface JXCollectionHeadView()

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblCustom;
@property (nonatomic, strong) UIImageView *igvSelect;
@property (nonatomic, strong) UILabel *lblSelect;
@property (nonatomic ,strong) UIButton *tapBtn;

@end

@implementation JXCollectionHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    [self addSubview:self.lblTitle];
    [self addSubview:self.igvSelect];
    [self addSubview:self.lblCustom];
    [self addSubview:self.lblSelect];
    [self addSubview:self.tapBtn];
}

#pragma mark - Action
- (void)showMoreTag
{
    if (self.btnClickBlock) {
        self.btnClickBlock();
    }
}

- (void)setStrSelect:(NSString *)strSelect
{
    _strSelect = strSelect;
    if (strSelect.length > 0) {
        self.lblSelect.hidden = NO;
        self.lblCustom.hidden = YES;
        self.lblSelect.text = strSelect;
    } else {
        self.lblSelect.hidden = YES;
        self.lblCustom.hidden = NO;
        self.lblSelect.text = @"";
    }
}

- (void)setIsClick:(BOOL)isClick
{
    _isClick = isClick;
    if (self.isClick) {
        self.igvSelect.image = [UIImage imageNamed:@"CV_Fold"];
    } else {
        self.igvSelect.image = [UIImage imageNamed:@"CV_Open"];
    }
}

#pragma mark - 懒加载
- (UILabel *)lblTitle
{
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(MainView_LeftRightSpace, 0.f, lbl_width, self.frame.size.height)];
        _lblTitle.font = [UIFont systemFontOfSize:Title_Font];
        _lblTitle.text = @"品牌";
    }
    return _lblTitle;
}

- (UILabel *)lblCustom
{
    if (!_lblCustom) {
        CGFloat x = self.frame.size.width - MainView_LeftRightSpace - igv_width - lbl_width - space;
        _lblCustom = [[UILabel alloc] initWithFrame:CGRectMake(x, 0.f, lbl_width, self.frame.size.height)];
        _lblCustom.text = @"全部";
        _lblCustom.font = [UIFont systemFontOfSize:Title_Font];
        _lblCustom.textAlignment = NSTextAlignmentRight;
    }
    return _lblCustom;
}

- (UIImageView *)igvSelect
{
    if (!_igvSelect) {
        CGFloat x = self.frame.size.width - MainView_LeftRightSpace - igv_width;
        CGFloat y = (self.frame.size.height - igv_height) / 2;
        _igvSelect = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, igv_width, igv_height)];
        _igvSelect.image = [UIImage imageNamed:@"CV_Open"];
    }
    return _igvSelect;
}

- (UILabel *)lblSelect
{
    if (!_lblSelect) {
        CGFloat x = MainView_LeftRightSpace + lbl_width + space;
        CGFloat width = self.frame.size.width - 2 * MainView_LeftRightSpace - igv_width - lbl_width - 2 * space;
        _lblSelect = [[UILabel alloc] initWithFrame:CGRectMake(x, 0.f, width, self.frame.size.height)];
        _lblSelect.font = [UIFont systemFontOfSize:Tag_Font];
        _lblSelect.textAlignment = NSTextAlignmentRight;
        _lblSelect.textColor = CollHeader_SelectColor;
        _lblSelect.text = @"三星，苹果，华为，小米";
        _lblSelect.hidden = YES;
    }
    return _lblSelect;
}

- (UIButton *)tapBtn
{
    if (!_tapBtn) {
        _tapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _tapBtn.frame = self.bounds;
        [_tapBtn addTarget:self action:@selector(showMoreTag) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tapBtn;
}

@end
