//
//  NUSOrderViewController.m
//  iMenu
//
//  Created by Song Lei on 7/5/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import "NUSOrderViewController.h"

@interface NUSOrderViewController ()

@end

@implementation NUSOrderViewController

@synthesize dataSourceArray=_dataSourceArray;

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
    
    
    UIBarButtonItem *confirmBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Order" style:UIBarButtonItemStyleBordered target:self action:@selector(confirmOrder)];
    
    self.navigationItem.rightBarButtonItem = confirmBarButton;
    
    for(NSMutableDictionary *dataItem in orderList)
    {
        if([[dataItem objectForKey:@"Count"] integerValue])
        {
            NSLog(@"%s Name=%@ Count=%@", __FUNCTION__, [dataItem objectForKey:@"Name"], [dataItem objectForKey:@"Count"]);
        }
    }
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (void)confirmOrder
{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [_dataSourceArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

// to determine specific row height for each cell, override this.
// In this example, each row is determined by its subviews that are embedded.
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

// to determine which UITableViewCell to be used on a given row.
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
