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
    NSLog(@"webServiceResponse %@",webServiceResponse);
    SBJsonParser * parser = [[SBJsonParser alloc] init];  
    NSError * error = nil;  
    NSMutableDictionary *jsonDic = [parser objectWithString:webServiceResponse error:&error];  
    NSString * dicUserInfo = [jsonDic objectForKey:@"result"];
    //dicUserInfo =[NSString stringWithFormat:@"%@",dicUserInfo];
    return dicUserInfo;

}


-(NSMutableDictionary *)getUserSignUpResponse:(NSString *) webServiceResponse{
    //http://aspspider.info/zmtun/MobileRestaurantWS.asmx/Registeration?aUserName=1&aEmail=patty2@gmail.com&aMobilePh=1&aPassword=1

    
    NSLog(@"webServiceResponse %@",webServiceResponse);
    SBJsonParser *parser = [[SBJsonParser alloc] init];  
    NSError *error = nil;  
    NSMutableDictionary *jsonDic = [parser objectWithString:webServiceResponse error:&error]; 
    /*if(error){
        return NULL;
    }
    
    
    NSString *dicUserInfo = [jsonDic objectForKey:@"result"];
    NSLog(@"dicUserInfo %@",dicUserInfo);
    //Reason
    NSString *reason = [jsonDic objectForKey:@"Reason"];
    if (reason) {
        reason = [dicUserInfo stringByAppendingFormat:@",%@",reason];
    }
    //dicUserInfo =[NSString stringWithFormat:@"%@",dicUserInfo];
    return dicUserInfo;
     */
    return jsonDic;

}




-(NSMutableArray *)getStoreResponse:(NSString *) webServiceResponse{
    /*
     NSString *getStoreListRequest = 
     @"http://aspspider.info/zmtun/MobileRestaurantWS.asmx/GetStores";
     */
    
    // for method call
    SBJsonParser * parser = [[SBJsonParser alloc] init];  
    
    NSError * error = nil;  
    
    NSMutableDictionary *root = [[NSMutableDictionary alloc] initWithDictionary:[parser objectWithString:webServiceResponse error:&error]];  
     
    /*if (error!=NULL) {
        return  NULL;
    }*/
    
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
    
    NSLog(@" webServiceRequest:%@",webServiceRequest );

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
    
    NSRange start = [result rangeOfString:@"WS\">"];
    NSRange end = [result rangeOfString:@"</string>"];
    
    result = [result substringWithRange: 
                          NSMakeRange (start.location+4, end.location-(start.location+4))];
        
    NSLog(@" getRespone:%@",result );
    
    return result;

}


-(NSMutableDictionary *)getOrderResponse:(NSString *) webServiceResponse{
    //http://aspspider.info/zmtun/MobileRestaurantWS.asmx/SubmitOrder?email=zawmyotun82@googlemail.com&storeid=1&isdelivery=true&status=3&deliverydate=2012-05-06&detailsJson=[{"ItemID":"A00001","Qty":1,"Price":10,"DiscountAmt":1}]
    
    
    NSLog(@"webServiceResponse %@",webServiceResponse);
   
    SBJsonParser *parser = [[SBJsonParser alloc] init];  
    NSError *error = nil;  
    NSMutableDictionary *jsonDic = [parser objectWithString:webServiceResponse error:&error]; 
    /*if(error){
     return NULL;
    }*/
    return jsonDic;

}

@end
