//
//  NUSMapViewController.m
//  iMenu
//
//  Created by Song Lei on 22/4/12.
//  Copyright (c) 2012 NUS ISS WLAD PROJECT 11. All rights reserved.
//

#import "NUSMapViewController.h"

@interface NUSMapViewController ()
- (void)createShopAnnotation;
@end

@implementation NUSMapViewController
@synthesize shopMap=_shopMap, aShopAnnotation=_aShopAnnotation, bShopAnnotation=_bShopAnnotation, cShopAnnotation=_cShopAnnotation, annotations=_annotations;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Init Location Manager
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=1000.0f;
    
    [locationManager startUpdatingLocation];
    
    MKCoordinateRegion theRegion = { {0.0, 0.0 }, { 0.0, 0.0 } };
    theRegion.center=[[locationManager location] coordinate];
    
    NSLog(@"%s Current Location : %@", __FUNCTION__, [[locationManager location] description]);
    
    [_shopMap setZoomEnabled:YES];
    [_shopMap setScrollEnabled:YES];
    [_shopMap setShowsUserLocation:YES];
    
    theRegion.span.longitudeDelta = 0.01f;
    theRegion.span.latitudeDelta = 0.01f;
    
    [_shopMap setRegion:theRegion animated:YES];
    
    // Crate shop
    [self createShopAnnotation];
    
    MKMapRect flyTo = MKMapRectNull;
	for (id annotation in _annotations) 
    {
		NSLog(@"fly to on");
        MKMapPoint annotationPoint = MKMapPointForCoordinate([annotation coordinate]);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo))
        {
            flyTo = pointRect;
        } 
        else 
        {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
    
    // Position the map so that all overlays and annotations are visible on screen.
    _shopMap.visibleMapRect = flyTo;
}

- (void)viewDidUnload
{
    [self setShopMap:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[_shopMap dequeueReusableAnnotationViewWithIdentifier:shopAPinID];

    
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    
    if (pinView==nil)
    {
        MKPinAnnotationView* customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:shopAPinID];  
        
        customPinView.pinColor = MKPinAnnotationColorRed;
        customPinView.animatesDrop = YES;
        customPinView.canShowCallout =YES;
        customPinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
        
        return customPinView;
    }
    else
    {
        pinView.annotation = annotation;
    }
    
    return pinView;
}

-(BOOL) addShopToAddressLibarary{
    
    return  TRUE;

}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [[[UIAlertView alloc] initWithTitle:view.annotation.title 
                                 message:view.annotation.subtitle 
                                delegate:self
                       cancelButtonTitle:@"Cancel"
                       otherButtonTitles:@"Add", nil] 
      
     show];
    
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Add"])
    {
        NSLog(@"%s", __FUNCTION__);
        
        NSLog(@"come here");
        [self saveContact:@"1"];
    }
}

-(NSMutableArray *) getStoreList{
    NSString *getStoreListRequest = 
    @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/GetStores";
    
    NUSWebService *webserviceModel = [[NUSWebService alloc] init];
    NSString *getStoreResult = [webserviceModel getRespone:getStoreListRequest];
    NSLog(@"store result%@", getStoreResult);
    
    
    NSMutableArray *stores = [webserviceModel getStoreResponse:getStoreResult];
    for(NSMutableDictionary * store  in stores)  
    {  
        
        //NSLog(@"Name: %@",[[store objectForKey:@"StoreID"] description]);
        //NSLog(@"PostalCode: %@",[[store objectForKey:@"PostalCode"] description]); 
       //NSLog(@"LocationX: %@",[[store objectForKey:@"LocationX"] description]); 
       // NSLog(@"LocatoinY: %@",[[store objectForKey:@"LocatoinY"] description]);
    } 
    
    
    return stores;
    

}


