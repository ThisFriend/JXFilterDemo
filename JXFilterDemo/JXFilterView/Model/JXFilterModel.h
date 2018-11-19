//
//  JXFilterModel.h
//  JXFilterDemo
//
//  Created by 姬祥 on 2018/11/15.
//  Copyright © 2018 姬祥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JXFilterModel : NSObject

/**
 *  每个section里面cell的数据
 */

@property (nonatomic, strong) NSMutableArray *listArray;  // [{@"tagName":@"华为", @"tagID":@"1", @"select":@"0"}];

/**
 *  每个section组数据
 */

@property (nonatomic, copy) NSString *sectionName;

/**
 *  ID
 */

@property (nonatomic, copy) NSString *sectionID;

/**
 *  是否被选中
 */

@property (nonatomic, assign) BOOL isClick;


- (JXFilterModel *)copyObject;


@end

NS_ASSUME_NONNULL_END
