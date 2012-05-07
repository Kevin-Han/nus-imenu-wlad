//
//  NUSMenuDetailViewController.m
//  iMenu
//
//  Created by Song Lei on 30/4/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import "NUSMenuDetailViewController.h"

@interface NUSMenuDetailViewController ()
- (void)shareToFriends;
@end

@implementation NUSMenuDetailViewController
@synthesize caloriesLable = _caloriesLable;
@synthesize dietaryFiberLable = _dietaryFiberLable;
@synthesize sugarsLable = _sugarsLable;
@synthesize totalFatLable = _totalFatLable;
@synthesize totalCarbohydrateLable = _totalCarbohydrateLable;
@synthesize amountServingSizeLable = _amountServingSizeLable;

@synthesize photoUIImageView=_photoUIImageView, dataItem=_dataItem;


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
    
    [_caloriesLable setText:[_dataItem objectForKey:@"Calories"]];
    [_dietaryFiberLable setText:[_dataItem objectForKey:@"Dietary Fiber"]];
    [_sugarsLable setText:[_dataItem objectForKey:@"Sugars"]];
    [_totalFatLable setText:[_dataItem objectForKey:@"Total Fat"]];
    [_totalCarbohydrateLable setText:[_dataItem objectForKey:@"Total Carbohydrate"]];
    [_amountServingSizeLable setText:[_dataItem objectForKey:@"Amount Serving Size"]];
    
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPhotoUIImageView:nil];

    [self setCaloriesLable:nil];
    [self setDietaryFiberLable:nil];
    [self setSugarsLable:nil];
    [self setTotalFatLable:nil];
    [self setTotalCarbohydrateLable:nil];
    [self setAmountServingSizeLable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - Private

- (void)shareToFriends
{
    NSLog(@"%s Calories=%@", __FUNCTION__, [_dataItem objectForKey:@"Calories"]);
    
}

@end
