//
//  NUSMenuDetailViewController.m
//  iMenu
//
//  Created by Song Lei on 30/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NUSMenuDetailViewController.h"

@interface NUSMenuDetailViewController ()
- (void)shareToFriends;
@end

@implementation NUSMenuDetailViewController

@synthesize photoUIImageView=_photoUIImageView, detailUILable=_detailUILable, dataItem=_dataItem;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [_dataItem objectForKey:@"Name"];
    
    UIBarButtonItem *shareBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStyleBordered target:self action:@selector(shareToFriends)];
    
    self.navigationItem.rightBarButtonItem = shareBarButton;
    
    [_photoUIImageView setImage:[UIImage imageNamed:[_dataItem objectForKey:@"Image"]]];
    
    [_detailUILable setText:[_dataItem objectForKey:@"Detail"]];
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPhotoUIImageView:nil];
    [self setDetailUILable:nil];

    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - Private

- (void)shareToFriends
{
    NSLog(@"%s", __FUNCTION__);
}

@end
