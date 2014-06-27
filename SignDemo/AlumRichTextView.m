//
//  AlumRichTextView.m
//  SignDemo
//
//  Created by ylang on 14-6-27.
//  Copyright (c) 2014年 ylang. All rights reserved.
//

#import "AlumRichTextView.h"
#import "AlbumPhotoCollectionViewCell.h"
#import "AlbumCollectionViewFlowLayout.h"
#import "UIColor+Random.h"

// 头像大小以及头像与其他控件的距离
static CGFloat const kAvatarImageSize = 40.0f;
static CGFloat const kAlbumAvatorSpacing = 15.0f;



#define kPhotoCollectionViewCellIdentifier @"PhotoCollectionViewCellIdentifier"

@interface AlumRichTextView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView *avatorImageView;
@property (nonatomic, strong) UILabel *userNameLabel;

@property (nonatomic, strong) UICollectionView *sharePhotoCollectionView;

@property (nonatomic, strong) UILabel *timestampLabel;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic,strong)UIButton *superButton;
@property (nonatomic, strong) UIView *commentView;

@end

@implementation AlumRichTextView



//得到文本高度
+ (CGFloat)getRichTextHeightWithText:(NSString *)text {
    if (!text || !text.length)
        return 0;
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary * normal = @{NSForegroundColorAttributeName:
                                  [UIColor colorWithRed:0.5255f green:0.5255f blue:0.5255f alpha:1],NSFontAttributeName: [UIFont systemFontOfSize:13],NSParagraphStyleAttributeName: paragraphStyle};
    NSMutableAttributedString * attribute = [[NSMutableAttributedString alloc] initWithString:text attributes:normal];
 
    CGRect contentbounds = [attribute boundingRectWithSize:CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - kAvatarImageSize - (kAlbumAvatorSpacing * 3), CGFLOAT_MAX)
                                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                                     context:nil];
    
    return contentbounds.size.height;
}
//图片结合高度
+ (CGFloat)getSharePhotoCollectionViewHeightWithPhotos:(NSArray *)photos {
    // 上下间隔已经在frame上做了
    NSInteger row = (photos.count / 3 + (photos.count % 3 ? 1 : 0));
    return (row * (kAlbumPhotoSize) + ((row - 1) * kAlbumPhotoInsets));
}
//得到评论和赞的高度
+(CGFloat)getCommentViewHeightWithComments:(NSArray *)comments
{
    if ([comments count] >0)
    {
        return 40 * [comments count];
    }
    return 0;
}

//得到Frame size
+ (CGFloat)calculateRichTextHeightWithAlbum:(Album *)currentAlbum {
    CGFloat richTextHeight = kAlbumAvatorSpacing * 2;
    
    richTextHeight += kAlbumUserNameHeigth;
    
    richTextHeight += kAlbumContentLineSpacing;
    richTextHeight += [self getRichTextHeightWithText:currentAlbum.albumShareContent];
    
    richTextHeight += kAlbumPhotoInsets;
    richTextHeight += [self getSharePhotoCollectionViewHeightWithPhotos:currentAlbum.albumSharePhotos];
    
    richTextHeight += [self getCommentViewHeightWithComments:currentAlbum.albumShareComments];
    
    
    richTextHeight += kAlbumContentLineSpacing;
    richTextHeight += kAlbumCommentButtonHeight;
    
    return richTextHeight;
}
//设置值
- (void)setDisplayAlbum:(Album *)displayAlbum
{
    _displayAlbum = displayAlbum;
    
    self.userNameLabel.text = displayAlbum.userName;
    
    self.richTextView.attributedText = [[NSAttributedString alloc] initWithString:displayAlbum.albumShareContent];
    
    self.timestampLabel.text = @"now";
    
    self.commentView.backgroundColor = [UIColor randomColor];
    
    [self.sharePhotoCollectionView reloadData];
    
    [self setNeedsLayout];

}

