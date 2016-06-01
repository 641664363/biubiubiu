//
//  MyCollectionReusableView.m
//  UICollectionView
//
//  Created by Sure on 15-9-2.
//  Copyright (c) 2015年 Sure. All rights reserved.
//

#import "MyCollectionReusableView.h"

@implementation MyCollectionReusableView

//自定义段头段尾内容
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.myLabel = [[UILabel alloc]initWithFrame:self.bounds];
        
        self.myLabel.textAlignment = NSTextAlignmentCenter;
        
        self.myLabel.textColor = [UIColor greenColor];
        
        //加入到段上
        [self addSubview:self.myLabel];
    }
    return self;
}

@end
