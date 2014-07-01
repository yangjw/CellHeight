//
//  CommentView.h
//  SignDemo
//
//  Created by ylang on 14-6-30.
//  Copyright (c) 2014年 ylang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentView : UIView

@property(nonatomic,strong)NSMutableArray *commentArray;


+(CGFloat)getHeightWithComments:(NSMutableArray *)comments;
@end
