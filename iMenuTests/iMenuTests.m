//
//  iMenuTests.m
//  iMenuTests
//
//  Created by Song Lei on 22/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "iMenuTests.h"

@implementation iMenuTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}
- (void)testWebServiceGetRespone
{
    
    NSString *request = @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/Registeration?aUserName=Patty&aEmail=patty21@gmail.com&aMobilePh=917887654&aPassword=123456";
    NUSWebService *webserviceModel = [[NUSWebService alloc] init];
    NSString *orderSubmitResult = [webserviceModel getRespone:request];
    STAssertNotNil(orderSubmitResult,@"order Submit response is not nil");
    //[webserviceModel autorelease]
}


-(void) testWebServiceLoginSuccess
{
    
    NSString *loginRequest = @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/Login?email=zawmyotun82@googlemail.com&password=123456";
    
    NUSWebService *webserviceModel = [[NUSWebService alloc] init];
    NSString *loginResult = [webserviceModel getRespone:loginRequest];
    
    NSString *result = [[NSString alloc] initWithFormat:@"%@", [webserviceModel getLoginResponse:loginResult]];
    //0=Password Fail,1=Success,-2=User ID not found.
    int expectedResult = 1;
    STAssertTrue([result integerValue]==expectedResult,@"login success.");
    
}

-(void) testWebServiceLoginFailWithWrongPassword
{
    // email input wrong
    NSString *loginRequest = @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/Login?email=zawmyotun82@googlemail&password=12345";
    
    NUSWebService *webserviceModel = [[NUSWebService alloc] init];
    NSString *loginResult = [webserviceModel getRespone:loginRequest];
    
    NSString *result = [[NSString alloc] initWithFormat:@"%@", [webserviceModel getLoginResponse:loginResult]];
    //0=Password Fail,1=Success,-2=User ID not found.
    int expectedResult = -2;
    STAssertTrue([result integerValue]==expectedResult,@"login fail,User ID not found.");
}


-(void) testWebServiceLoginFailWithNotExistUserID
{
    
    NSString *loginRequest = @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/Login?email=zawmyotun82@gmail.com&password=123456";
    NUSWebService *webserviceModel = [[NUSWebService alloc] init];
    NSString *loginResult = [webserviceModel getRespone:loginRequest];
    
    NSString *result = [[NSString alloc] initWithFormat:@"%@", [webserviceModel getLoginResponse:loginResult]];
    int expectedResult = -2;
    STAssertTrue([result integerValue]==expectedResult,@"contact sign up fail");
    //0=Password Fail,1=Success,-2=User ID not found.
    
}


-(void) testWebServicGetStore
{
    
    NSString *getStoreListRequest = 
    @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/GetStores";
    
    NUSWebService *webserviceModel = [[NUSWebService alloc] init];
    NSString *getStoreResult = [webserviceModel getRespone:getStoreListRequest];
    STAssertNotNil(getStoreResult,@"get store list is not nil");
    
    
    NSMutableArray *stores = [webserviceModel getStoreResponse:getStoreResult];
    for(NSMutableDictionary * store  in stores)  
    {  
        STAssertNotNil([[store objectForKey:@"StoreID"] description],@"store id is not nil");
        
       
    } 
    
}
/**
 // this test case only can run once , so it is commentted

- (void)testWebServiceContactSignUpSuccess
{
    
    NSString *request = @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/Registeration?aUserName=Patty&aEmail=patty43@gmail.com&aMobilePh=917887654&aPassword=123456";
    NUSWebService *webserviceModel = [[NUSWebService alloc] init];
    NSString *loginResult = [webserviceModel getRespone:request];
    NSString *result = [[NSString alloc] initWithFormat:@"%@", [webserviceModel getLoginResponse:loginResult]];
    int expectedResult = 1;
    STAssertTrue([result integerValue]==expectedResult,@"contact sign up successfully");
    
    //[webserviceModel autorelease]
}
 */

- (void)testWebServiceContactSignUpFail
{
    
    NSString *request = @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/Registeration?aUserName=Patty&aEmail=patty43@gmail.com&aMobilePh=917887654&aPassword=123456";
    NUSWebService *webserviceModel = [[NUSWebService alloc] init];
    NSString *loginResult = [webserviceModel getRespone:request];
    NSString *result = [[NSString alloc] initWithFormat:@"%@", [webserviceModel getLoginResponse:loginResult]];
    int expectedResult = 0;
    STAssertTrue([result integerValue]==expectedResult,@"contact sign up fail");
}


- (void)testWebServiceForgotPasswordSuccess
{
    
    NSString *request = @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/ForgetPassword?email=pattyyuanxd@gmail.com";
    NUSWebService *webserviceModel = [[NUSWebService alloc] init];
    NSString *loginResult = [webserviceModel getRespone:request];
    NSString *result = [[NSString alloc] initWithFormat:@"%@", [webserviceModel getLoginResponse:loginResult]];
    int expectedResult = 1;
    STAssertTrue([result integerValue]==expectedResult,@"send request success");
}

- (void)testWebServiceForgotPasswordFail
{
    // the email address value is not exist 
    NSString *request = @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/ForgetPassword?email=pattyyuanxd1@gmail.com";
    NUSWebService *webserviceModel = [[NUSWebService alloc] init];
    NSString *loginResult = [webserviceModel getRespone:request];
    NSString *result = [[NSString alloc] initWithFormat:@"%@", [webserviceModel getLoginResponse:loginResult]];
    int expectedResult = 0;
    STAssertTrue([result integerValue]==expectedResult,@"send request fail, the email address not exist");
}


@end
