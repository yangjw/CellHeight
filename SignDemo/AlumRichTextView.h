//
//  AlumRichTextView.h
//  SignDemo
//
//  Created by ylang on 14-6-27.
//  Copyright (c) 2014年 ylang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"


#define  NotificationSupport @"NotificationSupport"  //赞

@interface AlumRichTextView : UIView

@property(nonatomic,strong)UIColor *textColor;
@property(nonatomic,strong)UIFont *font;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) CGFloat lineSpacing;

@property (nonatomic, strong) UITextView *richTextView;

@property(nonatomic,strong)Album *displayAlbum;
+ (CGFloat)calculateRichTextHeightWithAlbum:(Album *)currentAlbum;
@end
