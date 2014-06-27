//
//  AlbumTableViewCell.m
//  SignDemo
//
//  Created by ylang on 14-6-27.
//  Copyright (c) 2014年 ylang. All rights reserved.
//

#import "AlbumTableViewCell.h"
#import "AlumRichTextView.h"

@interface AlbumTableViewCell()


@property(nonatomic,strong)AlumRichTextView *ablumRichTextView;
@end

@implementation AlbumTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}


- (void)setCurrentAlbum:(Album *)currentAlbum
{
    if (!currentAlbum)
        return;
     NSLog(@"$$$$$$$$$$$$$$$$$$$%d",self.tag);
    self.ablumRichTextView.tag = self.tag;
    
    self.ablumRichTextView.displayAlbum = currentAlbum;
}

- (AlumRichTextView *)ablumRichTextView
{
    if (!_ablumRichTextView)
    {
        _ablumRichTextView = [[AlumRichTextView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 40)];
    }
    return _ablumRichTextView;
}


+ (CGFloat)calculateCellHeightWithAlbum:(Album *)currentAlbum {
    
    return [AlumRichTextView calculateRichTextHeightWithAlbum:currentAlbum];
}


- (void)setup
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.ablumRichTextView];
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
