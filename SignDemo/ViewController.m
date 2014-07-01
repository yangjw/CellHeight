//
//  ViewController.m
//  SignDemo
//
//  Created by ylang on 14-6-24.
//  Copyright (c) 2014年 ylang. All rights reserved.
//

#import "ViewController.h"
#import "NSString+MD5.h"
#import "AlbumTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *merchantImage;
    NSMutableArray *albumConfigureArray;
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    "v": "1.0",
//    "access_token": "ec9e57913c5b42b282ab7b743559e1b0",
//    "call_id": 1232095295656
//
    merchantImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_BBCV02797341115212217734.jpg"]];
//    merchantImage.contentMode = UIViewContentModeScaleAspectFit;
//    merchantImage.image = [UIImage imageNamed:@"_BBCV02797341115212217734.jpg"];
    
    
//    _table.tableHeaderView = merchantImage;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"1232095295656" forKey:@"call_id"];
    [dic setValue:@"ec9e57913c5b42b282ab7b743559e1b0" forKey:@"access_token"];
    [dic setValue:@"1.0" forKey:@"v"];
    

    NSLog(@"**********%@",[SignString requestDic:dic]);
    
    
    albumConfigureArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 60; i ++) {
        Album *currnetAlbum = [[Album alloc] init];
        currnetAlbum.userName = @"test";
        currnetAlbum.profileAvatorUrlString = @"http://www.baidu.com";
        currnetAlbum.albumShareContent = @"足球教练在赛前对他的队员们面授机宜：“你们抢不到球，就往对方腿上踢！” 　　一队员忽然道：“比赛用的球去那儿了？” 　　另一队员：“不用找了，没球一样踢。”";
         currnetAlbum.albumSharePhotos = [NSArray arrayWithObjects:@"http://www.baidu.com", @"http://www.baidu.com", @"http://www.baidu.com", @"http://www.baidu.com",@"http://www.baidu.com", @"http://www.baidu.com", @"http://www.baidu.com", @"http://www.baidu.com", nil];
        currnetAlbum.timestamp = [NSDate date];
        [albumConfigureArray addObject:currnetAlbum];
    }
    
//     [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationSupport" object:nil userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCell:) name:@"NotificationSupport" object:nil];
}

- (void)reloadCell:(NSNotification *)object
{
    NSLog(@"============%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"IndexRow"]);
    NSInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:@"IndexRow"];
    Album *album = [albumConfigureArray objectAtIndex:index];
    [album.albumShareComments addObject:@"1"];
     [album.albumShareLikes addObject:@"1"];
    [_table reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

//
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    if (offset.y < 0) {
        CGRect rect = merchantImage.frame;
        rect.origin.y = offset.y;
        rect.size.height = 200 - offset.y;
        merchantImage.frame = rect;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"[albumConfigureArray count] %d",[albumConfigureArray count]);
    return [albumConfigureArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumCell"];
    if (!cell)
    {
        cell = [[AlbumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AlbumCell"];
    }
    cell.tag = indexPath.row;
    cell.currentAlbum = [albumConfigureArray objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [AlbumTableViewCell calculateCellHeightWithAlbum:[albumConfigureArray objectAtIndex:indexPath.row]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
