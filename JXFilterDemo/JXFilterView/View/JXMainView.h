//
//  JXMainView.h
//  JXFilterDemo
//
//  Created by 姬祥 on 2018/11/15.
//  Copyright © 2018 姬祥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ReturnFilterArr) (NSArray *arr);
@interface JXMainView : UIView

/*
 * 传入的数据  示例:
 
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
 
 */
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *originalArr; // 用来记录原始的数据，方便重置

@property (nonatomic, copy) ReturnFilterArr returnFilterArr;

@end

NS_ASSUME_NONNULL_END
