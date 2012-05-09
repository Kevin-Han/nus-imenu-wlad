//
//  NUSSettingsViewController.m
//  iMenu
//
//  Created by Song Lei on 2/5/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import "NUSSettingsViewController.h"


@interface NUSSettingsViewController ()
- (void) tableDataSourceInit;
- (UITextField *)emailUITextFieldInit;
- (UITextField *) passwordUITextFieldInit;
- (UITextField *) confirmPwdUITextFieldInit;
- (UITextField *) nameUITextFieldInit;
- (UITextField *) handphoneUITextFieldInit;

@end

@implementation NUSSettingsViewController

@synthesize dataSourceArray=_dataSourceArray, emailUITextField=_emailUITextField, passwordUITextField=_passwordUITextField, confirmPwdUITextField=_confirmPwdUITextField, nameUITextField=_nameUITextField, handphoneUITextField=_handphoneUITextField, signUpHUD=_signUpHUD, flagCancelSignUp=_flagCancelSignUp, keyboardHeight=_keyboardHeight, keyboardIsShowing=_keyboardIsShowing, currentTextField=_currentTextField, userID=_userID, forgetPwdHUD=_forgetPwdHUD, flagCancelSendRequset=_flagCancelSendRequset;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize table data source
    [self tableDataSourceInit];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Clear the point
    [self setDataSourceArray:nil];
    [self setEmailUITextField:nil];
    [self setPasswordUITextField:nil];
    [self setConfirmPwdUITextField:nil];
    [self setNameUITextField:nil];
    [self setHandphoneUITextField:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

#pragma mark - Private method

// Table data source initialize
- (void) tableDataSourceInit
{
    self.title = NSLocalizedString(@"Settings", @"");

    _dataSourceArray = [NSArray arrayWithObjects:
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             @"Name", kSectionTitleKey,
                             [self nameUITextFieldInit], nameViewKey,
							 nil],
							
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             @"Email", kSectionTitleKey,
                             [self emailUITextFieldInit], emailViewKey,
                             nil],
							
							[NSDictionary dictionaryWithObjectsAndKeys:
                             @"Password", kSectionTitleKey,
                             [self passwordUITextFieldInit], passwdViewKey,
							 nil],
							
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             @"Comfirm Password", kSectionTitleKey,
                             [self confirmPwdUITextFieldInit], confirmPasswdViewKey,
                             nil],
                        
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             @"Handphone", kSectionTitleKey,
                             [self handphoneUITextFieldInit], handphoneViewKey,
                             nil],
                        
							nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [_dataSourceArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [[_dataSourceArray objectAtIndex: section] valueForKey:kSectionTitleKey];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// to determine specific row height for each cell, override this.
// In this example, each row is determined by its subviews that are embedded.
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

// to determine which UITableViewCell to be used on a given row.
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
	NSUInteger row = [indexPath row];
    
	if (row == 0)
	{
        NSLog(@"%s step001", __FUNCTION__);
        
        switch (indexPath.section)
        {
            case 0:
                kViewKey = nameViewKey;
                kViewTag = _nameUITextField.tag;
                break;
                
            case 1:
                kViewKey = emailViewKey;
                kViewTag = _emailUITextField.tag;
                break;
                
            case 2:
                kViewKey = passwdViewKey;
                kViewTag = _passwordUITextField.tag;
                break;
                
            case 3:
                kViewKey = confirmPasswdViewKey;
                kViewTag = _confirmPwdUITextField.tag;
                break;
                
            case 4:
                kViewKey = handphoneViewKey;
                kViewTag = _handphoneUITextField.tag;
                break;
        }
        
		static NSString *kCellTextField_ID = @"CellTextField_ID";
		cell = [tableView dequeueReusableCellWithIdentifier:kCellTextField_ID];
		if (cell == nil)
		{
            NSLog(@"%s step002", __FUNCTION__);
			// a new cell needs to be created
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
										   reuseIdentifier:kCellTextField_ID];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
		else
		{
            NSLog(@"%s step003", __FUNCTION__);
			// a cell is being recycled, remove the old edit field (if it contains one of our tagged edit fields)
			UIView *viewToCheck = nil;
			viewToCheck = [cell.contentView viewWithTag:kViewTag];
			if (viewToCheck)
				[viewToCheck removeFromSuperview];
		}
        
		UITextField *textField = [[self.dataSourceArray objectAtIndex: indexPath.section] valueForKey:kViewKey];
        
        NSLog(@"%s section=%d", __FUNCTION__, indexPath.section);
        
		[cell.contentView addSubview:textField];
    }
  
	return cell;
}

