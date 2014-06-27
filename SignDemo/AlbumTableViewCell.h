//
//  AlbumTableViewCell.h
//  SignDemo
//
//  Created by ylang on 14-6-27.
//  Copyright (c) 2014年 ylang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"

@interface AlbumTableViewCell : UITableViewCell

@property(nonatomic,strong)Album *currentAlbum;

+ (CGFloat)calculateCellHeightWithAlbum:(Album *)currentAlbum;

@end
