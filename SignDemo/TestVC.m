//
//  TestVC.m
//  SignDemo
//
//  Created by ylang on 14-7-1.
//  Copyright (c) 2014年 ylang. All rights reserved.
//

#import "TestVC.h"

@interface TestVC ()
{
    NSMutableArray *comments;
    NSMutableArray *forWard;
}
@end

@implementation TestVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    comments = [[NSMutableArray alloc] init];
    forWard = [[NSMutableArray alloc] init];
    
    
    
    for (int i = 0; i < 2; i++)
    {
        [forWard addObject:[NSString stringWithFormat:@"%d",i]];
        [forWard addObject:[NSString stringWithFormat:@"%d",i]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