#pragma mark - Lazy creation of controls
- (UITextField *) nameUITextFieldInit
{
    _nameUITextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 16, 260, 40)];
    _nameUITextField.borderStyle = UITextBorderStyleRoundedRect;
    _nameUITextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _nameUITextField.font = [UIFont fontWithName:@"System" size:30];
    _nameUITextField.placeholder = @"Name";
    _nameUITextField.returnKeyType = UIReturnKeyDone;
    _nameUITextField.tag = 1;
    _nameUITextField.delegate = self;
    
    return _nameUITextField;
}


- (UITextField *)emailUITextFieldInit
{
    _emailUITextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 16, 260, 40)];
    _emailUITextField.borderStyle = UITextBorderStyleRoundedRect;
    _emailUITextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _emailUITextField.font = [UIFont fontWithName:@"System" size:30];
    _emailUITextField.placeholder = @"Email";
    _emailUITextField.keyboardType = UIKeyboardTypeEmailAddress; 
    _emailUITextField.returnKeyType = UIReturnKeyDone;
    _emailUITextField.tag = 2;
    _emailUITextField.delegate = self;
    
    return _emailUITextField;
}

- (UITextField *) passwordUITextFieldInit
{
    _passwordUITextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 16, 260, 40)];
    _passwordUITextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordUITextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _passwordUITextField.font = [UIFont fontWithName:@"System" size:30];
    _passwordUITextField.placeholder = @"Password";
    _passwordUITextField.secureTextEntry = YES;
    _passwordUITextField.returnKeyType = UIReturnKeyDone;
    _passwordUITextField.tag = 3;
    _passwordUITextField.delegate = self;
    
    return _passwordUITextField;
}

- (UITextField *) confirmPwdUITextFieldInit
{
    _confirmPwdUITextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 16, 260, 40)];
    _confirmPwdUITextField.borderStyle = UITextBorderStyleRoundedRect;
    _confirmPwdUITextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _confirmPwdUITextField.font = [UIFont fontWithName:@"System" size:30];
    _confirmPwdUITextField.placeholder = @"Confirm Password";
    _confirmPwdUITextField.secureTextEntry = YES;
    _confirmPwdUITextField.returnKeyType = UIReturnKeyDone;
    _confirmPwdUITextField.tag = 4;
    _confirmPwdUITextField.delegate = self;
    
    return _confirmPwdUITextField;
}

- (UITextField *) handphoneUITextFieldInit
{
    _handphoneUITextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 16, 260, 40)];
    _handphoneUITextField.borderStyle = UITextBorderStyleRoundedRect;
    _handphoneUITextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _handphoneUITextField.font = [UIFont fontWithName:@"System" size:30];
    _handphoneUITextField.placeholder = @"Handphone";
    _handphoneUITextField.returnKeyType = UIReturnKeyDone;
    _handphoneUITextField.delegate = self;
    _handphoneUITextField.tag = 5;
    
    return _handphoneUITextField;
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField;  
{  
    NSLog(@"%s", __FUNCTION__);
    
    
    [textField resignFirstResponder];
    
    return YES;
}


#pragma mark - Action Methods

- (IBAction)signUp:(id)sender 
{
    if([self validateContactSignUp])
    {
        _signUpHUD = [[MBProgressHUD alloc] initWithView:self.view];
        
        _signUpHUD.labelText = @"Sign Up...";
        _signUpHUD.dimBackground = YES;
        _signUpHUD.square = YES;
        _signUpHUD.margin = 60.0;
        _signUpHUD.delegate = self;
        _signUpHUD.cancelButtonText = @"Return";
        
        _flagCancelSignUp = 0;
        
        [self.view addSubview:_signUpHUD];
        
        [_signUpHUD showWhileExecuting:@selector(doContactSignUp) onTarget:self withObject:nil animated:YES];
    }
}

