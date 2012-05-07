//
//  NUSOrderViewController.m
//  iMenu
//
//  Created by Song Lei on 7/5/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import "NUSOrderViewController.h"

#define ROW_HEIGHT 60

@interface NUSOrderViewController ()

@end

@implementation NUSOrderViewController

@synthesize orderTableView = _orderTableView;
@synthesize data=_data;

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
    
    double totalPrice=0;
    
    UIBarButtonItem *confirmBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Order" style:UIBarButtonItemStyleBordered target:self action:@selector(confirmOrder)];
    
    _data = [[NSMutableArray alloc] init];
    
    self.navigationItem.rightBarButtonItem = confirmBarButton;
    
    for(NSMutableDictionary *dataItem in orderList)
    {
        if([[dataItem objectForKey:@"Count"] integerValue])
        {
            [_data addObject:dataItem];
            totalPrice+=[[dataItem objectForKey:@"Price"] doubleValue]*[[dataItem objectForKey:@"Count"] integerValue];
        }
    }
    
    if([_data count])
    {
        NSDictionary *totalPriceItem = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithDouble:totalPrice], @"TotalPrice", nil];

        [_data addObject:totalPriceItem];
    }
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setOrderTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (void)confirmOrder
{
    
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data count];
}

// to determine specific row height for each cell, override this.
// In this example, each row is determined by its subviews that are embedded.
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROW_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
	
	static NSString *CellIdentifier = @"OrderCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [self tableViewCellWithReuseIdentifier:CellIdentifier];
	}
	
	// configureCell:cell forIndexPath: sets the text and image for the cell -- the method is factored out as it's also called during minuted-based updates.
	[self configureCell:cell forIndexPath:indexPath];
	return cell;
}


#pragma mark -
#pragma mark Configuring table view cells

#define NAME_TAG 1
#define PRICE_TAG 2
#define COUNT_TAG 3

#define LEFT_COLUMN_OFFSET 10.0
#define LEFT_COLUMN_WIDTH 162.0

#define MIDDLE_COLUMN_OFFSET 162.0
#define MIDDLE_COLUMN_WIDTH 90.0

#define RIGHT_COLUMN_OFFSET 252.0

#define MAIN_FONT_SIZE 18.0
#define LABEL_HEIGHT 26.0

#define IMAGE_SIDE 60.0

- (UITableViewCell *)tableViewCellWithReuseIdentifier:(NSString *)identifier {
	
	/*
	 Create an instance of UITableViewCell and add tagged subviews for the name, local time, and quarter image of the time zone.
	 */
    
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
	/*
	 Create labels for the text fields; set the highlight color so that when the cell is selected it changes appropriately.
     */
	UILabel *label;
	CGRect rect;
	
	// Create a label for the name.
	rect = CGRectMake(LEFT_COLUMN_OFFSET, (ROW_HEIGHT - LABEL_HEIGHT) / 2.0, LEFT_COLUMN_WIDTH, LABEL_HEIGHT);
	label = [[UILabel alloc] initWithFrame:rect];
	label.tag = NAME_TAG;
	label.font = [UIFont boldSystemFontOfSize:MAIN_FONT_SIZE];
	label.adjustsFontSizeToFitWidth = YES;
	[cell.contentView addSubview:label];
	label.highlightedTextColor = [UIColor whiteColor];
	
	// Create a label for the price.
	rect = CGRectMake(MIDDLE_COLUMN_OFFSET, (ROW_HEIGHT - LABEL_HEIGHT) / 2.0, MIDDLE_COLUMN_WIDTH, LABEL_HEIGHT);
	label = [[UILabel alloc] initWithFrame:rect];
	label.tag = PRICE_TAG;
	label.font = [UIFont systemFontOfSize:MAIN_FONT_SIZE];
	label.textAlignment = UITextAlignmentRight;
	[cell.contentView addSubview:label];
	label.highlightedTextColor = [UIColor whiteColor];
    
	// Create an image view for the quarter image.
	rect = CGRectMake(RIGHT_COLUMN_OFFSET, (ROW_HEIGHT - IMAGE_SIDE) / 2.0, IMAGE_SIDE, IMAGE_SIDE);
    
	label = [[UILabel alloc] initWithFrame:rect];
	label.tag = COUNT_TAG;
	label.font = [UIFont systemFontOfSize:MAIN_FONT_SIZE];
	label.textAlignment = UITextAlignmentRight;
	[cell.contentView addSubview:label];
	label.highlightedTextColor = [UIColor whiteColor];	
	
	return cell;
}


- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath 
{
    NSMutableDictionary *dataItem = [_data objectAtIndex:indexPath.row];
    
    if([dataItem objectForKey:@"Name"]!=nil)
    {
        UILabel *label;
	
        // Set the name.
        label = (UILabel *)[cell viewWithTag:NAME_TAG];
        label.text = [dataItem objectForKey:@"Name"];
	
        // Set the price.
        label = (UILabel *)[cell viewWithTag:PRICE_TAG];
        label.text = [[NSString alloc] initWithFormat:@"S$%@", [dataItem objectForKey:@"Price"]];
	
        // Set the count.
        label = (UILabel *)[cell viewWithTag:COUNT_TAG];
        label.text =[[NSString alloc] initWithFormat:@"%@ pcs", [dataItem objectForKey:@"Count"]];
    }
    else  if([dataItem objectForKey:@"TotalPrice"]!=nil)
    {
        UILabel *label;
        
        // Set the name.
        label = (UILabel *)[cell viewWithTag:NAME_TAG];
        label.text = @"Total Price:";
        label.font = [UIFont systemFontOfSize:24];
        
        // Set the total price.
        label = (UILabel *)[cell viewWithTag:PRICE_TAG];
        label.font = [UIFont systemFontOfSize:24];
        label.text = [[NSString alloc] initWithFormat:@"S$%@", [dataItem objectForKey:@"TotalPrice"]];
    }
}    


@end
