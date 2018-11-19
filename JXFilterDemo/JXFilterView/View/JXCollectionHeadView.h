//
//  JXCollectionHeadView.h
//  JXFilterDemo
//
//  Created by 姬祥 on 2018/11/15.
//  Copyright © 2018 姬祥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BtnClickBlock)(void);
@interface JXCollectionHeadView : UICollectionReusableView

@property (nonatomic, assign) BOOL isClick;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *strSelect;
@property (nonatomic, copy) BtnClickBlock btnClickBlock;

//@property (nonatomic, strong) void(^btnClickBlock)(void);

@end

NS_ASSUME_NONNULL_END
