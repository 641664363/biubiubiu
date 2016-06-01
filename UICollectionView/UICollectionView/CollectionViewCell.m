//
//  CollectionViewCell.m
//  UICollectionView
//
//  Created by Sure on 15-9-2.
//  Copyright (c) 2015年 Sure. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        
        [self.contentView addSubview:self.headImageView];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, frame.size.width, frame.size.height - 30)];
        
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        
        self.nameLabel.font = [UIFont boldSystemFontOfSize:20];
        
        self.nameLabel.textColor = [UIColor greenColor];
        
        [self.headImageView addSubview:self.nameLabel];
    }
    return self;
}

@end
