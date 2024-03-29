//
//  NUSMapViewController.m
//  iMenu
//
//  Created by Kai HAN, Song Lei on 22/4/12.
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
        
        NSLog(@"Name: %@",[[store objectForKey:@"StoreID"] description]);
        NSLog(@"PostalCode: %@",[[store objectForKey:@"PostalCode"] description]); 
        NSLog(@"LocationX: %@",[[store objectForKey:@"LocationX"] description]); 
        NSLog(@"LocatoinY: %@",[[store objectForKey:@"LocatoinY"] description]);
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
   
    NSMutableArray *shopsArray = [[NSMutableArray alloc] initWithArray:[self getStoreList]];
    
    
    NSMutableDictionary *shopA = [shopsArray objectAtIndex:0];
    NSMutableDictionary *shopB = [shopsArray objectAtIndex:1];
    NSMutableDictionary *shopC = [shopsArray objectAtIndex:2];
    
    CLLocationCoordinate2D aCoordinate;
    aCoordinate.latitude = [[shopA objectForKey:@"LocationX"] doubleValue] ;
    aCoordinate.longitude = [[shopA objectForKey:@"LocatoinY"] doubleValue];
    
    NSLog(@"%s X=%f", __FUNCTION__, aCoordinate.latitude);
    NSLog(@"%s Y=%f", __FUNCTION__, aCoordinate.longitude);
    
	CLLocationCoordinate2D bCoordinate;
    bCoordinate.latitude = [[shopB objectForKey:@"LocationX"] doubleValue];
    bCoordinate.longitude = [[shopB objectForKey:@"LocatoinY"] doubleValue];
    
	CLLocationCoordinate2D cCoordinate;
    cCoordinate.latitude = [[shopC objectForKey:@"LocationX"] doubleValue];
    cCoordinate.longitude = [[shopC objectForKey:@"LocatoinY"] doubleValue];
    
   
	_aShopAnnotation = [[ShopAnnotation alloc] initWithCoordinate:aCoordinate title:[shopA objectForKey:@"Name"]  subtitle:[shopA objectForKey:@"PostalCode"]];
    _bShopAnnotation = [[ShopAnnotation alloc] initWithCoordinate:bCoordinate title:[shopB objectForKey:@"Name"]  subtitle:[shopB objectForKey:@"PostalCode"]];
    _cShopAnnotation = [[ShopAnnotation alloc] initWithCoordinate:cCoordinate title:[shopC objectForKey:@"Name"]  subtitle:[shopC objectForKey:@"PostalCode"]];
    
	[_shopMap addAnnotation:_aShopAnnotation];
	[_shopMap addAnnotation:_bShopAnnotation];
	[_shopMap addAnnotation:_cShopAnnotation];
    
	[_annotations addObject:_aShopAnnotation];
	[_annotations addObject:_bShopAnnotation];
	[_annotations addObject:_cShopAnnotation];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if([searchText length]== 0) 
    {
        NSLog(@"length=0");
        [searchBar resignFirstResponder];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{        
    //UIAlertView *orderAlert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Login First" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil, nil];
    
    //[orderAlert show];
    [self searchCoordinatesForAddress:[searchBar text]];
    
    //Hide the keyboard.
    [searchBar resignFirstResponder];
}

- (void) searchCoordinatesForAddress:(NSString *)inAddress
{
    //Build the string to Query Google Maps.
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@?output=json",inAddress];
    
    //Replace Spaces with a '+' character.
    [urlString setString:[urlString stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    
    //Create NSURL string from a formate URL string.
    NSURL *url = [NSURL URLWithString:urlString];
    
    //Setup and start an async download.
    //Note that we should test for reachability!.
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [connection delete:self];
    
    
}

//It's called when the results of [[NSURLConnection alloc] initWithRequest:request delegate:self] come back.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{   
    //The string received from google's servers
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //JSON Framework magic to obtain a dictionary from the jsonString.
    NSDictionary *results = [jsonString JSONValue];
    
    //Now we need to obtain our coordinates
    NSArray *placemark  = [results objectForKey:@"Placemark"];
    NSArray *coordinates = [[placemark objectAtIndex:0] valueForKeyPath:@"Point.coordinates"];
    
    double longitude = [[coordinates objectAtIndex:0] doubleValue];
    double latitude = [[coordinates objectAtIndex:1] doubleValue];
    
    //Debug.
    NSLog(@"Latitude - Longitude: %f %f", latitude, longitude);
    
    //zoom my map to the area in question.
    [self zoomMapAndCenterAtLatitude:latitude andLongitude:longitude];
    
}

- (void) zoomMapAndCenterAtLatitude:(double) latitude andLongitude:(double) longitude
{
    MKCoordinateRegion region;
    region.center.latitude  = latitude;
    region.center.longitude = longitude;
    
    //Set Zoom level using Span
    MKCoordinateSpan span;
    span.latitudeDelta  = .05;
    span.longitudeDelta = .05;
    region.span = span;
    
    //Move the map and zoom
    [_shopMap setRegion:region animated:YES];
}

@end
