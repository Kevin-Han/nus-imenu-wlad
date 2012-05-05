//
//  NUSMenuDetailViewController.h
//  iMenu
//
//  Created by Song Lei on 30/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NUSMenuDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *photoUIImageView;
@property (strong, nonatomic) NSDictionary *dataItem;
@property (strong, nonatomic) IBOutlet UILabel *detailUILable;

@end
