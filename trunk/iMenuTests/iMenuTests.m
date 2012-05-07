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
    
    NSString *loginRequest = @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/Login";
    
    loginRequest = [loginRequest stringByAppendingFormat:@"?email=%@",@"zawmyotun82@googlemail"];
    loginRequest = [loginRequest stringByAppendingFormat:@"&password=%@",@"123456"];
    
    NUSWebService *webserviceModel = [[NUSWebService alloc] init];
    NSString *loginResult = [webserviceModel getRespone:loginRequest];
    
    NSString *result = [[NSString alloc] initWithFormat:@"%@", [webserviceModel getLoginResponse:loginResult]];
    NSString *expectedResult = [[NSString alloc] initWithFormat:@"1"];
    
    //0=Password Fail,1=Success,-2=User ID not found.
    STAssertTrue(expectedResult ,(NSString *)result,"login success");
    
}

-(void) testWebServiceLoginFailWithWrongPassword
{
    
    NSString *loginRequest = @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/Login";
    
    loginRequest = [loginRequest stringByAppendingFormat:@"?email=%@",@"zawmyotun82@googlemail"];
    loginRequest = [loginRequest stringByAppendingFormat:@"&password=%@",@"12345"];
    
    NUSWebService *webserviceModel = [[NUSWebService alloc] init];
    NSString *loginResult = [webserviceModel getRespone:loginRequest];
    
    NSString *result = [[NSString alloc] initWithFormat:@"%@", [webserviceModel getLoginResponse:loginResult]];
    NSString *expectedResult = [[NSString alloc] initWithFormat:@"0"];
    
    //0=Password Fail,1=Success,-2=User ID not found.
    STAssertTrue(expectedResult ,(NSString *)result,"login fail, wrong password");


}


-(void) testWebServiceLoginFailWithNotExistUserID
{
    
    NSString *loginRequest = @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/Login";
    
    loginRequest = [loginRequest stringByAppendingFormat:@"?email=%@",@"zawmyotun82@gmail.com"];
    loginRequest = [loginRequest stringByAppendingFormat:@"&password=%@",@"123456"];
    
    NUSWebService *webserviceModel = [[NUSWebService alloc] init];
    NSString *loginResult = [webserviceModel getRespone:loginRequest];
    
    NSString *result = [[NSString alloc] initWithFormat:@"%@", [webserviceModel getLoginResponse:loginResult]];
    NSString *expectedResult = [[NSString alloc] initWithFormat:@"-2"];
    
    //0=Password Fail,1=Success,-2=User ID not found.
    STAssertTrue(expectedResult ,(NSString *)result,"login fail, userid is not exist");
    
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

- (void)testWebServiceContactSignUp
{
    
    NSString *request = @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/Registeration?aUserName=Patty&aEmail=patty21@gmail.com&aMobilePh=917887654&aPassword=123456";
    NUSWebService *webserviceModel = [[NUSWebService alloc] init];
    NSString *orderSubmitResult = [webserviceModel getRespone:request];
    NSString *expectedResult = [[NSString alloc] initWithFormat:@"{\"result\":1,\"Reason\":\"\"}"];

    STAssertTrue(orderSubmitResult,expectedResult,@"it will return true");
    
    //[webserviceModel autorelease]
}





@end
