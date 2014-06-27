//
//  Album.m
//  SignDemo
//
//  Created by ylang on 14-6-27.
//  Copyright (c) 2014年 ylang. All rights reserved.
//

#import "Album.h"

@implementation Album

- (instancetype)init
{
    self = [super init];
    if (self) {
        _albumShareLikes = [[NSMutableArray alloc] init];
        _albumSharePhotos = [[NSArray alloc] init];
        _albumShareComments = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