- (IBAction)forgetPassword:(id)sender 
{
    UIAlertView *forgetPwdAlert = [[UIAlertView alloc] initWithTitle:@"Forget Password" message:@"Get the password by Email" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
    
    [forgetPwdAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    [forgetPwdAlert show];
}


#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Submit"])
    {
        _userID = [[alertView textFieldAtIndex:0] text];
        
        if([self validateEmail:_userID]==0)
        {
            UIAlertView *alertPopMsg = [[UIAlertView alloc]
                                        initWithTitle:@"Alert" message:@"Invalid Email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertPopMsg show];
        
        }
        else 
        {
            _forgetPwdHUD = [[MBProgressHUD alloc] initWithView:self.view];
            
            _forgetPwdHUD.labelText = @"Sending...";
            _forgetPwdHUD.dimBackground = YES;
            _forgetPwdHUD.square = YES;
            _forgetPwdHUD.margin = 60.0;
            _forgetPwdHUD.delegate = self;
            _forgetPwdHUD.cancelButtonText = @"Return";
            _flagCancelSendRequset = 0;
            [self.view addSubview:_forgetPwdHUD];
            
            [_forgetPwdHUD showWhileExecuting:@selector(doContactForgotPassword) onTarget:self withObject:nil animated:YES];
        
            NSLog(@"%s UserID=%@", __FUNCTION__, _userID);
        }
    }
}
        
- (BOOL) validateEmail: (NSString *) emailVal {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailVal];
}

-(BOOL) validateContactSignUp{
    
    NSMutableString* printErrorMsg = [NSMutableString stringWithCapacity:15];
    BOOL isProceed = TRUE;
    
    if([[_nameUITextField text] length]==0){
        
        [printErrorMsg appendString:@"Please fill in Name!\n"];
        isProceed = FALSE;
    }  
    
    if([[_emailUITextField text] length]==0)
    {
        [printErrorMsg appendString:@"Please fill in Email!\n"];
        isProceed = FALSE;
    }else if([self validateEmail:[_emailUITextField text]]==0)
    {
        [printErrorMsg appendString:@"Email format incorrect!\n"];
        isProceed = FALSE;
    }
    
    if([[_handphoneUITextField text]length]==0)
    {
        [printErrorMsg appendString:@"Please fill in Handphone!\n"];
        isProceed = FALSE;
    }
    
    if([[_passwordUITextField text] length]==0)
    {
        [printErrorMsg appendString:@"Please fill in password!\n"];
        isProceed = FALSE;
    }
    
    if([[_confirmPwdUITextField text] length]==0)
    {
        [printErrorMsg appendString:@"Please fill in confirm password!\n"];
        isProceed = FALSE;
    }else if(![[_passwordUITextField text] isEqualToString:[_confirmPwdUITextField text]]){
        [printErrorMsg appendString:@"The confirm password is not tally with password!\n"];
        isProceed = FALSE;
    }
    
    // 
    if(!isProceed){
        UIAlertView *alertPopMsg = [[UIAlertView alloc]
                                    initWithTitle:@"Alert" message:printErrorMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertPopMsg show];
        
        return FALSE;
        
    }else {
        return TRUE;
    }
}


-(void) doContactSignUp
{
    
    NSString *contactSignUpRequest = 
                    @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/Registeration?";
    
    NSLog(@"aUserName %@",[_nameUITextField text]);
    NSLog(@"aEmail %@",[_emailUITextField text]);
    NSLog(@"aMobilePh%@",[_handphoneUITextField text]);
    NSLog(@"aPassword%@",[_passwordUITextField text]);
    
    contactSignUpRequest = [contactSignUpRequest 
                            stringByAppendingFormat:@"aUserName=%@",[_nameUITextField text]];
    contactSignUpRequest = [contactSignUpRequest 
                            stringByAppendingFormat:@"&aEmail=%@",[_emailUITextField text]];
    contactSignUpRequest = [contactSignUpRequest 
                            stringByAppendingFormat:@"&aMobilePh=%@",[_handphoneUITextField text]];
    contactSignUpRequest = [contactSignUpRequest 
                            stringByAppendingFormat:@"&aPassword=%@",[_passwordUITextField text]];
    
    
    NUSWebService *webserviceModel = [[NUSWebService alloc] init];
    NSString *contactSignUpResult = [webserviceModel getRespone:contactSignUpRequest];
    
    if(contactSignUpResult==nil)
    {
        // pop message , the response is null
        
        NSLog(@"%s contactSignUpResult==nil", __FUNCTION__);
        
        [_signUpHUD stopIndicators];
        _signUpHUD.labelText =  @"Sign Up Failed";
    }


    
    NSMutableDictionary *jsonDic = [[NSMutableDictionary alloc] initWithDictionary:[webserviceModel getUserSignUpResponse:contactSignUpResult]];   


    if(jsonDic==Nil)
    {
        // pop message , json is not parse sucessfully
        
        NSLog(@"%s jsonDic==nil", __FUNCTION__);
        
        [_signUpHUD stopIndicators];
        _signUpHUD.labelText =  @"Sign Up Failed";
    }
    
    NSString *result = [[NSString alloc] initWithFormat:@"%@", [jsonDic objectForKey:@"result"]];
    result =[NSString stringWithFormat:@"%@",result];
    NSLog(@"%s dicUserInfo %@",__FUNCTION__, result);
    
    if([@"1" isEqualToString:result])
    {
        NSLog(@"%s Sigu Up Success", __FUNCTION__);
        [_signUpHUD stopIndicators];
        _signUpHUD.labelText =  @"Succeed";
    }
    else if([@"0" isEqualToString:result])
    {
     

        NSString *reason = [[NSString alloc] initWithFormat:@"%@", [jsonDic objectForKey:@"Reason"]];
        // pop message the reasons 

        
        [_signUpHUD stopIndicators];
        _signUpHUD.labelText =  @"Sign Up Failed";
        _signUpHUD.detailsLabelText = reason;
    }
    else
    {
        [_signUpHUD stopIndicators];
        _signUpHUD.labelText =  @"Sign Up Failed";
    }
    
    while(!_flagCancelSignUp)
    { 
        sleep(2);
    }

}

-(void) doContactForgotPassword
{
    //http://aspspider.info/zmtun/MobileRestaurantWS.asmx/ForgetPassword?email=pattyyuanxd@gmail.com
    NSString *contactForgotPasswordRequest = 
    @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/ForgetPassword?";
    
    //set the forgot user's email address
    contactForgotPasswordRequest = [contactForgotPasswordRequest 
                                    stringByAppendingFormat:@"email=%@",_userID];
    
    
    NUSWebService *webserviceModel = [[NUSWebService alloc] init];
    NSString *contactForgotPasswordResult = [webserviceModel getRespone:contactForgotPasswordRequest];
    
    if(contactForgotPasswordResult==nil)
    {
        // pop message , the response is null
     
        NSLog(@"%s contactForgotPasswordResult==nil", __FUNCTION__);
     
        [_forgetPwdHUD stopIndicators];
        _forgetPwdHUD.labelText =  @"Failed";
    }
    
    NSMutableDictionary *jsonDic = [[NSMutableDictionary alloc] initWithDictionary:[webserviceModel getUserSignUpResponse:contactForgotPasswordResult]];   
    if(jsonDic==Nil)
    {
        // pop message , json is not parse sucessfully
        
         NSLog(@"%s jsonDic==nil", __FUNCTION__);
         
         [_forgetPwdHUD stopIndicators];
         _forgetPwdHUD.labelText =  @"Failed";
    }
    
    NSString *result = [[NSString alloc] initWithFormat:@"%@", [jsonDic objectForKey:@"result"]];
    result =[NSString stringWithFormat:@"%@",result];
    NSLog(@"%s dicUserInfo %@",__FUNCTION__, result);
    
    if([@"1" isEqualToString:result])
    {
         NSLog(@"%s Sent out", __FUNCTION__);
        [_forgetPwdHUD stopIndicators];
        _forgetPwdHUD.labelText =  @"Send Out";
    }
    else if([@"0" isEqualToString:result])
    {
        //{"result":0,"Reason":"Could not find user information related to provided email address.}
     
        NSString *reason = [[NSString alloc] initWithFormat:@"%@", [jsonDic objectForKey:@"Reason"]];
        // pop message the reasons 
        NSLog(@"doContactForgotPassword reason: %@", reason);
     
        [_forgetPwdHUD stopIndicators];
        _forgetPwdHUD.labelText =  @"Failed";
        _forgetPwdHUD.detailsLabelText = reason;
     }
     else
     {
         [_forgetPwdHUD stopIndicators];
         _forgetPwdHUD.labelText =  @"Failed";
     }
    
    while(!_flagCancelSendRequset)
    { 
        sleep(2);
    }
}

#pragma mark - MBProgressHUD delegate

- (void)hudWasHidden 
{  
    if(_signUpHUD)
    {
        // Remove HUD from screen when the HUD was hidded  
        [_signUpHUD removeFromSuperview];  
    }
    
    if(_forgetPwdHUD)
    {
        [_forgetPwdHUD removeFromSuperview];
    }
}  

- (void)clearHud
{
    if(_signUpHUD)
    {
        // Remove HUD from screen when the HUD was hidded  
        [_signUpHUD removeFromSuperview];  
        
        _flagCancelSignUp = 1;
        
        [self.tabBarController setSelectedIndex:0];
    }
    
    if(_forgetPwdHUD)
    {
        // Remove HUD from screen when the HUD was hidded  
        [_forgetPwdHUD removeFromSuperview];  
        
        _flagCancelSendRequset = 1;
    }
        
}


@end

