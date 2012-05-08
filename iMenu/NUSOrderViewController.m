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
- (void)doLogin;
- (void)submitOrderToWebService;
@end

@implementation NUSOrderViewController

@synthesize orderTableView = _orderTableView, data=_data, orderHUD=_orderHUD, flagCancelOrder=_flagCancelOrder;

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
    
    UIBarButtonItem *submitOrderBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleBordered target:self action:@selector(doLogin)];
    
    _data = [[NSMutableArray alloc] init];
    
    self.navigationItem.rightBarButtonItem = submitOrderBarButton;
    
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


#pragma mark - Private Method

- (void)doLogin
{
    if(!loginStatus.flagStatusLogin)
    {
        UIAlertView *orderAlert = [[UIAlertView alloc] initWithTitle:@"Order Alert" message:@"Login First" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil, nil];
        
        [orderAlert show];
        
        return;
    }
    
    if(![_data count])
    {
        UIAlertView *orderAlert = [[UIAlertView alloc] initWithTitle:@"Order Alert" message:@"Order List Empty" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil, nil];
        
        [orderAlert show];
        
        return;
    }
    
    _orderHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    _orderHUD.labelText = @"Order...";
    _orderHUD.dimBackground = YES;
    _orderHUD.square = YES;
    _orderHUD.margin = 60.0;
    _orderHUD.delegate = self;
    _orderHUD.cancelButtonText = @"Cancle";
    
    _flagCancelOrder = 0;
    
    [self.view addSubview:_orderHUD];
    
    [_orderHUD showWhileExecuting:@selector(submitOrderToWebService) onTarget:self withObject:nil animated:YES];

}

- (void)submitOrderToWebService
{
      
    NSString *orderRequest = @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/SubmitOrder?";
    NSString *detailsJson=@"[";
    
    BOOL isFirstItem = YES;
    
    for (NSMutableDictionary *dataItem in _data)
    {
        if([[dataItem objectForKey:@"Count"] integerValue])
        {
            if (isFirstItem) 
            {
                isFirstItem = FALSE;
            }else 
            {
                detailsJson = [detailsJson stringByAppendingFormat:@","];
            }
        
            // discount is default set to 0
            // the price value if not set, then the web service side will get it from database
            detailsJson  = [detailsJson stringByAppendingFormat:@"{\"ItemID\":\"%@\",\"Qty\":%@,\"Price\":0,\"DiscountAmt\":0}", [dataItem valueForKey:@"ID"], [dataItem valueForKey:@"Count"]];
            
            NSLog(@"%s Name=%@ Count=%@", __FUNCTION__, [dataItem valueForKey:@"Name"], [dataItem valueForKey:@"Count"]);
        }
    }
    
    detailsJson = [detailsJson stringByAppendingFormat:@"]"];
    
    NSLog(@"%s detailsJson=%@", __FUNCTION__, detailsJson);
    
    orderRequest = [orderRequest 
                    stringByAppendingFormat:@"email=%s", loginStatus.UserName];
    // have to set the store id
    orderRequest = [orderRequest 
                    stringByAppendingFormat:@"&storeid=%@",@"1"];
    // these two value is fixed
    orderRequest = [orderRequest 
                    stringByAppendingFormat:@"&isdelivery=true&status=%@",@"3"];
    // this value should get from the input view
    orderRequest = [orderRequest 
                    stringByAppendingFormat:@"&deliverydate=%@",@"2012-05-06"];
    orderRequest = [orderRequest 
                    stringByAppendingFormat:@"&detailsJson=%@",detailsJson];
    
    NSLog(@"%s orderRequest=%@", __FUNCTION__, orderRequest);
    
    NUSWebService *webserviceModel = [[NUSWebService alloc] init];
    NSString *orderSubmitResult = [webserviceModel getRespone:orderRequest];
    
    if(orderSubmitResult==nil)
    {
        // pop message , the response is null
        UIAlertView *alertsuccessMsg = [[UIAlertView alloc]
                                        initWithTitle:@"Alert" message:@"repsonse is null" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertsuccessMsg show];
        
    }
    
    
    NSMutableDictionary *jsonDic = [[NSMutableDictionary alloc] initWithDictionary:[webserviceModel getOrderResponse:orderSubmitResult]];   
    
    //if(jsonDic==NULL){
    // pop message , json is not parse sucessfully
    // return FALSE;
    
    // }
    
    NSString *result = [jsonDic objectForKey:@"result"];
    result =[NSString stringWithFormat:@"%@",result];
    if([@"1" isEqualToString:result])
    {
        _flagCancelOrder = 1;
        NSString *orderNo = [jsonDic objectForKey:@"OrderNo"];
        orderNo = [orderNo stringByAppendingFormat:@" order confirmation email send to your email."];
        NSLog(@"orderNO:%@",orderNo);
        UIAlertView *alertsuccessMsg = [[UIAlertView alloc]
                                        initWithTitle:@"Alert" message:orderNo delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertsuccessMsg show];
    }
    else if([@"0" isEqualToString:result])
    {
        //Reason
        NSString *reason = [jsonDic objectForKey:@"Reason"];
        // NSLog(@"reason %@",reason);
        // pop message the reasons
        
        UIAlertView *alertsuccessMsg = [[UIAlertView alloc]
                                        initWithTitle:@"Alert" message:reason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertsuccessMsg show];
        
        
    }else{
        UIAlertView *alertsuccessMsg = [[UIAlertView alloc]
                                        initWithTitle:@"Alert" message:@"repsonse is null" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertsuccessMsg show];
        
    }
    
    if(!_flagCancelOrder)
    {
        sleep(2);
    }

}

#pragma mark - Table view methods

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


#pragma mark - Configuring table view cells

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
        label.text =[[NSString alloc] initWithFormat:@"%@ Qty", [dataItem objectForKey:@"Count"]];
    }
    else  if([dataItem objectForKey:@"TotalPrice"]!=nil)
    {
        UILabel *label;
        
        // Set the name.
        label = (UILabel *)[cell viewWithTag:NAME_TAG];
        label.text = @"Total Price:";
        label.textColor = [UIColor orangeColor];
        label.frame = CGRectMake(60, (ROW_HEIGHT - LABEL_HEIGHT) / 2.0, 100, LABEL_HEIGHT);
        
        // Set the total price.
        label = (UILabel *)[cell viewWithTag:PRICE_TAG];
        label.text = [[NSString alloc] initWithFormat:@"S$%.02f", [[dataItem objectForKey:@"TotalPrice"] doubleValue]];
        label.textColor = [UIColor orangeColor];
        label.frame = CGRectMake(MIDDLE_COLUMN_OFFSET, (ROW_HEIGHT - LABEL_HEIGHT) / 2.0, MIDDLE_COLUMN_WIDTH, LABEL_HEIGHT);
    }
}    

#pragma mark - MBProgressHUD delegate

- (void)hudWasHidden 
{  
    if(_orderHUD)
    {
        // Remove HUD from screen when the HUD was hidded  
        [_orderHUD removeFromSuperview];  
    }
}  

@end
