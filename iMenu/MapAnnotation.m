//
//  MapAnnotation.m
//  iMenu
//
//  Created by Kai HAN on 27/4/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import "MapAnnotation.h"


@implementation ShopAnnotation

@synthesize coordinate=_coordinate, title=_title, subtitle=_subtitle;


#pragma mark - Public Method

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle
{
    self=[super init];
 
    if(self!=nil)
    {
        [self setCoordinate:coordinate];
        [self setTitle:title];
        [self setSubtitle:subtitle];
    }
    
    return self;
}   

@end
