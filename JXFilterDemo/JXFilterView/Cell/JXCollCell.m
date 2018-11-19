//
//  JXCollCell.m
//  JXFilterDemo
//
//  Created by 姬祥 on 2018/11/15.
//  Copyright © 2018 姬祥. All rights reserved.
//

#import "JXCollCell.h"
#import "JXMacro.h"

@implementation JXCollCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Tag_Width, Tag_Height)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = Tag_Custom_TxtColor;
        _label.font = [UIFont systemFontOfSize:Tag_Font];
        _label.backgroundColor = Tag_Custom_Bg;
        _label.layer.cornerRadius = 4.f;
        _label.layer.masksToBounds = YES;
        [self.contentView addSubview:_label];
    }
    
    return self;
}

@end
