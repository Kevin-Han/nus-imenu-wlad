//
//  NUSSettingsViewController.h
//  iMenu
//
//  Created by Song Lei on 2/5/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kViewTag 1	

static NSString *kSectionTitleKey           = @"SettingsTitleKey";

static NSString *emailViewKey               = @"emailViewKey";
static NSString *passwdViewKey              = @"passwdViewKey";
static NSString *confirmPasswdViewKey       = @"confirmPasswdViewKey";
static NSString *nameViewKey                = @"nameViewKey";
static NSString *genderLableKey             = @"genderLableKey";
static NSString *genderViewKey              = @"genderViewKey";
static NSString *handphoneViewKey           = @"handphoneViewKey";


@interface NUSSettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

- (IBAction)signUp:(id)sender;

@property (nonatomic, retain) NSMutableArray *dataSourceArray;

@property (nonatomic, retain) UITextField           *emailUITextField;
@property (nonatomic, retain) UITextField           *passwordUITextField;
@property (nonatomic, retain) UITextField           *confirmPwdUITextField;
@property (nonatomic, retain) UITextField           *nameUITextField;
@property (nonatomic, retain) UILabel               *genderUILableView;
@property (nonatomic, retain) UISegmentedControl    *genderUISegmentedControl;
@property (nonatomic, retain) UITextField           *handphoneUITextField;

@property CGPoint centerPoint;

@end