-(BOOL)saveContact:(NSString *)storeID{
    NSMutableArray *stores = [self getStoreList];
    
    
    for(NSMutableDictionary * store  in stores)  
    {  
    
        if([storeID isEqualToString:[[store objectForKey:@"StoreID"] description]]){
            NSString *firstName = [[store objectForKey:@"Name"] description];
            NSString *postalCode = [[store objectForKey:@"PostalCode"] description];
            NSString *hotline = [[store objectForKey:@"Hotline"] description];
            NSString *street = [[store objectForKey:@"Address1"] description];
            street = [street stringByAppendingFormat:@",%@",[[store objectForKey:@"Address2"] description]];
            NSString *companyName = @"imenu Pte Ltd";
            // Email
            NSString *email = @"imenu@gmail.com";
            NSLog(@"Name: %@",firstName);
            NSLog(@"PostalCode: %@",postalCode); 
            NSLog(@"hotline: %@",hotline); 
            NSLog(@"street: %@",street); 
            
            // create addresses 
            ABRecordRef aRecord = ABPersonCreate();
            CFErrorRef  anError = NULL; 
            // First Name & Last Name
            ABRecordSetValue(aRecord, kABPersonFirstNameProperty, 
                             (__bridge CFStringRef)firstName, &anError); 
           // ABRecordSetValue(aRecord, kABPersonLastNameProperty, 
                            // (__bridge CFStringRef)lastName, &anError);
            
            // Company Number
            ABRecordSetValue(aRecord, kABPersonOrganizationProperty, (__bridge CFStringRef)companyName, &anError);
            
            // Phone Number.
            ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
            ABMultiValueAddValueAndLabel(multi, (__bridge CFStringRef)hotline, kABPersonPhoneMobileLabel, NULL);
            ABRecordSetValue(aRecord, kABPersonPhoneProperty, multi, &anError);
            
            
            // ADDRESS
            ABMutableMultiValueRef addressmuti = ABMultiValueCreateMutable(kABMultiStringPropertyType);
            ABMultiValueAddValueAndLabel(addressmuti, (__bridge CFStringRef)street, kABPersonAddressStreetKey, NULL);
            ABMultiValueAddValueAndLabel(addressmuti, (__bridge CFStringRef)@"Singapore", kABPersonAddressCityKey, NULL);
            ABMultiValueAddValueAndLabel(addressmuti, (__bridge CFStringRef)postalCode, kABPersonAddressZIPKey, NULL);
            
            ABMultiValueAddValueAndLabel(addressmuti, (__bridge CFStringRef)@"Singapore", kABPersonAddressCountryKey, NULL);
            
            ABRecordSetValue(aRecord, kABPersonPhoneProperty, addressmuti, &anError);
            
            
            ABMutableMultiValueRef multiemail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
            ABMultiValueAddValueAndLabel(multiemail, (__bridge CFStringRef)email, kABWorkLabel, NULL);
            ABRecordSetValue(aRecord, kABPersonEmailProperty, multiemail, &anError);
            
            
            // Website
            /*
            ABMutableMultiValueRef multiweb = ABMultiValueCreateMutable(kABMultiStringPropertyType);
            ABMultiValueAddValueAndLabel(multiweb, (__bridge CFStringRef)contactWebSite, kABWorkLabel, NULL);
            ABRecordSetValue(aRecord, kABPersonURLProperty, multiweb, &anError);
            
            
            // Title
            ABRecordSetValue(aRecord, kABPersonJobTitleProperty, 
                             (__bridge CFStringRef)contactTitle, &anError);
            
            */
            
            if (anError != NULL) { 
                
                NSLog(@"error while creating..");
            } 
            
            
            ABAddressBookRef addressBook; 
            CFErrorRef error = NULL; 
            addressBook = ABAddressBookCreate(); 
            
            BOOL isAdded = ABAddressBookAddRecord (
                                                   addressBook,
                                                   aRecord,
                                                   &error
                                                   );
            if(isAdded){
                
            
                if (anError == NULL)
                {
                    ABUnknownPersonViewController *picker = [[ABUnknownPersonViewController alloc] init];
                   // picker.unknownPersonViewDelegate = self;
                    picker.displayedPerson = aRecord;
                    picker.allowsAddingToAddressBook = YES;
                    picker.allowsActions = YES;
                    picker.alternateName = firstName;
                    picker.title = firstName;
                    picker.message = companyName;
                    [self.navigationController pushViewController:picker animated:YES];
                    //[picker release];
                     
                    
                }
                if (error != NULL) {
                    NSLog(@"ABAddressBookAddRecord %@", error);
                } 
                /*
                error = NULL;
                
                BOOL isSaved = ABAddressBookSave (
                                                  addressBook,
                                                  &error
                                                  );
                
                if(isSaved){
                    
                    NSLog(@"saved..");
                    
                }
                else 
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                                    message:@"Could not create unknown user" 
                                                                   delegate:nil 
                                                          cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:nil];
                    [alert show];
                    //[alert release];
                }*/
                
            }
            
            
            /*
            
            if (error != NULL) {
                NSLog(@"ABAddressBookSave %@", error);
                return FALSE;
            } */
            
            CFRelease(aRecord); 
            CFRelease(multiemail);
            //CFRelease(multiweb);
            CFRelease(multi);
            CFRelease(addressBook);
            return  TRUE;
        }
        
        
    }   

    return FALSE;
    
}

#pragma mark ABUnknownPersonViewControllerDelegate methods
// Dismisses the picker when users are done creating a contact or adding the displayed person properties to an existing contact. 
- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownPersonView didResolveToPerson:(ABRecordRef)person
{
	[self dismissModalViewControllerAnimated:YES];
}


// Does not allow users to perform default actions such as emailing a contact, when they select a contact property.
- (BOOL)unknownPersonViewController:(ABUnknownPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person 
						   property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	return NO;
}




#pragma mark - Private

- (void)createShopAnnotation
{   
    _annotations=[[NSMutableArray alloc] init];
    [self getStoreList];
    CLLocationCoordinate2D aCoordinate;
    aCoordinate.latitude = 1.34000000;
    aCoordinate.longitude = 103.96000000;
    
	CLLocationCoordinate2D bCoordinate;
    bCoordinate.latitude = 1.34500000;
    bCoordinate.longitude = 103.96500000;
    
	CLLocationCoordinate2D cCoordinate;
    cCoordinate.latitude = 1.34900000;
    cCoordinate.longitude = 103.96900000;
    
	_aShopAnnotation = [[ShopAnnotation alloc] initWithCoordinate:aCoordinate title:@"Shop A" subtitle:@"Address A"];
    _bShopAnnotation = [[ShopAnnotation alloc] initWithCoordinate:bCoordinate title:@"Shop B" subtitle:@"Address B"];
    _cShopAnnotation = [[ShopAnnotation alloc] initWithCoordinate:cCoordinate title:@"Shop C" subtitle:@"Address C"];
    
    
	[_shopMap addAnnotation:_aShopAnnotation];
	[_shopMap addAnnotation:_bShopAnnotation];
	[_shopMap addAnnotation:_cShopAnnotation];
    
	[_annotations addObject:_aShopAnnotation];
	[_annotations addObject:_bShopAnnotation];
	[_annotations addObject:_cShopAnnotation];
}

@end
