//
//  NUSMenuViewController.h
//  iMenu
//
//  Created by Song Lei on 22/4/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ApplicationCell.h"
#import "CompositeSubviewBasedApplicationCell.h"
#import "NUSMenuDetailViewController.h"
#import "NUSWebService.h"
#import "NUSAppDelegate.h"
#import "SBJson.h"

typedef struct 
{
    uint8_t UserName[128];
    BOOL flagStatusLogin;//1 for Login, 0 for Logout
    
}LoginStatus_t;

LoginStatus_t loginStatus;

@interface NUSMenuViewController : UIViewController <MBProgressHUDDelegate>

@property (nonatomic)           BOOL            flagCancelLogin;
@property (nonatomic, retain)   MBProgressHUD   *loginHUD;
@property (nonatomic, retain)   NSString        *username;
@property (nonatomic, retain)   NSString        *password;
@property (nonatomic, retain)   NSArray         *data;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *loginBarButtonItem;
- (IBAction)loginBarButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *menuTableView;


@end
