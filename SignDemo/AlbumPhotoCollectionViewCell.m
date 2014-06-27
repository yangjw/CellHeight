//
//  AlbumPhotoCollectionViewCell.m
//  SignDemo
//
//  Created by ylang on 14-6-27.
//  Copyright (c) 2014年 ylang. All rights reserved.
//

#import "AlbumPhotoCollectionViewCell.h"

@implementation AlbumPhotoCollectionViewCell

- (UIImageView *)photoImageView {
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _photoImageView.backgroundColor = [UIColor redColor];
    }
    return _photoImageView;
}

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self.contentView addSubview:self.photoImageView];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
