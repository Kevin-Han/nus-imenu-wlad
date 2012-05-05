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
- (UISegmentedControl *) genderUISegmentedControlInit;
- (UITextField *) handphoneUITextFieldInit;

@end

@implementation NUSSettingsViewController

@synthesize dataSourceArray=_dataSourceArray, emailUITextField=_emailUITextField, passwordUITextField=_passwordUITextField, confirmPwdUITextField=_confirmPwdUITextField, centerPoint=_centerPoint, nameUITextField=_nameUITextField, genderUILableView=_genderUILableView, genderUISegmentedControl=_genderUISegmentedControl, handphoneUITextField=_handphoneUITextField;

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
    [self setGenderUILableView:nil];
    [self setGenderUISegmentedControl:nil];
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
                         
                         @"Gender", genderLableKey,
                         [self genderUISegmentedControlInit], genderViewKey,
                         
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
    return 6;
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
            cell.textLabel.text = [[_dataSourceArray objectAtIndex: indexPath.section] valueForKey:genderLableKey]; 
            UIControl *control = [[_dataSourceArray objectAtIndex: indexPath.section] valueForKey:genderViewKey];
            [cell.contentView addSubview:control];
            break;
        }
        case 5:
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
    _nameUITextField.delegate = self;
    
    return _nameUITextField;
}

- (UISegmentedControl *) genderUISegmentedControlInit
{
    if (_genderUISegmentedControl == nil) 
    {
        NSArray *itemArray = [NSArray arrayWithObjects: @"Male", @"Female", nil];
        _genderUISegmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
        _genderUISegmentedControl.frame = CGRectMake(140, 16, 140, 40);
        _genderUISegmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
        _genderUISegmentedControl.selectedSegmentIndex = 0;
        
        [self.view addSubview:_genderUISegmentedControl];
    }

    return _genderUISegmentedControl;
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
    _handphoneUITextField.keyboardType = UIKeyboardTypeNumberPad;
    
    return _handphoneUITextField;
}

#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField  
{  
    NSLog(@"%s", __FUNCTION__);
    
    if (textField == _confirmPwdUITextField || textField == _nameUITextField || _handphoneUITextField)
    {
        _centerPoint.y = self.view.center.y;
        
        self.view.center=CGPointMake(self.view.center.x,40);
    }
}  

- (BOOL)textFieldShouldReturn:(UITextField *)textField;  
{  
    NSLog(@"%s", __FUNCTION__);
    
    if (textField == _confirmPwdUITextField || textField == _nameUITextField || _handphoneUITextField)
    {
        self.view.center=CGPointMake(self.view.center.x, _centerPoint.y);
    }
    
    [textField resignFirstResponder];
    
    return YES;
}
- (IBAction)signUp:(id)sender 
{
    UIAlertView *signUpAlert = [[UIAlertView alloc] initWithTitle:@"Sign Up" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    [signUpAlert show];
}
@end

