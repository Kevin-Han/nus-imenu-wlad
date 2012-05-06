//
//  NUSSettingsViewController.h
//  iMenu
//
//  Created by Song Lei on 2/5/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NUSWebService.h"
#import "SBJson.h"
#import "MBProgressHUD.h"

#define kViewTag 1	

static NSString *kSectionTitleKey           = @"SettingsTitleKey";

static NSString *emailViewKey               = @"emailViewKey";
static NSString *passwdViewKey              = @"passwdViewKey";
static NSString *confirmPasswdViewKey       = @"confirmPasswdViewKey";
static NSString *nameViewKey                = @"nameViewKey";
static NSString *handphoneViewKey           = @"handphoneViewKey";


@interface NUSSettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, MBProgressHUDDelegate>

- (IBAction)signUp:(id)sender;

@property (nonatomic, retain) NSMutableArray *dataSourceArray;

@property (nonatomic, retain) UITextField           *emailUITextField;
@property (nonatomic, retain) UITextField           *passwordUITextField;
@property (nonatomic, retain) UITextField           *confirmPwdUITextField;
@property (nonatomic, retain) UITextField           *nameUITextField;
@property (nonatomic, retain) UITextField           *handphoneUITextField;
@property (nonatomic, retain) MBProgressHUD         *signUpHUD;

@property (nonatomic)         BOOL                  flagCancelSignUp;

@property CGPoint centerPoint;

@end
