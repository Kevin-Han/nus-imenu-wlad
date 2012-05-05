//
//  NUSWebService.m
//  User
//
//  Created by Yuan Xiao dan on 1/5/12.
//  Copyright (c) 2012 patty.1984@hotmail.com. All rights reserved.
//

#import "NUSWebService.h"

@implementation NUSWebService


-(NSString *)getLoginResponse:(NSString *) webServiceResponse{
    
    
    NSRange start = [webServiceResponse rangeOfString:@"WS\">"];
    NSRange end = [webServiceResponse rangeOfString:@"</string>"];
    
    webServiceResponse = [webServiceResponse substringWithRange: 
                          NSMakeRange (start.location+4, end.location-(start.location+4))];
   
    NSLog(@"webServiceResponse %@",webServiceResponse);
    /*
    // for testing 
    webServiceResponse = [@"{\"result\":" stringByAppendingFormat:webServiceResponse];
    webServiceResponse = [webServiceResponse stringByAppendingFormat:@"}"];
    NSLog(@"webServiceResponse:%@",webServiceResponse);*/
    // for testing 

    SBJsonParser * parser = [[SBJsonParser alloc] init];  
    NSError * error = nil;  
    NSMutableDictionary *jsonDic = [parser objectWithString:webServiceResponse error:&error];  
    NSString * dicUserInfo = [jsonDic objectForKey:@"result"];
    NSLog(@"dicUserInfo %@",dicUserInfo);
    //dicUserInfo =[NSString stringWithFormat:@"%@",dicUserInfo];
    return dicUserInfo;

}




-(NSMutableArray *)getStoreResponse:(NSString *) webServiceResponse{
    
    
    // for method call testing 
    
    /*
     NSString *getStoreListRequest = 
     @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/GetStores";
     
     NUSWebService *webserviceModel = [[NUSWebService alloc] init];
     NSString *getStoreResult = [webserviceModel getRespone:getStoreListRequest];
     NSLog(@"login result%@", getStoreResult);
     
     NSMutableArray *stores = [webserviceModel getStoreResponse:getStoreResult];*/
    
    // for method call
    
    
    //NSRange start = [webServiceResponse rangeOfString:@"["];
    //NSRange end = [webServiceResponse rangeOfString:@"]"];
    
    //webServiceResponse = [webServiceResponse substringWithRange: 
                        //  NSMakeRange (start.location+1, end.location-(start.location+1))];
    
    NSRange start = [webServiceResponse rangeOfString:@"WS\">"];
    NSRange end = [webServiceResponse rangeOfString:@"</string>"];
    
    webServiceResponse = [webServiceResponse substringWithRange: 
                          NSMakeRange (start.location+4, end.location-(start.location+4))];

    
    
    
    NSLog(@"after trunct webServiceResponse:%@", webServiceResponse );
    
     // here is for the store test
    // webServiceResponse = [@"{\"storeList\":[" stringByAppendingFormat:webServiceResponse];
     //webServiceResponse = [webServiceResponse stringByAppendingFormat:@"]}"];
     
     // here is for the store test
     
    /* */
    
    SBJsonParser * parser = [[SBJsonParser alloc] init];  
    
    NSError * error = nil;  
    
    NSMutableDictionary *root = [[NSMutableDictionary alloc] initWithDictionary:[parser objectWithString:webServiceResponse error:&error]];  
     
    //SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];  
    
   // NSString *jsonString = [jsonWriter stringWithObject:root];   
    /*if (error!=NULL) {
        return  NULL;
    }*/
    
    //[jsonWriter release];  
    NSMutableArray * stores = [root objectForKey:@"storeList"];  
    for(NSMutableDictionary * store  in stores)  
    {  
        NSLog(@"%@",[[store objectForKey:@"StoreID"] description]);  
    } 
    

    return stores;
}
-(NSString *)getRespone:(NSString *) webServiceRequest{

    // for testing 
    //webServiceRequest = @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/Login?email=zawmyotun82@googlemail.com&password=123456";
    webServiceRequest = [webServiceRequest stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL *RequestURL=[NSURL URLWithString:[NSString 
                                            stringWithFormat:@"%@",webServiceRequest]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:RequestURL];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *response ;
    NSError *error;
    NSData *data;
    data = [NSURLConnection sendSynchronousRequest:request 
                                 returningResponse:&response error:&error];
    
    if(error!=NULL){
        return NULL;
    }
    NSString *result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
     // here is for the login test
        
    //NSLog(@" getRespone method result:%@",result );
    
    return result;

}

@end
