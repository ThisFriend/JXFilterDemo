# JXFilterDemo
模仿京东筛选，实现的简单的侧边筛选Demo
##

## 效果图如下：
![效果图](/Img/soogif1.gif)

## 说明
传入的数据这里是写死的，可以查看 `JXFilterModel.h`，可以根据自己的数据结构随意修改。
点击确定由block返回的数据也可以自行修改，代码写的很简单，看后就懂。

Demo中数据结构示例如下：
```
 [
    {
        @"sectionID": @"1",
        @"sectionName": @"品牌",
        @"isClick": NO,  // 是否展开该组数据，默认为NO
        @"listArray": [
            {
                @"tagID": @"11",
                @"tagName": @"苹果",
                @"select": @"0", // 该字段是否被选中， 默认为0，否
            }
        ]
    }
 ]
```


## 使用方法

在需要显示的ViewController中引入
```
#import "JXScreenView.h"
#import "JXMacro.h" // 基础属性和参数配置


@property (nonatomic, strong) JXScreenView *screenView;
```

然后懒加载该控件
```
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
```

在你需要的地方调用
```
- (void)startFilter
{
    self.screenView.mainView.dataArr = self.dataArr; // 赋值的方法写在合适的地方即可
    self.screenView.hidden = NO;
    WEAKSELF
    [UIView animateWithDuration:ScreenView_Duration animations:^{
        weakSelf.screenView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    }];
}
```
