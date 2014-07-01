//
//  Album.h
//  SignDemo
//
//  Created by ylang on 14-6-27.
//  Copyright (c) 2014年 ylang. All rights reserved.
//

#import <Foundation/Foundation.h>

// 朋友圈分享人的名称高度
#define kAlbumUserNameHeigth 18

// 朋友圈分享的图片以及图片之间的间隔
#define kAlbumPhotoSize 60
#define kAlbumPhotoInsets 5

// 朋友圈分享内容字体和间隔
#define kAlbumContentFont [UIFont systemFontOfSize:13]
#define kAlbumContentLineSpacing 4

// 朋友圈评论按钮大小
#define kAlbumCommentButtonWidth 25
#define kAlbumCommentButtonHeight 25

@interface Album : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *profileAvatorUrlString;

@property (nonatomic, copy) NSString *albumShareContent;

@property (nonatomic, strong) NSArray *albumSharePhotos;

@property (nonatomic, strong) NSMutableArray *albumShareComments;

@property (nonatomic, strong) NSMutableArray *albumShareLikes;

@property (nonatomic, strong) NSDate *timestamp;

@end


