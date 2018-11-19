//
//  JXMacro.h
//  JXFilterDemo
//
//  Created by 姬祥 on 2018/11/15.
//  Copyright © 2018 姬祥. All rights reserved.
//

#ifndef JXMacro_h
#define JXMacro_h

#import "UIColor+HexColor.h"
#import "UIView+DDAddition.h"

// 背景色的透明度
#define ScreenView_Alpha 0.5f
// 背景加载和消失的时间
#define ScreenView_Duration 0.2f
// 筛选主页面距离左边的宽度 屏占比
#define MainView_Left 0.2f
#define MainView_Width (UI_SCREEN_WIDTH * (1 - MainView_Left))
// 筛选主页左右留白间距
#define MainView_LeftRightSpace 15.f

/*
 * 标题部分，头部的属性
 */
// 每组数据的头部高度
#define CollHeader_Height           44.f
// 头部标题字体大小
#define Title_Font                  15.f
// 头部选中字体的颜色
#define CollHeader_SelectColor      [UIColor colorWithHexString:@"ff8c3c"]


/*
 * 每个标签的属性
 */
// 每行标签数
#define Tag_Custom_ItemNum          3.f
// 默认展示的标签行数
#define Tag_Custom_LineNum          2.f
// 每个标签之间的间距
#define Tag_Custom_ItemSpace        10.f
// 每行标签之间的行间距
#define Tag_Custom_LineSpace        15.f
// 每个标签的宽度
#define Tag_Width ((MainView_Width - 2*(MainView_LeftRightSpace) - (Tag_Custom_ItemNum-1)*Tag_Custom_ItemSpace)/Tag_Custom_ItemNum)
// 每个标签的高度
#define Tag_Height                  30.f
// 每个标签的高度
#define Tag_Height                  30.f
// 标签的字体大小
#define Tag_Font                    13.f
// 每个标签的原始背景 RGB(244,245,246)
#define Tag_Custom_Bg               [UIColor colorWithHexString:@"f4f5f6"]
// 每个标签的选中颜色 RGB(50,150,250)
#define Tag_Custom_SelectBg         [UIColor colorWithHexString:@"ff8c3c"]
// 每个标签的文字颜色
#define Tag_Custom_TxtColor         [UIColor colorWithHexString:@"333333"]
// 每个标签的文字选中颜色
#define Tag_Custom_TxtSelectColor   [UIColor colorWithHexString:@"ff8c3c"]


/*
 * 底部按钮的属性     重置 / 确定
 */
// 底部按钮的高度
#define BottomBtn_Height            44.f
// 底部按钮的颜色 - 重置
#define BottomBtn_Left_Color        [UIColor colorWithHexString:@"f4f5f6"]
// 底部按钮字体的颜色 - 重置
#define BottomBtn_Left_TxtColor     [UIColor colorWithHexString:@"333333"]
// 底部按钮的颜色 - 确定
#define BottomBtn_Right_Color       [UIColor colorWithHexString:@"ff8c3c"]
// 底部按钮的字体颜色 - 确定
#define BottomBtn_Right_TxtColor    [UIColor colorWithHexString:@"ffffff"]
// 底部按钮的字体大小
#define Bottom_Font                 16.f




// 屏幕宽度、高度、几倍屏
#define UI_SCREEN_WIDTH             ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT            ([[UIScreen mainScreen] bounds].size.height)
#define UI_CONTENT_HEIGHT           (UI_SCREEN_HEIGHT - NavBar_Height)
#define UI_CONTENT_MAXY             (UI_SCREEN_HEIGHT - IPhoneX_FixHeight)

// 判断系统版本号
#ifndef SYSTEM_VERSION
#define SYSTEM_VERSION  ([[[UIDevice currentDevice] systemVersion] doubleValue])
#endif
#define IOS8            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)
#define IOS9            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 9.0)
#define IOS10           ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0)

#define IS_IPHONE4      (UI_SCREEN_HEIGHT == 480)
#define IS_IPHONE5      (([[UIScreen mainScreen] bounds].size.height == 568) ? YES : NO)
#define IS_IPhone6      (667 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)
#define IS_IPhone6plus  (736 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)
#define IS_IPhoneX      (((int)((UI_SCREEN_HEIGHT/UI_SCREEN_WIDTH)*100) == 216)?YES:NO)

#define IPhoneX_FixHeight   (IS_IPhoneX ? 34 : 0) //UITabBar高度 iPhone X 偏差34
#define TabBar_Height       (IS_IPhoneX ? 83 : 49)//UITabBar高度 iPhone X = 83，其他49
#define NavBar_Height       (IS_IPhoneX ? 88 : 64)//导航栏高度 iPhone X = 88，其他64
#define NavStatusBar_Height (IS_IPhoneX ? 44 : 20) //状态栏高度 iPhone X = 44，其他20
#define EPContentViewHeight (UI_SCREEN_HEIGHT - NavBar_Height - IPhoneX_FixHeight) // 内容高度
#define EPContentViewFrame  CGRectMake(0, 0, UI_SCREEN_WIDTH, EPContentViewHeight) // 内容尺寸

// 颜色定义
#define RGBA(r,g,b,a)               [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b)                  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define RGB_HEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 随机色
#define RandomColor RGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1.f)

#define WEAKSELF __weak typeof(self) weakSelf = self;


#endif /* JXMacro_h */
