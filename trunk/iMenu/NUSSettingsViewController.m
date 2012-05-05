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

@synthesize dataSourceArray=_dataSourceArray, emailUITextField=_emailUITextField, passwordUITextField=_passwordUITextField, confirmPwdUITextField=_confirmPwdUITextField, centerPoint=_centerPoint, nameUITextField=_nameUITextField, handphoneUITextField=_handphoneUITextField;

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
    
	_dataSourceArray = [NSMutableArray arrayWithObjects:
                        
                        [NSDictionary dictionaryWithObjectsAndKeys:
                         @"Sing Up", kSectionTitleKey,
                         
                         [self emailUITextFieldInit], emailViewKey,
                         
                         [self passwordUITextFieldInit], passwdViewKey,
                         
                         [self confirmPwdUITextFieldInit], confirmPasswdViewKey,
                         
                         [self nameUITextFieldInit], nameViewKey,
                         
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
    return 5;
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
    
    static NSString *kDisplayCell_ID = @"DisplayCellID";
    cell = [tableView dequeueReusableCellWithIdentifier:kDisplayCell_ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDisplayCell_ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        // the cell is being recycled, remove old embedded controls
        UIView *viewToRemove = nil;
        viewToRemove = [cell.contentView viewWithTag:kViewTag];
        if (viewToRemove)
        {
            [viewToRemove removeFromSuperview];
        }
    }
    
    switch([indexPath row])
	{
        case 0:
        {
            UIControl *control = [[_dataSourceArray objectAtIndex: indexPath.section] valueForKey:emailViewKey];
            [cell.contentView addSubview:control];
            break;
        }
        case 1:
        {
            UIControl *control = [[_dataSourceArray objectAtIndex: indexPath.section] valueForKey:passwdViewKey];
            [cell.contentView addSubview:control];
            break;
        }    
        case 2:
        {
            UIControl *control = [[_dataSourceArray objectAtIndex: indexPath.section] valueForKey:confirmPasswdViewKey];
            [cell.contentView addSubview:control];
            break;
        }
        case 3:
        {
            UIControl *control = [[_dataSourceArray objectAtIndex: indexPath.section] valueForKey:nameViewKey];
            [cell.contentView addSubview:control];
            break;
        }
        case 4:
        {
            UIControl *control = [[_dataSourceArray objectAtIndex: indexPath.section] valueForKey:handphoneViewKey];
            [cell.contentView addSubview:control];
            break;
        }
    }
    
    
	return cell;
}

#pragma mark - Lazy creation of controls


- (UITextField *)emailUITextFieldInit
{
    _emailUITextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 16, 260, 40)];
    _emailUITextField.borderStyle = UITextBorderStyleRoundedRect;
    _emailUITextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _emailUITextField.font = [UIFont fontWithName:@"System" size:30];
    _emailUITextField.placeholder = @"Email";
    _emailUITextField.keyboardType = UIKeyboardTypeEmailAddress; 
    _emailUITextField.returnKeyType = UIReturnKeyDone;
    _emailUITextField.tag = 1;
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
    _passwordUITextField.tag = 2;
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
    _confirmPwdUITextField.tag = 3;
    _confirmPwdUITextField.delegate = self;
    
    return _confirmPwdUITextField;
}

- (UITextField *) nameUITextFieldInit
{
    _nameUITextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 16, 260, 40)];
    _nameUITextField.borderStyle = UITextBorderStyleRoundedRect;
    _nameUITextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _nameUITextField.font = [UIFont fontWithName:@"System" size:30];
    _nameUITextField.placeholder = @"Name";
    _nameUITextField.returnKeyType = UIReturnKeyDone;
    _nameUITextField.tag = 4;
    _nameUITextField.delegate = self;
    
    return _nameUITextField;
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

- (void)textFieldDidBeginEditing:(UITextField *)textField  
{  
    NSLog(@"%s tag=%d", __FUNCTION__, textField.tag);
    
    if(textField.tag==3)
    {
        _centerPoint.y = self.view.center.y;
        
        self.view.center=CGPointMake(self.view.center.x, _centerPoint.y-60);
    }
    else if(textField.tag==4)
    {
        _centerPoint.y = self.view.center.y;
        
        self.view.center=CGPointMake(self.view.center.x, _centerPoint.y-120);
    }
    else if(textField.tag==5)
    {
        _centerPoint.y = self.view.center.y;
        
        self.view.center=CGPointMake(self.view.center.x, _centerPoint.y-160);
    }

}  

- (BOOL)textFieldShouldReturn:(UITextField *)textField;  
{  
    NSLog(@"%s", __FUNCTION__);
    
    if(textField.tag==3 || textField.tag==4 || textField.tag==5)
    {
        self.view.center=CGPointMake(self.view.center.x, _centerPoint.y);
    }
    
    [textField resignFirstResponder];
    
    return YES;
}
- (IBAction)signUp:(id)sender 
{
    if([self validateContactSignUp]){
    
    UIAlertView *signUpAlert = [[UIAlertView alloc] initWithTitle:@"Sign Up" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"SignUp", nil];
    
    [signUpAlert show];
    }
}




- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"SignUp"])
    {
        NSLog(@"%s", __FUNCTION__);
        [self contactSignUp];
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
        
        [printErrorMsg appendString:@"please fill in Name;"];
        isProceed = FALSE;
    }  
    
    if([[_emailUITextField text] length]==0)
    {
        [printErrorMsg appendString:@"please fill in Email;"];
        isProceed = FALSE;
    }else if([self validateEmail:[_emailUITextField text]]==0)
    {
        [printErrorMsg appendString:@"email format incorrect;"];
        isProceed = FALSE;
    }
    
    if([[_handphoneUITextField text]length]==0)
    {
        [printErrorMsg appendString:@"please fill in Handphone;"];
        isProceed = FALSE;
    }
    
    if([[_passwordUITextField text] length]==0)
    {
        [printErrorMsg appendString:@"please fill in password;"];
        isProceed = FALSE;
    }
    
    if([[_confirmPwdUITextField text] length]==0)
    {
        [printErrorMsg appendString:@"please fill in confirm password;"];
        isProceed = FALSE;
    }else if(![[_passwordUITextField text] isEqualToString:[_confirmPwdUITextField text]]){
        [printErrorMsg appendString:@"the confirm password is not tally with password;"];
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

-(bool) contactSignUp{
    
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
    
    if(contactSignUpResult==nil){
        // pop message , the response is null
        return FALSE;
    }
    
    NSMutableDictionary *jsonDic = [NSString stringWithFormat:@"%@", 
                        [webserviceModel getUserSignUpResponse:contactSignUpResult]];
    

    if(jsonDic==NULL){
        
        // pop message , json is not parse sucessfully
        
        return FALSE;
    
    }
    
    NSString *result = [jsonDic objectForKey:@"result"];
    NSLog(@"dicUserInfo %@",result);
    
    if([@"1" isEqualToString:result])
    {
        return TRUE;
    }
    else if([@"0" isEqualToString:result])
    {
        ////Reason
        NSString *reason = [jsonDic objectForKey:@"Reason"];
        // pop message the reasons    
        return FALSE;
    }else{
        return FALSE;
        
    }

}



@end