//头像
- (UIImageView *)avatorImageView {
    if (!_avatorImageView) {
        _avatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kAlbumAvatorSpacing, kAlbumAvatorSpacing, kAvatarImageSize, kAvatarImageSize)];
        _avatorImageView.image = [UIImage imageNamed:@"avator"];
    }
    return _avatorImageView;
}
//名字
- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        CGFloat userNameLabelX = CGRectGetMaxX(self.avatorImageView.frame) + kAlbumAvatorSpacing;
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(userNameLabelX, CGRectGetMinY(self.avatorImageView.frame), CGRectGetWidth([[UIScreen mainScreen] bounds]) - userNameLabelX - kAlbumAvatorSpacing, kAlbumUserNameHeigth)];
        _userNameLabel.backgroundColor = [UIColor clearColor];
        _userNameLabel.textColor = [UIColor colorWithRed:0.294 green:0.595 blue:1.000 alpha:1.000];
        
    }
    return _userNameLabel;
}
//文本内容
- (UITextView *)richTextView {
    if (!_richTextView) {
        _richTextView = [[UITextView alloc] initWithFrame:self.bounds];
        _richTextView.backgroundColor = [UIColor clearColor];
        _richTextView.font = self.font;
        _richTextView.textColor = self.textColor;
        _richTextView.textAlignment = self.textAlignment;
    }
    return _richTextView;
}
//图片集合
- (UICollectionView *)sharePhotoCollectionView {
    if (!_sharePhotoCollectionView) {
        _sharePhotoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[AlbumCollectionViewFlowLayout alloc] init]];
        _sharePhotoCollectionView.backgroundColor = self.richTextView.backgroundColor;
        [_sharePhotoCollectionView registerClass:[AlbumPhotoCollectionViewCell class] forCellWithReuseIdentifier:kPhotoCollectionViewCellIdentifier];
        [_sharePhotoCollectionView setScrollsToTop:NO];
        _sharePhotoCollectionView.delegate = self;
        _sharePhotoCollectionView.dataSource = self;
    }
    return _sharePhotoCollectionView;
}
//时间
- (UILabel *)timestampLabel {
    if (!_timestampLabel) {
        _timestampLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timestampLabel.backgroundColor = [UIColor clearColor];
        _timestampLabel.font = [UIFont systemFontOfSize:11];
        _timestampLabel.textColor = [UIColor grayColor];
    }
    return _timestampLabel;
}
//评论
- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_commentButton setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
        [_commentButton setImage:[UIImage imageNamed:@"AlbumOperateMoreHL"] forState:UIControlStateHighlighted];
        [_commentButton addTarget:self action:@selector(commentButotnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentButton;
}
//赞按钮
- (UIButton *)superButton
{
    if (!_superButton)
    {
        _superButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_superButton setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
        [_superButton setImage:[UIImage imageNamed:@"AlbumOperateMoreHL"] forState:UIControlStateHighlighted];
        
//        [_superButton setTitle:@"赞" forState:UIControlStateNormal];
    }
    return _superButton;
}
//赞内容和评论
- (UIView *)commentView
{
    if (!_commentView)
    {
        _commentView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _commentView;
}


#pragma mark - 事件处理

- (void)commentButotnClick:(id)sender
{
    NSLog(@"----------%d",self.tag);
    [[NSUserDefaults standardUserDefaults] setInteger:self.tag forKey:@"IndexRow"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationSupport
                                                        object:nil];
}
#pragma mark - 初始化程序
- (void)setUp
{
    self.font = kAlbumContentFont;
    self.textColor = [UIColor blackColor];
    self.textAlignment = NSTextAlignmentLeft;
    self.lineSpacing = kAlbumContentLineSpacing;

    [self addSubview:self.avatorImageView];
    [self addSubview:self.userNameLabel];
    
    [self addSubview:self.richTextView];
    [self addSubview:self.sharePhotoCollectionView];
    
    [self addSubview:self.timestampLabel];
    [self addSubview:self.commentButton];
    
    [self addSubview:self.superButton];
    
    [self addSubview:self.commentView];
    
}
#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat richTextViewX = CGRectGetMinX(self.userNameLabel.frame);
    CGRect richTextViewFrame = CGRectMake(richTextViewX, CGRectGetMaxY(self.userNameLabel.frame) + kAlbumContentLineSpacing, CGRectGetWidth([[UIScreen mainScreen] bounds]) - richTextViewX - kAlbumAvatorSpacing, [AlumRichTextView getRichTextHeightWithText:self.displayAlbum.albumShareContent]);
    self.richTextView.frame = richTextViewFrame;
    
    CGRect sharePhotoCollectionViewFrame = CGRectMake(richTextViewX, CGRectGetMaxY(richTextViewFrame) + kAlbumPhotoInsets, kAlbumPhotoInsets * 4 + kAlbumPhotoSize * 3, [AlumRichTextView getSharePhotoCollectionViewHeightWithPhotos:self.displayAlbum.albumSharePhotos]);
    self.sharePhotoCollectionView.frame = sharePhotoCollectionViewFrame;
    
    CGRect commentButtonFrame = self.commentButton.frame;
    commentButtonFrame.origin = CGPointMake(CGRectGetWidth(self.bounds) - kAlbumAvatorSpacing - kAlbumCommentButtonWidth, CGRectGetMaxY(sharePhotoCollectionViewFrame) + kAlbumContentLineSpacing);
    commentButtonFrame.size = CGSizeMake(kAlbumCommentButtonWidth, kAlbumCommentButtonHeight);
    self.commentButton.frame = commentButtonFrame;
    
    CGRect superButtonFrame = self.superButton.frame;
    superButtonFrame.origin = CGPointMake(CGRectGetWidth(self.bounds) - kAlbumAvatorSpacing - kAlbumCommentButtonWidth * 2, CGRectGetMaxY(sharePhotoCollectionViewFrame) + kAlbumContentLineSpacing);
    superButtonFrame.size = CGSizeMake(kAlbumCommentButtonWidth, kAlbumCommentButtonHeight);
    self.superButton.frame = superButtonFrame;
    
    
    CGRect timestampLabelFrame = self.timestampLabel.frame;
    timestampLabelFrame.origin = CGPointMake(CGRectGetMinX(richTextViewFrame), CGRectGetMinY(commentButtonFrame));
    timestampLabelFrame.size = CGSizeMake(CGRectGetWidth(self.bounds) - kAlbumAvatorSpacing * 3 - kAvatarImageSize - kAlbumCommentButtonWidth, CGRectGetHeight(commentButtonFrame));
    self.timestampLabel.frame = timestampLabelFrame;
    
    CGRect commentVieFrame = self.commentView.frame;
    commentVieFrame = CGRectMake(richTextViewX, CGRectGetMaxY(commentButtonFrame) + kAlbumContentLineSpacing, CGRectGetWidth([[UIScreen mainScreen] bounds]) - richTextViewX - kAlbumAvatorSpacing, [AlumRichTextView getCommentViewHeightWithComments:self.displayAlbum.albumShareComments]);
    self.commentView.frame = commentVieFrame;
    
    CGRect frame = self.frame;
    frame.size.height = CGRectGetMaxY(commentVieFrame);
    self.frame = frame;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)dealloc {
    self.font = nil;
    self.textColor = nil;
    self.richTextView = nil;
    _displayAlbum = nil;
    
    self.avatorImageView = nil;
    self.userNameLabel = nil;
    self.sharePhotoCollectionView.delegate = nil;
    self.sharePhotoCollectionView.dataSource = nil;
    self.sharePhotoCollectionView = nil;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.displayAlbum.albumSharePhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AlbumPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoCollectionViewCellIdentifier forIndexPath:indexPath];
    
    cell.indexPath = indexPath;
    
    return cell;
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self showImageViewerAtIndexPath:indexPath];
}

- (void)showImageViewerAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"^^^^^^^^^^^^^^^^^^^^^%d",indexPath.row);
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
