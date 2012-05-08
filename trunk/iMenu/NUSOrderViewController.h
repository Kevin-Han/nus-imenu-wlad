//
//  NUSOrderViewController.h
//  iMenu
//
//  Created by Song Lei on 7/5/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "NUSAppDelegate.h"
#import "NUSWebService.h"
#import "NUSMenuViewController.h"

@interface NUSOrderViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITableView *orderTableView;

@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) MBProgressHUD  *orderHUD;
@property (nonatomic)         BOOL           flagCancelOrder;

@end
