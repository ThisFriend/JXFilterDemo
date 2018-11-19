//
//  JXScreenView.h
//  JXFilterDemo
//
//  Created by 姬祥 on 2018/11/15.
//  Copyright © 2018 姬祥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXMainView.h"
#import "JXFilterModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ReturnFilterArr) (NSArray *arr);
@interface JXScreenView : UIView

@property (nonatomic, strong) JXMainView *mainView;
@property (nonatomic, copy) ReturnFilterArr returnFilterArr;

@end

NS_ASSUME_NONNULL_END
