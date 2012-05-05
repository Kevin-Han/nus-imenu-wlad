//
//  ApplicationCell.h
//  iMenu
//
//  Created by Song Lei on 27/4/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "NUSAppDelegate.h"

@interface ApplicationCell : UITableViewCell
{
    BOOL useDarkBackground;

    UIImage *icon;
    NSString *name;
    float rating;
    NSInteger numRatings;
    NSString *price;
    UIStepper *stepper;
    UILabel *stepperValue;
}

@property (nonatomic)BOOL useDarkBackground;

@property(retain) UIImage *icon;
@property(retain) NSString *name;
@property float rating;
@property NSInteger numRatings;
@property(retain) NSString *price;
@property(retain) UIStepper *stepper;
@property(retain) UILabel *stepperValue;


@end
