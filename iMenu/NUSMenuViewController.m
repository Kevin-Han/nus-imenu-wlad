//
//  NUSMenuViewController.m
//  iMenu
//
//  Created by Song Lei on 22/4/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import "NUSMenuViewController.h"


/*
 Predefined colors to alternate the background color of each cell row by row
 (see tableView:cellForRowAtIndexPath: and tableView:willDisplayCell:forRowAtIndexPath:).
 */
#define DARK_BACKGROUND  [UIColor colorWithRed:151.0/255.0 green:152.0/255.0 blue:155.0/255.0 alpha:1.0]
#define LIGHT_BACKGROUND [UIColor colorWithRed:172.0/255.0 green:173.0/255.0 blue:175.0/255.0 alpha:1.0]


@interface NUSMenuViewController ()
- (void)showLoginView;
@end

@implementation NUSMenuViewController

@synthesize flagCancelLogin=_flagCancelLogin, loginHUD=_loginHUD, username=_username, password=_password, loginBarButtonItem=_loginBarButtonItem, data=_data, menuTableView=_menuTableView;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _menuTableView.rowHeight = 100.0;
    _menuTableView.backgroundColor = DARK_BACKGROUND;
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Clear the flag
    _flagCancelLogin = 0;
    
    // Clear login struct
    loginStatus.flagStatusLogin = 0;
    memset(loginStatus.UserName, 0x00, sizeof(loginStatus.UserName));
    
	// Load the data.
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    
    _data = [NSArray arrayWithContentsOfFile:dataPath];
}

- (void)viewDidUnload
{
    [self setUsername:nil];
    [self setPassword:nil];
    [self setLoginHUD:nil];
    [self setLoginBarButtonItem:nil];
    [self setData:nil];
    [self setMenuTableView:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


#pragma mark - Action Methods
- (IBAction)loginBarButtonAction:(id)sender
{
    if([[_loginBarButtonItem title] isEqualToString:@"Login"])
    {
        UIAlertView *loginAlert = [[UIAlertView alloc] initWithTitle:@"Login" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login", nil];
        
        [loginAlert setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
        
        [loginAlert show];
    }
    else if([[_loginBarButtonItem title] isEqualToString:@"Logout"])
    {
        UIAlertView *logoutAlert = [[UIAlertView alloc] initWithTitle:@"Logout" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Logout", nil];
        
        [logoutAlert show];
    }
}


#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Login"])
    {
        _username = [[alertView textFieldAtIndex:0] text];
        _password = [[alertView textFieldAtIndex:1] text];

        NSLog(@"%s Login Username=%@ Password=%@", __FUNCTION__, _username, _password);
        
        [self showLoginView];
    }
    else if ([title isEqualToString:@"Logout"]) 
    {
        NSLog(@"%s Logout Username=%@ Password=%@", __FUNCTION__, _username, _password);
        
        // Logout and clear the struct
        loginStatus.flagStatusLogin = 0;
        memset(loginStatus.UserName, 0x00, sizeof(loginStatus.UserName));
        
        [_loginBarButtonItem setTitle:@"Login"];
    }
}

#pragma mark - Show login view
- (void)showLoginView
{
    NSLog(@"%s", __FUNCTION__);
    
    _loginHUD = [[MBProgressHUD alloc] initWithView:self.view];

    _loginHUD.labelText = @"Loging...";
	_loginHUD.dimBackground = YES;
	_loginHUD.square = YES;
    _loginHUD.margin = 60.0;
    _loginHUD.delegate = self;
    _loginHUD.cancelButtonText = @"Cancel";
    
    _flagCancelLogin = 0;
    
    // Clear login struct
    loginStatus.flagStatusLogin = 0;
    memset(loginStatus.UserName, 0x00, sizeof(loginStatus.UserName));
    
    [self.view addSubview:_loginHUD];
    
    [_loginHUD showWhileExecuting:@selector(doLogin) onTarget:self withObject:nil animated:YES];
}

- (void)doLogin
{
    
    // Do the login here currently use sleep method instead login
    
    NSString *loginRequest = @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/Login";
    
    loginRequest = [loginRequest stringByAppendingFormat:@"?email=%@",_username];
    loginRequest = [loginRequest stringByAppendingFormat:@"&password=%@",_password];
    
    NUSWebService *webserviceModel = [[NUSWebService alloc] init];
    NSString *loginResult = [webserviceModel getRespone:loginRequest];

    NSString *result = [[NSString alloc] initWithFormat:@"%@", [webserviceModel getLoginResponse:loginResult]];

    //0=Password Fail,1=Success,-2=User ID not found.

    if([result isEqualToString:@"1"])
        
    {
        NSLog(@"come to login success");
        [_loginHUD stopIndicators];
        _loginHUD.labelText =  @"Succeed";
        _flagCancelLogin=1;
        
        // Set login struct
        loginStatus.flagStatusLogin = 1;
        memcpy(loginStatus.UserName, [_username UTF8String], [_username length]);
        [_loginBarButtonItem setTitle:@"Logout"];
    }
    else if([@"-2" isEqualToString:result])
    {
        [_loginHUD stopIndicators];
        _loginHUD.labelText =  @"Failed";
        _loginHUD.detailsLabelText = @"User ID Not Found";
    }else{
        
        [_loginHUD stopIndicators];
        
        _loginHUD.labelText =  @"Failed";
        _loginHUD.detailsLabelText =  @"Password Invalid";

    }
    
    while(!_flagCancelLogin)
    { 
        sleep(2);
    }
}


#pragma mark - MBProgressHUD delegate

- (void)hudWasHidden 
{  
    if(_loginHUD)
    {
        // Remove HUD from screen when the HUD was hidded  
        [_loginHUD removeFromSuperview];  
    }
}  

- (void)clearHud
{
    if(_loginHUD)
    {
        // Remove HUD from screen when the HUD was hidded  
        [_loginHUD removeFromSuperview];  
        
        _flagCancelLogin = 1;
    }
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ApplicationCell";
    
    ApplicationCell *cell = (ApplicationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil)
    {
        cell = [[CompositeSubviewBasedApplicationCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                            reuseIdentifier:CellIdentifier];
    }
    
	// Display dark and light background in alternate rows -- see tableView:willDisplayCell:forRowAtIndexPath:.
    cell.useDarkBackground = (indexPath.row % 2 == 0);
	
	// Configure the data for the cell.
    NSDictionary *dataItem = [_data objectAtIndex:indexPath.row];
    cell.icon = [UIImage imageNamed:[dataItem objectForKey:@"Icon"]];
    cell.price = [[NSString alloc] initWithFormat:@"S$%@", [dataItem objectForKey:@"Price"]];
    cell.name = [dataItem objectForKey:@"Name"];
    cell.numRatings = [[dataItem objectForKey:@"NumRatings"] intValue];
    cell.rating = [[dataItem objectForKey:@"Rating"] floatValue];
    cell.stepper.tag = indexPath.row;

	
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = ((ApplicationCell *)cell).useDarkBackground ? DARK_BACKGROUND : LIGHT_BACKGROUND;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NUSMenuDetailViewController *menuDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuDetail"];

    menuDetail.dataItem = [_data objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:menuDetail animated:YES];
}
@end
