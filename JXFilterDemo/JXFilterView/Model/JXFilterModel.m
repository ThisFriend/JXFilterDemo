//
//  JXFilterModel.m
//  JXFilterDemo
//
//  Created by 姬祥 on 2018/11/15.
//  Copyright © 2018 姬祥. All rights reserved.
//

#import "JXFilterModel.h"

@implementation JXFilterModel

/**
 *  初始化
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.listArray =[NSMutableArray array];
        self.sectionName = [[NSString alloc]init];
        self.sectionID = [[NSString alloc]init];
        self.isClick = NO;
    }
    return self;
}

- (JXFilterModel *)copyObject
{
    JXFilterModel *model = [[JXFilterModel alloc] init];
    
    model.listArray = [self.listArray mutableCopy];
    model.sectionName = self.sectionName;
    model.sectionID = self.sectionID;
    model.isClick = self.isClick;
    
    return model;
}

@end
