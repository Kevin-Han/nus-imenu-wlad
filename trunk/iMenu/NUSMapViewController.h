//
//  NUSMapViewController.h
//  iMenu
//
//  Created by Kai HAN,Song Lei on 22/4/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "MapAnnotation.h"
// address
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
// web service
#import "NUSWebService.h"

 
static NSString *shopAPinID = @"shopA.pin";

@interface NUSMapViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate,ABUnknownPersonViewControllerDelegate,UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *shopMap;

@property (nonatomic) ShopAnnotation *aShopAnnotation;
@property (nonatomic) ShopAnnotation *bShopAnnotation;
@property (nonatomic) ShopAnnotation *cShopAnnotation;

@property (nonatomic, retain) NSMutableArray* annotations;

@end
