//
//  AlbumCollectionViewFlowLayout.m
//  SignDemo
//
//  Created by ylang on 14-6-27.
//  Copyright (c) 2014年 ylang. All rights reserved.
//

#import "AlbumCollectionViewFlowLayout.h"
#import "Album.h"

@implementation AlbumCollectionViewFlowLayout

- (id)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(kAlbumPhotoSize, kAlbumPhotoSize);
        self.minimumInteritemSpacing = kAlbumPhotoInsets;
        self.minimumLineSpacing = kAlbumPhotoInsets;
    }
    return self;
}


@end
