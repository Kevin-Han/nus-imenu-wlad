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

@interface NUSOrderViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,MBProgressHUDDelegate>

@property (nonatomic, retain) NSMutableArray *dataSourceArray;
@end
