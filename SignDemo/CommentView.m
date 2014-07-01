//
//  CommentView.m
//  SignDemo
//
//  Created by ylang on 14-6-30.
//  Copyright (c) 2014年 ylang. All rights reserved.
//

#import "CommentView.h"

#define KCommentTableViewCellIdentifier @"CommentTableViewCellIdentifier"

#import "TestView.h"

@interface CommentView()<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property(nonatomic,strong)UITableView *commentTableView;
@end

@implementation CommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (UITableView *)commentTableView
{
    if (!_commentTableView)
    {
        _commentTableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _commentTableView.delegate = self;
        _commentTableView.dataSource = self;
        _commentTableView.showsVerticalScrollIndicator = NO;
        _commentTableView.scrollEnabled = NO;
      _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return _commentTableView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect rect = self.commentTableView.frame;
    rect = CGRectMake(0, 0, self.frame.size.width, [CommentView getHeightWithComments:self.commentArray]);
    self.commentTableView.frame = rect;
    
//    self.frame = rect;
}

- (void)setUp
{
    [self addSubview:self.commentTableView];
    
}

+ (CGFloat)getHeightWithComments:(NSMutableArray *)comments
{
    return [comments count] * 44 + 60 + 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    TestView *test = [[TestView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
//    test.userInteractionEnabled = YES;
//    test.backgroundColor = [UIColor clearColor];
//    return test;
    
    UITableViewHeaderFooterView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Head"];
    if (!head)
    {
        head = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"Head"];
    }
    TestView *test = [[TestView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
    test.userInteractionEnabled = YES;
    test.backgroundColor = [UIColor clearColor];

    [head.contentView addSubview:test];
    return head;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.commentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCommentTableViewCellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:KCommentTableViewCellIdentifier];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self.commentArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"当前项%d",indexPath.row] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
}

- (void)setCommentArray:(NSMutableArray *)commentArray
{
    _commentArray = commentArray;
    
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
    v.backgroundColor = [UIColor blueColor];
    self.commentTableView.tableHeaderView = v;
    [self.commentTableView reloadData];
    [self setNeedsLayout];
}


//- (void)setUp
//{
//    NSLog(@">>>>>>>>>>>>>>>>>>>>>%@",_commentArray);
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
