//
//  NUSMenuDetailViewController.h
//  iMenu
//
//  Created by Song Lei on 30/4/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NUSMenuDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *photoUIImageView;
@property (strong, nonatomic) NSDictionary *dataItem;


@property (strong, nonatomic) IBOutlet UILabel *caloriesLable;
@property (strong, nonatomic) IBOutlet UILabel *dietaryFiberLable;
@property (strong, nonatomic) IBOutlet UILabel *sugarsLable;
@property (strong, nonatomic) IBOutlet UILabel *totalFatLable;
@property (strong, nonatomic) IBOutlet UILabel *totalCarbohydrateLable;
@property (strong, nonatomic) IBOutlet UILabel *amountServingSizeLable;


@end
